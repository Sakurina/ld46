LifestyleLayer = Layer:extend()

function LifestyleLayer:new()
    LifestyleLayer.super.new(self)
    self.layer_name = "LifestyleLayer"
    self.propagate_input_to_underlying = false
end

function LifestyleLayer:draw(dt)
    -- bg
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1280, 720)
end

function LifestyleLayer:keypressed(key, scancode, isrepeat)
    if isrepeat == true then
        return
    end

    if key == layer_manager.controls["Back"] then
        layer_manager:remove_first()
    end
end