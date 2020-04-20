MenuLayer = Layer:extend()

function MenuLayer:new()
    MenuLayer.super.new(self)
    self.layer_name = "MenuLayer"
    self.selected_index = 1
    self.items = { "Play", "Controls", "Quit" }
    self.logo = love.graphics.newImage("gfx/title.png")

end

-- CALLBACKS
-- 195x162
function MenuLayer:draw()
    local bgc = constants.dark_bg_color
    local em = constants.emphasis_color
    local deem = constants.deemphasis_color
    local win_w = love.graphics.getWidth()
    local win_h = love.graphics.getHeight()
    love.graphics.setFont(constants.big_font)
    love.graphics.setColor(bgc.r, bgc.g, bgc.b, 1.0)
    love.graphics.rectangle('fill', 0, 0, win_w, win_h)


    local logo_w, logo_h = self.logo:getPixelDimensions()
    logo_w = logo_w * 3
    logo_h = logo_h * 3
    local logo_x = (win_w - logo_w) / 2
    local logo_y = (win_h - logo_h) / 2 - 150
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.logo, logo_x, logo_y, 0, 3)

    for i = 1, #self.items do
        if i == self.selected_index then
            love.graphics.setColor(em.r, em.g, em.b, 1.0)
        else
            love.graphics.setColor(deem.r, deem.g, deem.b, 1.0)
        end
        local y = 223 + 50 + i * constants.unit_menu_height_per_item
        love.graphics.print(self.items[i], 543, y)
    end
end

function MenuLayer:update(dt)
    return
end

function MenuLayer:keypressed(key, scancode, isrepeat)
    if self.paused == 1 then
        return
    end
    if isrepeat == true then
        return
    end

    if key == layer_manager.controls["Up"] then
        self:previous_item()
    elseif key == layer_manager.controls["Down"] then
        self:next_item()
    elseif key == layer_manager.controls["Confirm"] then
        self:select_item()
    elseif key == 'p' then
        local layer = EndingPromptLayer()
        layer_manager:prepend(layer)
    end
end

function MenuLayer:keyreleased(key, scancode)
    return
end

-- FUNCTIONALITY 

function MenuLayer:previous_item()
    local dest = self.selected_index - 1
    if dest < 1 then
        dest = #self.items
    end
    self.selected_index = dest
end

function MenuLayer:next_item()
    local dest = self.selected_index + 1
    if dest > #self.items then
        dest = 1
    end
    self.selected_index = dest
end

function MenuLayer:select_item()
    log(lume.format("[{1}] Index {2} selected", { self.layer_name, self.selected_index }))
    local destination_layer = null
    if self.selected_index == 1 then
        destination_layer = NamesLayer()
    end
    if self.selected_index == 2 then
        destination_layer = ControlsLayer()
    end
    if destination_layer ~= nil then
        layer_manager:transition(self, destination_layer)
    end
    if self.selected_index == 3 then
        love.event.push('quit')
    end
end