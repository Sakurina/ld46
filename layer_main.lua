MainLayer = Layer:extend()

function MainLayer:new()
    MainLayer.super.new(self)
    self.layer_name = "MainLayer"
    self.game_state = nil
    self:load_state()
    self.box_patch = patchy.load("gfx/textbox.9.png")

    -- calendar
    self.calendar = Calendar(self.game_state.current_year, self.game_state.current_month)
    self.mode_queue = {"story", "planning", "event_loop"}

    -- dialogue state
    self.textbox_string = ""
    self.currently_shown_length = 0

    -- background and portrait
    self.background = nil
    self.portrait = love.graphics.newImage("gfx/portrait_egg.png")

    self.icons = {}
    self.icons[constants.black_event.id] = love.graphics.newImage(constants.black_event.icon)
    self.icons[constants.delivery_event.id] = love.graphics.newImage(constants.delivery_event.icon)
    self.icons[constants.lab_event.id] = love.graphics.newImage(constants.lab_event.icon)
    self.icons[constants.gym_event.id] = love.graphics.newImage(constants.gym_event.icon)
    self.icons[constants.karaoke_event.id] = love.graphics.newImage(constants.karaoke_event.icon)
    self.icons[constants.library_event.id] = love.graphics.newImage(constants.library_event.icon)
    self.icons[constants.study_event.id] = love.graphics.newImage(constants.study_event.icon)
    self.icons[constants.cook_event.id] = love.graphics.newImage(constants.cook_event.icon)
    self.icons[constants.nap_event.id] = love.graphics.newImage(constants.nap_event.icon)
    self.icons[constants.vacation_event.id] = love.graphics.newImage(constants.vacation_event.icon) 
    self.icons[constants.acct_event.id] = love.graphics.newImage(constants.acct_event.icon)
    self.icons[constants.resto_event.id] = love.graphics.newImage(constants.resto_event.icon)

    self.stats_icon = love.graphics.newImage("gfx/icon_stats.png")
    self.stats_rect = { x = 1205 + 12, y = 30, w = 45, h = 45 }
    self.schedule_icon = love.graphics.newImage("gfx/icon_schedule.png")
    self.schedule_rect = { x = 1205 + 12, y = 30 + 45 + 12, w = 45, h = 45 }
    self.go_icon = love.graphics.newImage("gfx/icon_go.png")
    self.go_rect = { x = 1205 + 12, y = 30 + 45 + 12 + 45 + 12, w = 45 , h = 45 }
    self.blinky_icon = love.graphics.newImage("gfx/icon_next.png")
    self.blinky_rect = { x = 1280 - 30 - 15, y = 720 - 30 - 30, w = 15, h = 30 }
    self.show_blinker = true
    self.blinky_counter = 0
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
    local cal_x, cal_y, cal_w, cal_h = self.box_patch:draw(0, 0, 240 / box_scale, 219 / box_scale) -- calendar
    local txt_x, txt_y, txt_w, txt_h = self.box_patch:draw(0, 480 / box_scale, 1280 / box_scale, 240 / box_scale) -- textbox
    if lume.first(self.mode_queue) == "planning" then
        local dec_x, dec_y, dec_w, dec_h = self.box_patch:draw(1199 / box_scale, 0, 81 / box_scale, 219 / box_scale) -- menu
    end
    love.graphics.pop()

    cal_x = cal_x * box_scale + box_scale * 12
    cal_y = cal_y * box_scale + box_scale * 6
    cal_w = cal_w * box_scale - (box_scale * 12) * 2
    cal_h = cal_h * box_scale - (box_scale * 6) * 2

    txt_x = txt_x * box_scale + box_scale * 12
    txt_y = txt_y * box_scale + box_scale * 6
    txt_w = txt_w * box_scale - (box_scale * 12) * 2
    txt_h = txt_h * box_scale - (box_scale * 6) * 2

    if lume.first(self.mode_queue) == "planning" then
        love.graphics.draw(self.stats_icon, self.stats_rect.x, self.stats_rect.y, 0, 3)
        love.graphics.draw(self.schedule_icon, self.schedule_rect.x, self.schedule_rect.y, 0, 3)
        love.graphics.draw(self.go_icon, self.go_rect.x, self.go_rect.y, 0, 3)
    end

    local txt = constants.system_txt_color
    local deem = constants.deemphasis_color
    -- calendar string
    local line1 = self.calendar:formatted_week_day()
    local line2 = self.calendar:formatted_date()
    local line3 = lume.format("{1}", { self.calendar.year })
    local line1_y = cal_y
    local line2_y = cal_y + constants.unit_menu_height_per_item
    local line3_y = line2_y + constants.unit_menu_height_per_item
    love.graphics.setColor(deem.r, deem.g, deem.b, 1)
    love.graphics.printf(line1, cal_x, line1_y, cal_w, "left")
    love.graphics.printf(line3, cal_x, line3_y, cal_w, "left")
    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    love.graphics.printf(line2, cal_x, line2_y, cal_w, "left")
    
    local day = self.calendar.days[self.calendar.current_day]
    if day.daily_event ~= nil then
        local icon_x = cal_x + cal_w - 45
        local icon_y = line3_y + (constants.unit_menu_height_per_item - 45) / 2 + 3
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.icons[day.daily_event.event_name], icon_x, icon_y, 0, 3, 3)
    end

    -- textbox string
    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    local chopped = string.sub(self.textbox_string, 1, self.currently_shown_length)
    love.graphics.printf(chopped, txt_x, txt_y, txt_w, "left")
    if lume.first(self.mode_queue) == "wait_for_any_input" and self.show_blinker then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.blinky_icon, self.blinky_rect.x, self.blinky_rect.y, 0, 3)
    end

    love.graphics.setScissor()
