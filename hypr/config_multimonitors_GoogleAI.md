local workspaces_per_monitor = 10

local function create_workspaces(monitor)
    for i = 1, workspaces_per_monitor do
        hl.workspace_rule({
            workspace = tostring(monitor.id * workspaces_per_monitor + i),
            monitor = monitor.name,
            default = (i == 1),
        })
    end
end

for _, monitor in ipairs(hl.get_monitors()) do
    create_workspaces(monitor)
end

hl.on("monitor.added", create_workspaces)

