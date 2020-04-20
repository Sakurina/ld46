NamesLayer = Layer:extend()

function NamesLayer:new()
    self.focus_field = "taker"
    self.taker_name = ""
    self.giver_name = ""

    local row_h = constants.unit_menu_height_per_item
    local field_col_x = 0
    local field_col_w = 640 - 15
    local value_col_x = 640 + 15
    local taker_row_y = 253
    local giver_row_y = taker_row_y + row_h
    local error_row_y = giver_row_y + row_h
    self.label_rects = {
        taker = {
            x = field_col_x, 
            y = taker_row_y, 
            w = field_col_w,
            h = row_h
        },
        giver = {
            x = field_col_x,
            y = giver_row_y,
            w = field_col_w,
            h = row_h
        }
    }
    self.value_rects = {
        taker = {
            x = value_col_x,
            y = taker_row_y,
            w = field_col_w,
            h = row_h
        },
        giver = {
            x = value_col_x,
            y = giver_row_y,
            w = field_col_w,
            h = row_h
        }
    }
    self.show_error = false
    self.error_rect = {
        x = 0,
        y = error_row_y,
        w = 1280,
        h = row_h,
    }
    local go_row_y = error_row_y + row_h
    self.go_icon = love.graphics.newImage("gfx/icon_go.png")
    self.go_rect = {
        x = (1280 - 45) / 2,
        y = go_row_y,
        w = 45,
        h = 45
    }
    log(self.go_rect.y + self.go_rect.h)
end

function NamesLayer:draw(dt)
    local bgc = constants.dark_bg_color
    local txt = constants.system_txt_color
    local em = constants.emphasis_color

    love.graphics.setColor(bgc.r, bgc.g, bgc.b, 1)
    love.graphics.rectangle("fill", 0, 0, 1280, 720)

    if self.focus_field == "taker" then
        love.graphics.setColor(em.r, em.g, em.b, 1)
    else
        love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    end
    local t_rect = self.label_rects["taker"]
    love.graphics.printf("Your name:", t_rect.x, t_rect.y, t_rect.w, "right")

    if self.focus_field == "giver" then
        love.graphics.setColor(em.r, em.g, em.b, 1)
    else
        love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    end
    local g_rect = self.label_rects["giver"]
    love.graphics.printf("Child's name:", g_rect.x, g_rect.y, g_rect.w, "right")

    local tv_rect = self.value_rects["taker"]
    local gv_rect = self.value_rects["giver"]
    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    love.graphics.printf(self.taker_name, tv_rect.x, tv_rect.y, tv_rect.w, "left")
    love.graphics.printf(self.giver_name, gv_rect.x, gv_rect.y, gv_rect.w, "left")

    if self.show_error then
        local red = constants.db16_col7
        love.graphics.setColor(red.r, red.g, red.b, 1)
        love.graphics.printf("names are required!", self.error_rect.x, self.error_rect.y, self.error_rect.w, "center")
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.go_icon, self.go_rect.x, self.go_rect.y, 0, 3)
end

function NamesLayer:keypressed(key, scancode, isrepeat)
    if isrepeat == true then
        return
    end

    local alpha = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
    local is_alpha = lume.any(alpha, function(a) return a == key end)
    if key == "tab" then
        if self.focus_field == "taker" then
            self.focus_field = "giver"
        elseif self.focus_field == "giver" then
            self.focus_field = "taker"
        end
    elseif key == "backspace" then
        if self.focus_field == "taker" then
            self.taker_name = string.sub(self.taker_name, 1, #self.taker_name - 1)
        elseif self.focus_field == "giver" then
            self.giver_name = string.sub(self.giver_name, 1, #self.giver_name - 1)
        end
    elseif key == layer_manager.controls["Confirm"] then
        self:lets_mosey()
    elseif is_alpha then
        if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
            key = string.upper(key)
        end
        if self.focus_field == "taker" then
            self.taker_name = self.taker_name .. key
        elseif self.focus_field == "giver" then
            self.giver_name = self.giver_name .. key
        end
    end
end

function NamesLayer:mousepressed(x, y, button, istouch, presses)
    -- Focus
    for id, rect in pairs(self.label_rects)
    do
        local left_x = rect.x
        local right_x = rect.x + rect.w
        local top_y = rect.y
        local bottom_y = rect.y + rect.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            self.focus_field = id
            return
        end
    end
    
    for id, rect in pairs(self.value_rects)
    do
        local left_x = rect.x
        local right_x = rect.x + rect.w
        local top_y = rect.y
        local bottom_y = rect.y + rect.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            self.focus_field = id
            return
        end
    end

    -- Go Button
    local go_left_x = self.go_rect.x
    local go_right_x = self.go_rect.x + self.go_rect.w
    local go_top_y = self.go_rect.y
    local go_bottom_y = self.go_rect.y + self.go_rect.h
    if x >= go_left_x and x <= go_right_x and y >= go_top_y and y <= go_bottom_y then
        self:lets_mosey()
        return
    end
end

function NamesLayer:lets_mosey()
    if self:validate() then
        default_game_state.character_name = self.giver_name
        default_game_state.caregiver_name = self.taker_name
        local layer = MainLayer()
        layer_manager:transition(self, layer)
    end
end

function NamesLayer:validate()
    if self.taker_name == nil or self.taker_name == "" or self.giver_name == "" or self.giver_name == nil then
        self.show_error = true
        return false
    else 
        self.show_error = false
        return true
    end
end