end

function MainLayer:update(dt)
    if self.currently_shown_length < #self.textbox_string then
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
    if key == layer_manager.controls["Back"] then
        self:story_skip()
    elseif current_mode == "wait_for_text" then
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

function MainLayer:story_skip()
    if lume.first(self.mode_queue) == "wait_for_text" then
        self:pop_current_mode()
    end
    if lume.first(self.mode_queue) == "wait_for_any_input" then
        self:pop_current_mode()
    end
    if lume.first(self.mode_queue) == "story" then
        self.calendar:todays_story_handled()
        self:pop_current_mode()
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
        local stats_left_x = self.stats_rect.x
        local stats_right_x = self.stats_rect.x + self.stats_rect.w
        local stats_top_y = self.stats_rect.y
        local stats_bottom_y = self.stats_rect.y + self.stats_rect.h

        if x >= stats_left_x and x <= stats_right_x and y >= stats_top_y and y <= stats_bottom_y then
            self:spawn_stats_layer()
            return
        end

        local sched_left_x = self.schedule_rect.x
        local sched_right_x = self.schedule_rect.x + self.schedule_rect.w
        local sched_top_y = self.schedule_rect.y
        local sched_bottom_y = self.schedule_rect.y + self.schedule_rect.h

        if x >= sched_left_x and x <= sched_right_x and y >= sched_top_y and y <= sched_bottom_y then
            self:spawn_schedule_layer()
            return
        end

        local go_left_x = self.go_rect.x
        local go_right_x = self.go_rect.x + self.go_rect.w
        local go_top_y = self.go_rect.y
        local go_bottom_y = self.go_rect.y + self.go_rect.h

        if x >= go_left_x and x <= go_right_x and y >= go_top_y and y <= go_bottom_y then
            self:pop_current_mode()
            return
        end
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
    self.textbox_string = "It's the first of the month! Time to plan some more activities!"
    self.mode_queue = { "wait_for_text", "wait_for_any_input", "planning", "event_loop" }
end

function MainLayer:set_textbox_string(str)
    if self.game_state ~= nil then
        str = lume.format(str, { self.game_state.character_name })
    end
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