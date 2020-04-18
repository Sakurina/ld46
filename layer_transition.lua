TransitionLayer = Layer:extend()

function TransitionLayer:new(from, to)
    TransitionLayer.super.new(self)
    self.layer_name = "TransitionLayer"
    self.total_time = 1
    self.time_elapsed = 0
    self.apex_handled = 0
    self.complete = 0
    self.from_layer = from
    self.to_layer = to
end

-- CALLBACKS
function TransitionLayer:draw()
    if self.complete == 0 then
        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
        local half = self.total_time / 2
        local opacity = 0
        if self.time_elapsed <= half then
            opacity = self.time_elapsed / half
        else
            opacity = 1 - ((self.time_elapsed - half) / half)
        end
        love.graphics.setColor(0, 0, 0, opacity)
        love.graphics.rectangle('fill', 0, 0, width, height)
    end
end

function TransitionLayer:update(dt)
    if self.paused == 1 then
        return
    end

    local half = self.total_time / 2

    if self.time_elapsed == 0 then
        self:enter_transition()
    elseif self.time_elapsed >= half and self.apex_handled == 0 then
        self:apex_reached()
    elseif self.time_elapsed > self.total_time then
        self:end_transition()
    end

    self.time_elapsed = self.time_elapsed + dt
end

function TransitionLayer:keypressed(key, scancode, isrepeat)
    return
end

function TransitionLayer:keyreleased(key, scancode)
    return
end

-- FUNCTIONALITY

function TransitionLayer:enter_transition()
    log(lume.format("[{1}] Entered transition", { self.layer_name }))
    self.from_layer:pause()
    self.to_layer:pause()
end

function TransitionLayer:apex_reached()
    log(lume.format("[{1}] Transition apex reached", { self.layer_name }))
    layer_manager:remove_last()
    layer_manager:append(self.to_layer)
    self.apex_handled = 1
end

function TransitionLayer:end_transition()
    log(lume.format("[{1}] Transition ended", { self.layer_name }))
    self.to_layer:resume()
    layer_manager:remove_first()
    self.complete = 1
end