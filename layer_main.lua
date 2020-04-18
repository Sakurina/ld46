MainLayer = Layer:extend()

function MainLayer:new()
    MainLayer.super.new(self)
    self.layer_name = "MainLayer"
    self.game_state = nil
    --self:load_state()
end

-- CALLBACKS

function MainLayer:draw()
    return
end

function MainLayer:update(dt)
    return
end

function MainLayer:keypressed(key, scancode, isrepeat)
    return
end

function MainLayer:keyreleased(key, scancode)
    return
end

-- GAME LOGIC

-- SAVE DATA
function MainLayer:load_state()
    local state_json_info = {} 
    love.filesystem.getInfo("game_state.json", controls_json_info)
    if state_json_info.size ~= nil then
        log("[MainLayer] Loading game state from the JSON file")
        local contents, size = love.filesystem.read("state.json")
        self.game_state = json.decode(contents)
    else
        log("[MainLayer] Game state file not found, loading default state")
        self.game_state = lume.clone(default_game_state)
    end
end

function MainLayer:save_state()
    local as_json = json.encode(self.game_state)
    love.filesystem.write("game_state.json", as_json)
end