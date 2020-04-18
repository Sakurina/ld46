Layer = Object:extend()

function Layer:new()
    self.layer_name = "Layer"
    self.paused = false
    self.propagate_draw_to_underlying = true
    self.propagate_update_to_underlying = true
    self.propagate_input_to_underlying = true
end

function Layer:pause()
    log(lume.format("[{1}] Layer paused", { self.layer_name }))
    self.paused = true
end

function Layer:resume()
    log(lume.format("[{1}] Layer resumed", { self.layer_name }))
    self.paused = false
end

-- CALLBACKS

function Layer:draw()
    return
end

function Layer:update(dt)
    return
end

function Layer:keypressed(key, scancode, isrepeat)
    return
end

function Layer:keyreleased(key, scancode)
    return
end

function Layer:mousepressed(x, y, button, istouch, presses)
    return
end

function Layer:mousereleased(x, y, button, istouch, presses)
    return
end

function Layer:mousemoved(x, y, dx, dy, istouch)
    return
end