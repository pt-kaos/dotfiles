-- LICENSE: 0BSD
-- per monitor workspaces
local workspaces_per_monitor = 10
local wrap_around = false
local function create_workspaces(monitor)
  for i = 1, workspaces_per_monitor do
    hl.workspace_rule({
      workspace = tostring(monitor.id * workspaces_per_monitor + i),
      monitor = monitor.name,
      -- persistent = true,
      default = (i == 1),
    })
  end
end
for _, monitor in ipairs(hl.get_monitors()) do
  create_workspaces(monitor)
end
hl.on("monitor.added", create_workspaces)

local function get_active_monitor_id()
  local monitor = hl.get_active_monitor()
  return monitor and monitor.id or 0
end

local function get_relative_workspace_index(forwards)
  local current_workspace = hl.get_active_workspace()
  if not current_workspace then return nil end
  local index = current_workspace.id % workspaces_per_monitor
  if index == 0 then index = workspaces_per_monitor end
  -- yandere dev style /s
  if forwards then
    index = index + 1
    if index > workspaces_per_monitor then
      if wrap_around then
        index = 1
      else
        return nil
      end
    end
  else
    index = index - 1
    if index < 1 then
      if wrap_around then
        index = workspaces_per_monitor
      else
        return nil
      end
    end
  end
  return index
end

local function activate_workspace(number)
  return function ()
    local monitor_id = get_active_monitor_id()
    hl.dispatch(hl.dsp.focus({workspace = tostring(monitor_id * workspaces_per_monitor + number)}))
  end
end

local function move_to_workspace(number)
  return function ()
    local monitor_id = get_active_monitor_id()
    hl.dispatch(hl.dsp.window.move({workspace = tostring(monitor_id * workspaces_per_monitor + number), follow = true}))
  end
end

local function activate_workspace_relative(forwards)
  return function ()
    local monitor_id = get_active_monitor_id()
    local index = get_relative_workspace_index(forwards)
    if not index then return end
    hl.dispatch(hl.dsp.focus({workspace = tostring(monitor_id * workspaces_per_monitor + index)}))
  end
end

local function move_to_workspace_relative(forwards)
  return function ()
    local monitor_id = get_active_monitor_id()
    local index = get_relative_workspace_index(forwards)
    if not index then return end
    hl.dispatch(hl.dsp.window.move({workspace = tostring(monitor_id * workspaces_per_monitor + index), follow = true}))
  end
end

for i = 1, math.min(workspaces_per_monitor, 10) do
  local key = tostring(i % 10)
  hl.bind("SUPER + " .. key, activate_workspace(i))
  hl.bind("SUPER + SHIFT + " .. key, move_to_workspace(i))
end
hl.bind("SUPER + mouse_up", activate_workspace_relative(true))
hl.bind("SUPER + mouse_down", activate_workspace_relative(false))
hl.bind("SUPER + CTRL + right", activate_workspace_relative(true))
hl.bind("SUPER + CTRL + left", activate_workspace_relative(false))
hl.bind("SUPER + ALT + right", move_to_workspace_relative(true))
hl.bind("SUPER + ALT + left", move_to_workspace_relative(false))
