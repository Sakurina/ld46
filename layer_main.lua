MainLayer = Layer:extend()

function MainLayer:new()
    MainLayer.super.new(self)
    self.layer_name = "MainLayer"
    self.game_state = nil
    self:load_state()
    self.box_patch = patchy.load("gfx/textbox.9.png")

    -- calendar
    self.calendar = Calendar(12, 1)
    self.mode_queue = {"wait_for_text", "wait_for_any_input", "planning", "event_loop"}

    -- dialogue state
    self.textbox_string = "Theoretically, this text should word wrap and it shouldn't look weird."
    self.currently_shown_length = 0

    -- background and portrait
    self.background = nil
    self.portrait = love.graphics.newImage("gfx/portrait_egg.png")
end

-- CALLBACKS

function MainLayer:draw()
    -- background layer
    local bgc = constants.light_bg_color
    if self.background == nil then
        love.graphics.setColor(bgc.r, bgc.g, bgc.b, 1)
        love.graphics.rectangle("fill", 0, 0, 1280, 720) -- solid color
    else
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.background, 0, 0, 0, 3, 3) -- img scaled by 3
    end

    -- character portrait
    if self.portrait ~= nil then
        local sw, sh = love.graphics.getDimensions() -- screen width/height
        local pw, ph = self.portrait:getDimensions() -- portrait width/height
        local x = (sw - pw * 3) / 2
        local y = (sh - ph * 3) / 2 - 15
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.portrait, x, y, 0, 3, 3)
    end

    -- boxes
    local box_scale = 3
    love.graphics.push()
    love.graphics.scale(box_scale, box_scale)
    love.graphics.setColor(1, 1, 1, 1)
    local cal_x, cal_y, cal_w, cal_h = self.box_patch:draw(0, 0, 240 / box_scale, 240 / box_scale) -- calendar
    local dec_x, dec_y, dec_w, dec_h = self.box_patch:draw(1040 / box_scale, 0, 240 / box_scale, 240 / box_scale) -- decisions
    local txt_x, txt_y, txt_w, txt_h = self.box_patch:draw(0, 480 / box_scale, 1280 / box_scale, 240 / box_scale) -- textbox
    love.graphics.pop()

    cal_x = cal_x * box_scale
    cal_y = cal_y * box_scale
    cal_w = cal_w * box_scale
    cal_h = cal_h * box_scale

    dec_x = dec_x * box_scale
    dec_y = dec_y * box_scale
    dec_w = dec_w * box_scale
    dec_h = dec_h * box_scale

    txt_x = txt_x * box_scale + box_scale * 12
    txt_y = txt_y * box_scale + box_scale * 6
    txt_w = txt_w * box_scale - box_scale * 12
    txt_h = txt_h * box_scale - box_scale * 6

    local txt = constants.system_txt_color
    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    -- calendar string
    local date = lume.format("Y{1} M{2}\nDay {3}", { self.calendar.year, self.calendar.month, self.calendar.current_day })
    love.graphics.printf(date, cal_x, cal_y, cal_w, "center")

    -- textbox string
    local chopped = string.sub(self.textbox_string, 1, self.currently_shown_length)
    love.graphics.printf(chopped, txt_x, txt_y, txt_w, "left")
    love.graphics.setScissor()
end

function MainLayer:update(dt)
    if self.currently_shown_length < #self.textbox_string then
        -- dialogue increment
        self.currently_shown_length = self.currently_shown_length + 1
    elseif lume.first(self.mode_queue) == "wait_for_text" then
        self:pop_current_mode()
    elseif lume.first(self.mode_queue) == "planning" then
        return
    elseif lume.first(self.mode_queue) == "story" then
        local story = self.calendar:todays_story()
        story:next_line()
        if story.complete == true then
            self.calendar:todays_story_handled()
            self:pop_current_mode()
        else
            local line = story.lines[story.current_line]
            if string_begins_with(line, "#portrait ") then
                local path = string.gsub(line, "#portrait ", "")
                if path ~= "none" then
                    self.portrait = love.graphics.newImage(path)
                else
                    self.portrait = nil
                end
            elseif string_begins_with(line, "#bg ") then
                local path = string.gsub(line, "#bg ", "")
                if path ~= "none" then
                    self.background = love.graphics.newImage(path)
                else
                    self.background = nil
                end
            else
                self:set_textbox_string(story.lines[story.current_line])
            end
        end
    elseif lume.first(self.mode_queue) == "event_loop" then
        if self.calendar:daily_event_needs_handling_today() == false and self.calendar:story_needs_handling_today() == false then
            self.calendar:next_day()
        end

        if self.calendar.complete == true then
            -- update calendar
            local year = self.calendar.year
            local month = self.calendar.month + 1
            if month > 12 then
                month = month - 12
                year = year + 1
            end
            self.calendar = Calendar(year, month)

            -- return to planning mode
            self:start_of_new_month(year, month)
        else 
            -- still events to do
            if self.calendar:story_needs_handling_today() then
                local story = self.calendar:todays_story()
                if story:meets_preconditions(self.game_state.stats) then
                    self.mode_queue = { "story", "event_loop" }
                else
                    self.calendar:todays_story_handled()
                end
            elseif self.calendar:daily_event_needs_handling_today() then
                local event = self.calendar:todays_daily_event()
                event:determine_outcome({}) -- passing lifestyle choices todo
                self:set_textbox_string(event.outcome_text)
                self:apply_stat_growths(self.game_state, event.stat_growths)
                self.calendar:todays_daily_event_handled()
            end
        end
    end
