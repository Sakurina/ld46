Story = Object:extend()

function Story:new()
    self.preconditions = {}
    self.lines = {}

    self.current_line = 1
    self.started = false
    self.complete = false
end

function Story:meets_preconditions(stats)
    if #self.preconditions == 0 then
        return true
    end
    return lume.all(self.preconditions, function(p) return p:evaluate(stats) end)
end

function Story:next_line()
    if self.started == false then
        self.started = true
    elseif self.current_line == lume.count(self.lines) then
        self.complete = true
    else
        self.current_line = self.current_line + 1
    end
end