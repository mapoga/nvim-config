local Spinner = {
    timer = nil,
    freq = 100,
    frames = {},
    idx = 1,
    on_incr = nil,
}
Spinner.__index = Spinner

function Spinner:new(opts)
    opts = opts or {}
    local inst = setmetatable({}, Spinner)
    inst.timer = vim.uv.new_timer()
    inst.freq = opts.freq or 100
    inst.frames = opts.frames or { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    inst.on_incr = opts.on_incr
    inst.on_incr_opts = opts.on_incr_opts or {}
    return inst
end

function Spinner:frame()
    return self.frames[self.idx]
end

function Spinner:incr()
    local idx = self.idx + 1
    idx = ((idx - 1) % #self.frames) + 1
    self.idx = idx
    if self.on_incr then
        self.on_incr { spinner = self, opts = self.on_incr_opts }
    end
end

function Spinner:stop()
    if self.timer then
        self.timer:stop()
    end
end

function Spinner:start()
    self.timer:start(
        0,
        self.freq,
        vim.schedule_wrap(function()
            self:incr()
        end)
    )
end

return { Spinner = Spinner }