end

function MainLayer:keypressed(key, scancode, isrepeat)
    local current_mode = lume.first(self.mode_queue)
    if current_mode == "wait_for_text" then
        self:wait_for_text_input()
    elseif current_mode == "wait_for_any_input" then
        self:wait_for_any_input_input()
    elseif current_mode == "planning" then
        if key == layer_manager.controls["Schedule"] then
            self:spawn_schedule_layer()
        elseif key == layer_manager.controls["Lifestyle"] then
            self:spawn_lifestyle_layer()
        elseif key == layer_manager.controls["Stats"] then
            self:spawn_stats_layer()
        end
    end
end

function MainLayer:keyreleased(key, scancode)
    return
end

function MainLayer:mousepressed(x, y, button, istouch, presses)
    local current_mode = lume.first(self.mode_queue)
    if current_mode == "wait_for_text" then
        self:wait_for_text_input()
    elseif current_mode == "wait_for_any_input" then
        self:wait_for_any_input_input()
    elseif current_mode == "planning" then
        self:pop_current_mode()
    end
end

-- GAME LOGIC

function MainLayer:wait_for_text_input()
    self.currently_shown_length = #self.textbox_string
end

function MainLayer:wait_for_any_input_input()
    self:pop_current_mode()
end

function MainLayer:spawn_schedule_layer()
    layer_manager:prepend(ScheduleLayer(self.calendar))
end

function MainLayer:spawn_lifestyle_layer()
    layer_manager:prepend(LifestyleLayer())
end

function MainLayer:spawn_stats_layer()
    layer_manager:prepend(StatsLayer(self.game_state.stats))
end

function MainLayer:start_of_new_month(y, m)
    -- return mode queue to a predictable state to avoid bugs distributed across codebase
    self.currently_shown_length = 0
    self.textbox_string = lume.format("It is now the first day of Year {1} Month {2}!", { y, m })
    self.mode_queue = { "wait_for_text", "wait_for_any_input", "planning", "event_loop" }
end

function MainLayer:set_textbox_string(str)
    self.currently_shown_length = 0
    self.textbox_string = str
    local prepend_modes = { "wait_for_text", "wait_for_any_input" }
    self.mode_queue = lume.concat(prepend_modes, self.mode_queue)
end

function MainLayer:pop_current_mode()
    self.mode_queue = lume.last(self.mode_queue, #self.mode_queue - 1)
    if self.mode_queue == nil then
        self.mode_queue = {}
    end
end

function MainLayer:append_mode(mode)
    self.mode_queue = lume.concat(self.mode_queue, { mode })
end

function MainLayer:apply_stat_growths(state, stat_growths)
    lume.each(stat_growths, function(sg)
        local target_stat = sg.impacted_stat
        local original_value = state.stats[target_stat]
        state.stats[target_stat] = original_value + sg.outcome
        if state.stats[target_stat] > constants.stat_caps[target_stat] then
            state.stats[target_stat] = constants.stat_caps[target_stat]
        elseif target_stat ~= "money" and state.stats[target_stat] < 0 then
            state.stats[target_stat] = 0
        end
    end)
end

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
        self.game_state = default_game_state
    end
end

function MainLayer:save_state()
    local as_json = json.encode(self.game_state)
    love.filesystem.write("game_state.json", as_json)
end