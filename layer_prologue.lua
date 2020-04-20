PrologueLayer = Layer:extend()

function PrologueLayer:new(story)
    PrologueLayer.super.new(self)
    self.story = story
    self.layer_name = "PrologueLayer"
    self.mode_queue = {"story", "logo"}
    self.box_patch = patchy.load("gfx/textbox.9.png")

    self.textbox_string = ""
    self.currently_shown_length = 0

    self.blinky_icon = love.graphics.newImage("gfx/icon_next.png")
    self.blinky_rect = { x = 1280 - 30 - 15, y = 720 - 30 - 30, w = 15, h = 30 }
    self.show_blinker = true
    self.blinky_counter = 0
end

function PrologueLayer:draw()
    -- background layer
    local bgc = constants.dark_bg_color
    love.graphics.setColor(bgc.r, bgc.g, bgc.b, 1)
    love.graphics.rectangle("fill", 0, 0, 1280, 720)

    -- boxes
    local box_scale = 3
    love.graphics.push()
    love.graphics.scale(box_scale, box_scale)
    love.graphics.setColor(1, 1, 1, 1)
    local txt_x, txt_y, txt_w, txt_h = self.box_patch:draw(0, 480 / box_scale, 1280 / box_scale, 240 / box_scale) -- textbox
    love.graphics.pop()

    txt_x = txt_x * box_scale + box_scale * 12
    txt_y = txt_y * box_scale + box_scale * 6
    txt_w = txt_w * box_scale - (box_scale * 12) * 2
    txt_h = txt_h * box_scale - (box_scale * 6) * 2

    -- text and blinker
    local txt = constants.system_txt_color
    love.graphics.setFont(constants.big_font)
    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    local chopped = string.sub(self.textbox_string, 1, self.currently_shown_length)
    love.graphics.printf(chopped, txt_x, txt_y, txt_w, "left")
    if lume.first(self.mode_queue) == "wait_for_any_input" and self.show_blinker then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.blinky_icon, self.blinky_rect.x, self.blinky_rect.y, 0, 3)
    end
    love.graphics.setScissor()
end

function PrologueLayer:update(dt)
    if lume.first(self.mode_queue) == "logo" then
        self.mode_queue = {}
        layer_manager:transition(self, MenuLayer())
    elseif self.currently_shown_length < #self.textbox_string then
        -- dialogue increment
        self.currently_shown_length = self.currently_shown_length + 1
    elseif lume.first(self.mode_queue) == "wait_for_text" then
        self:pop_current_mode()
    elseif lume.first(self.mode_queue) == "wait_for_any_input" then
        if self.blinky_counter == 20 then
            self.blinky_counter = 0
            if self.show_blinker then
                self.show_blinker = false
            else
                self.show_blinker = true
            end
        else
            self.blinky_counter = self.blinky_counter + 1
        end
    elseif lume.first(self.mode_queue) == "story" then
        local story = self.story
        story:next_line()
        if story.complete == true then
            self:pop_current_mode()
        else
            local line = story.lines[story.current_line]
            self:set_textbox_string(story.lines[story.current_line])
        end
    end
end

function PrologueLayer:keypressed(key, scancode, isrepeat)
    local current_mode = lume.first(self.mode_queue)
    if key == layer_manager.controls["Back"] then
        self.mode_queue = { "logo" }
    elseif current_mode == "wait_for_text" then
        self:wait_for_text_input()
    elseif current_mode == "wait_for_any_input" then
        self:wait_for_any_input_input()
    end
end

function PrologueLayer:mousepressed(x, y, button, istouch, presses)
    local current_mode = lume.first(self.mode_queue)
    if current_mode == "wait_for_text" then
        self:wait_for_text_input()
    elseif current_mode == "wait_for_any_input" then
        self:wait_for_any_input_input()
    end
end

function PrologueLayer:wait_for_text_input()
    self.currently_shown_length = #self.textbox_string
end

function PrologueLayer:wait_for_any_input_input()
    self:pop_current_mode()
end

function PrologueLayer:set_textbox_string(str)
    self.currently_shown_length = 0
    self.textbox_string = str
    local prepend_modes = { "wait_for_text", "wait_for_any_input" }
    self.mode_queue = lume.concat(prepend_modes, self.mode_queue)
end

function PrologueLayer:pop_current_mode()
    self.mode_queue = lume.last(self.mode_queue, #self.mode_queue - 1)
    if self.mode_queue == nil then
        self.mode_queue = {}
    end
end