ControlsOverlayLayer = Layer:extend()

function ControlsOverlayLayer:new()
    ControlsOverlayLayer.super.new(self)
    self.layer_name = "ControlsOverlayLayer"
    self.dismissed = false
    self.propagate_input_to_underlying = false
    self.table_key = "unset"
end

-- CALLBACKS

function ControlsOverlayLayer:draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
end

function ControlsOverlayLayer:update(dt)
    return
end

function ControlsOverlayLayer:keypressed(key, scancode, isrepeat)
    if self.dismissed == false then
        self.dismissed = true
        layer_manager:remove_first()
        layer_manager:topmost():resume()
        layer_manager:topmost():register_binding(self.table_key, key)
    end
end

function ControlsOverlayLayer:keyreleased(key, scancode)
    return
end