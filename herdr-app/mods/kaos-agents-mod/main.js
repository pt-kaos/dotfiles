// kaos-agents-mod
// Card-based agent dashboard: one card per agent, with a color-coded
// status indicator (orange = running, gray = idle, red = waiting for input,
// green = completed) and the agent's program icon as the "screen".

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { image, svg } from "gpui-kit";
import {
  agents,
  focused,
  run,
  theme,
  setAgentOrder,
  openOverlay,
  closeOverlay,
  props,
  window,
  layout,
} from "herdr";

// Status colors: orange = running, gray = idle, red = waiting for input
// (blocked), green = completed (done).
const STATUS = {
  working: "#e8833a",
  idle: "#999999",
  blocked: "#e06060",
  done: "#60c060",
};

const STATUS_LABEL = {
  working: "RUNNING",
  idle: "IDLE",
  blocked: "BLOCKED",
  done: "COMPLETED",
};

// Priority order for sorting: blocked > done > working > idle.
const RANK = { blocked: 4, done: 3, working: 2, idle: 1 };

function duration(ms) {
  const m = Math.floor(ms / 60000);
  if (m < 1) return "<1m";
  if (m < 60) return `${m}m`;
  const h = Math.floor(m / 60);
  return h < 24 ? `${h}h` : `${Math.floor(h / 24)}d`;
}

// The agent's program icon (claude, codex, hermes, ...), used as the "screen" in
// the card. Tinted SVGs take the text colour; pictures are drawn full colour.
function icon(p, size, color) {
  if (!p?.icon) return null;
  return p.tint
    ? svg(p.icon).size(size).flex_none().text_color(color)
    : image(p.icon).w(size).h(size).flex_none();
}

export default class KaosAgents extends View {
  init(_props, cx) {
    this.changed = JSON.parse(localStorage.getItem("kaos.agents.changed") ?? "{}");
    cx.timer.every(30000, (cx) => cx.notify());
  }

  track(list, now) {
    let dirty = false;
    for (const a of list) {
      const s = a.status === "done" ? "idle" : a.status;
      if (this.changed[a.address]?.s === s) continue;
      this.changed[a.address] = { s, at: now };
      dirty = true;
    }
    if (!dirty) return;
    const listed = new Set(list.map((a) => a.address));
    for (const [k, c] of Object.entries(this.changed)) {
      if (!listed.has(k) && now - c.at > 30 * 86400000) delete this.changed[k];
    }
    localStorage.setItem("kaos.agents.changed", JSON.stringify(this.changed));
  }

  since(a) {
    return this.changed[a.address]?.at ?? 0;
  }

  render(cx) {
    const t = theme();
    const list = agents();
    const now = Date.now();
    this.track(list, now);

    // Sort by priority (blocked > done > working > idle), then oldest first.
    const sorted = [...list].sort((a, b) => {
      const ra = RANK[a.status] ?? 0;
      const rb = RANK[b.status] ?? 0;
      if (ra !== rb) return rb - ra;
      return (a.seq ?? 0) - (b.seq ?? 0);
    });

    // Group into status sections, most urgent first.
    const sections = [];
    for (const a of sorted) {
      const sec = { working: "Running", idle: "Idle", blocked: "Waiting for you", done: "Completed" }[a.status];
      if (!sec) continue;
      const last = sections.at(-1);
      if (last && last.id === a.status) {
        last.members.push(a);
      } else {
        sections.push({ id: a.status, label: sec, color: STATUS[a.status], members: [a] });
      }
    }

    // The most urgent section for the header count.
    const mostUrgent = sections.reduce((m, s) => {
      const rank = RANK[s.id] ?? 0;
      const mRank = m ? RANK[m.id] ?? 0 : -1;
      return rank > mRank ? s : m;
    }, null);

    const header = v_flex()
      .px(16)
      .h(41)
      .pt(14)
      .pb(5)
      .flex_none()
      .items_center()
      .justify_between()
      .child(
        h_flex()
          .gap(9)
          .child(svg("mods/workspace-chrome/agent.svg").size(16).flex_none().text_color("#555555"))
          .child(div().text_size(11.5).font_medium().text_color("#555555").child("AGENTS")),
      )
      .child(
        h_flex()
          .gap(6)
          .child(
            div()
              .text_color(mostUrgent?.color ?? "#555555")
              .font_semibold()
              .child(mostUrgent ? `${mostUrgent.members.length} ${STATUS_LABEL[mostUrgent.id]}` : ""),
          )
          .child(svg("mods/workspace-chrome/clock.svg").size(14).flex_none().text_color("#555555")),
      );

    const card = (a) => {
      const isFocused = focused()?.agent === a.address;
      const pic = icon(a.program, 32, t.foreground);
      const status = a.status;
      const stColor = STATUS[status] ?? t.dim;
      const stLabel = STATUS_LABEL[status] ?? status.toUpperCase();
      const since = this.since(a);
      const dur = since ? duration(now - since) : "";

      const name = a.name || a.template || a.program?.name || a.address;
      const workspace = a.space_name || "";

      return h_flex()
        .id(`kaos-agent-${a.address}`)
        .px(10)
        .py(9)
        .flex_none()
        .rounded(10)
        .items_center()
        .gap(12)
        .when(isFocused, (el) => el.bg(t.selected))
        .hover((s) => s.bg(t.hover))
        .on_click(() => (a.pane ? run("pane.focus", { pane: a.pane }) : run("pane.focus", { terminal: a.address })))
        .child(
          pic || div().size(32).rounded(8).items_center().justify_center().text_color("#555555"),
        )
        .child(
          v_flex()
            .flex_1()
            .min_w(0)
            .gap(4)
            .children([
              h_flex()
                .flex_1()
                .min_w(0)
                .gap(10)
                .items_center()
                .justify_between()
                .truncate()
                .child(
                  div()
                    .text_color(stColor)
                    .font_semibold()
                    .child(stLabel),
                )
                .child(div().text_color("#555555").text_size(11).child(dur)),
              div()
                .truncate()
                .text_color("#ffffff")
                .font_semibold()
                .child(name),
              div().truncate().text_color("#555555").text_size(11).child(workspace),
            ]),
        );
    };

    const sectionEl = (sec) => {
      const top = sec.members.reduce((m, a) => ((RANK[a.status] ?? 0) > (RANK[m] ?? 0) ? a.status : m), null);
      return h_flex()
        .id(`sec-${sec.id}`)
        .px(10)
        .pt(10)
        .pb(6)
        .flex_none()
        .gap(6)
        .items_center()
        .text_size(11)
        .font_medium()
        .text_color(sec.color)
        .child(h_flex().flex_1().min_w(0).truncate().child(sec.label))
        .child(div().text_color("#555555").child(`${sec.members.length}`));
    };

    const rows = sections.flatMap((sec) => [sectionEl(sec), ...sec.members.map(card)]);

    return v_flex()
      .size_full()
      .min_h(0)
      .bg(t.chrome)
      .border_t(1)
      .border_color(t.border)
      .text_size(13)
      .child(header)
      .when(list.length === 0, (el) =>
        el.child(
          div().px(12).text_size(12).text_color("#555555").child(
            "No agent status yet. Agents show up here when they report their status.",
          ),
        ),
      )
      .child(v_flex().id("kaos-list").flex_1().min_h(0).px(8).overflow_y_scrollbar().mode("always").children(rows));
  }
}
