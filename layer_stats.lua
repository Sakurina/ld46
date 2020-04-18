StatsLayer = Layer:extend()

function StatsLayer:new()
    StatsLayer.super.new(self)
    self.layer_name = "StatsLayer"
    self.box_patch = patchy.load("gfx/textbox.9.png")
    self.propagate_input_to_underlying = false
end

function StatsLayer:draw(dt)
    local box_scale = 3
    love.graphics.push()
    love.graphics.scale(box_scale, box_scale)
    love.graphics.setColor(1, 1, 1, 1)
    local txt_x, txt_y, txt_w, txt_h = self.box_patch:draw(0, 480 / box_scale, 1280 / box_scale, 240 / box_scale) -- textbox
    love.graphics.pop()
end

function StatsLayer:keypressed(key, scancode, isrepeat)
    if isrepeat == true then
        return
    end

    if key == layer_manager.controls["Back"] then
        layer_manager:remove_first()
    end
end

function StatsLayer:mousepressed(x, y, button, istouch, presses)
    layer_manager:remove_first()
end