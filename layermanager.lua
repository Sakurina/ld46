LayerManager = Object:extend()

function LayerManager:new()
    LayerManager.super.new(self)
    self.first = 0
    self.last = -1
    self.controls = {
        Up = "w",
        Down = "s",
        Left = "a",
        Right = "d",
        Confirm = "return",
        Back = "escape"
    }
end

-- LAYER MANAGEMENT

function LayerManager:topmost()
    return self[self.first]
end

function LayerManager:bottommost()
    return self[self.last]
end

function LayerManager:append(layer)
    log(lume.format("[LayerManager] Appending layer {1}", { layer.layer_name }))
    local last = self.last + 1
    self.last = last
    self[last] = layer
end

function LayerManager:prepend(layer)
    log(lume.format("[LayerManager] Prepending layer {1}", { layer.layer_name }))
    local first = self.first - 1
    self.first = first
    self[first] = layer
end

function LayerManager:remove_first()
    local first = self.first
    log(lume.format("[LayerManager] Removing first layer ({1})", { self[first].layer_name }))
    if first > self.last then error('list is empty') end
    self[first] = nil
    self.first = first + 1
end

function LayerManager:remove_last()
    local last = self.last
    log(lume.format("[LayerManager] Removed last layer ({1})", { self[last].layer_name }))
    if self.first > last then error('list is empty') end
    self[last] = nil
    self.last = last - 1
end

-- HELPERS

function LayerManager:transition(from, to)
    log(lume.format("[LayerManager] Transition invoked from {1} to {2}", { from.layer_name, to.layer_name }))
    local transition_layer = TransitionLayer(from, to)
    self:prepend(transition_layer)
end

function LayerManager:reload_controls()
    local controls_json_info = {} 
    love.filesystem.getInfo("controls.json", controls_json_info)
    if controls_json_info.size ~= nil then
        log("[LayerManager] Reloading controls from existing controls.json file")
        local contents, size = love.filesystem.read("controls.json")
        self.controls = json.decode(contents)
    else
        log("[LayerManager] Reloading controls failed, using defaults")
    end
end

-- CALLBACK PROPAGATION

function LayerManager:draw()
    for i = self.last, self.first, -1 do
        local layer = self[i]
        layer:draw()
        if layer.propagate_draw_to_underlying ~= true then
            return
        end
    end
end

function LayerManager:update(dt)
    for i = self.first, self.last do
        local layer = self[i]
        layer:update(dt)
        if layer.propagate_update_to_underlying ~= true then
            return
        end
    end
end

function LayerManager:keypressed(key, scancode, isrepeat)
    for i = self.first, self.last do
        local layer = self[i]
        layer:keypressed(key, scancode, isrepeat)
        if layer.propagate_input_to_underlying ~= true then
            return
        end
    end
end

function LayerManager:keyreleased(key, scancode)
    for i = self.first, self.last do
        local layer = self[i]
        layer:keyreleased(key, scancode)
    end
end
