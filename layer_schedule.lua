ScheduleLayer = Layer:extend()

function ScheduleLayer:new(calendar)
    ScheduleLayer.super.new(self)
    self.layer_name = "ScheduleLayer"
    self.calendar = calendar
    self.current_week = 1
    self.propagate_input_to_underlying = false
    self.box_patch = patchy.load("gfx/textbox.9.png")

    self.skill_events = { 
        constants.cook_event.id, 
        constants.gym_event.id, 
        constants.karaoke_event.id, 
        constants.library_event.id, 
        constants.study_event.id 
    }
    self.work_events = { 
        constants.black_event.id, 
        constants.delivery_event.id, 
        constants.lab_event.id 
    }
    self.rest_events = { 
        constants.nap_event.id, 
        constants.vacation_event.id
    }
    self.current_set = "skill_events"
    self.events = self.skill_events

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

    self.costs = {}
    self.costs[constants.gym_event.id] = lume.format("-${1}/day", { 0 - constants.gym_event.cost_per_day })
    self.costs[constants.karaoke_event.id] = lume.format("-${1}/day", { 0 - constants.karaoke_event.cost_per_day })
    self.costs[constants.library_event.id] = lume.format("-${1}/day", { 0 - constants.library_event.cost_per_day })
    self.costs[constants.study_event.id] = lume.format("-${1}/day", { 0 - constants.study_event.cost_per_day })
    self.costs[constants.vacation_event.id] = lume.format("-${1}/day", { 0 - constants.vacation_event.cost_per_day })
    self.costs[constants.black_event.id] = lume.format("+${1}~${2}/day", { constants.black_event.income_per_day_regular, constants.black_event.income_per_day_lucky })
    self.costs[constants.delivery_event.id] = lume.format("+${1}~${2}/day", { constants.delivery_event.income_per_day_regular, constants.delivery_event.income_per_day_lucky })
    self.costs[constants.lab_event.id] = lume.format("+${1}~${2}/day", { constants.lab_event.income_per_day_regular, constants.lab_event.income_per_day_lucky })

    self.cached_week_row_rects = {}
    self.cached_weekday_col_rects = {}
    self.cached_weekday_rects = {}
    self.cached_event_rects = {}
    self.cached_selector_rects = {}
end

function ScheduleLayer:draw(dt)
    -- bg
    local bgc = constants.dark_bg_color
    love.graphics.setColor(bgc.r, bgc.g, bgc.b, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1280, 720)

    -- box
    local box_scale = 3
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.push()
    love.graphics.scale(3, 3)
    local x, y, w, h = self.box_patch:draw(30 / box_scale, 30 / box_scale, 1220 / box_scale, 660 / box_scale)
    love.graphics.pop()

    x = x * box_scale
    y = y * box_scale
    w = w * box_scale
    h = h * box_scale

    local cell_width = 45
    local cell_height = 45
    local cal_x = 60
    local cal_y = 60
    local cal_w = cell_width * 7
    local cal_h = cell_height * 6

    -- column A "calendar view" / 2/3
    local txt = constants.system_txt_color
    local em = constants.db16_col12
    local deem = constants.deemphasis_color

    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    love.graphics.rectangle("line", cal_x, cal_y, cal_w, cal_h)

    -- week rows
    for w = 1, 6, 1
    do
        if w == self.current_week then
            -- set highlight color
            love.graphics.setColor(em.r, em.g, em.b, 1)
        else
            -- set no color
            love.graphics.setColor(0, 0, 0, 0)
        end

        if self.cached_week_row_rects[w] == nil then
            self.cached_week_row_rects[w] = {
                x = cal_x,
                y = cal_y + cell_height * (w - 1),
                w = cal_w,
                h = cell_height
            }
        end
        local rect = self.cached_week_row_rects[w]

        love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)
        love.graphics.setColor(txt.r, txt.g, txt.b, 1)
        love.graphics.rectangle("line", rect.x, rect.y, rect.w, rect.h)
    end

    -- weekday columns
    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    for wd = 1, 7, 1
    do
        if self.cached_weekday_col_rects[wd] == nil then
            self.cached_weekday_col_rects[wd] = {
                x = cal_x + cell_width * (wd - 1),
                y = cal_y,
                w = cell_width,
                h = cal_h,
            }
        end
        local rect = self.cached_weekday_col_rects[wd]
        love.graphics.rectangle("line", rect.x, rect.y, rect.w, rect.h)
    end

    -- dates and icons
    lume.each(self.calendar.days, function(day)
        if self.cached_weekday_rects[day.day] == nil then
            self.cached_weekday_rects[day.day] = {
                x = cal_x + cell_width * (day:day_of_week()),
                y = cal_y + cell_height * (day.week_num - 1),
                w = cell_width,
                h = cell_height
            }
        end
        local rect = self.cached_weekday_rects[day.day]
        if day.daily_event ~= nil then
            love.graphics.setColor(1, 1, 1, 0.5)
            love.graphics.draw(self.icons[day.daily_event.event_name], rect.x, rect.y, 0, 3, 3)
        end
        love.graphics.setColor(txt.r, txt.g, txt.b, 1)
        love.graphics.setFont(constants.smol_font)
        love.graphics.printf(day.day, rect.x, rect.y, rect.w - 6, "right")
    end)

    love.graphics.setFont(constants.big_font)

    -- column B "activity choices" / 1/3


    local act_x = cal_x + cal_w + 30
    local act_txt_x = act_x + 45 + 15

    local selector_index = 1
    local selectors = { "skill_events", "work_events", "rest_events" }
    local selector_width = (1220 - act_x) / 3
    lume.each(selectors, function(id)
        if self.cached_selector_rects[id] == nil then
            self.cached_selector_rects[id] = {
                x = act_x + selector_width * (selector_index - 1),
                y = cal_y,
                w = selector_width,
                h = constants.unit_menu_height_per_item
            }
        end
        local rect = self.cached_selector_rects[id]
        local name = ""
        if id == "skill_events" then
            name = "Skills"
        elseif id == "work_events" then
            name = "Work"
        elseif id == "rest_events" then
            name = "Rest"
        end
        local is_current_selection = id == self.current_set
        if is_current_selection then
            love.graphics.setColor(em.r, em.g, em.b, 1)
        else
            love.graphics.setColor(txt.r, txt.g, txt.b, 1)
        end
        love.graphics.printf(name, rect.x, rect.y, rect.w, "center")
        selector_index = selector_index + 1
    end)

    local index = 1
    local this_week = lume.filter(self.calendar.days, function(d) return d.week_num == self.current_week end)

    lume.each(self.events, function(id)
        if self.cached_event_rects[id] == nil then
            self.cached_event_rects[id] = {
                x = act_txt_x,
                y = cal_y + constants.unit_menu_height_per_item * (index) + 15,
                w = 1220 - act_x - 60,
                h = constants.unit_menu_height_per_item
            }
        end
        local rect = self.cached_event_rects[id]
        -- icon
        love.graphics.setColor(1, 1, 1, 1)
        local icon_y = rect.y + (constants.unit_menu_height_per_item - 45) / 2
        love.graphics.draw(self.icons[id], act_x, icon_y, 0, 3, 3)

        -- text
        local is_current_selection = #this_week > 0 and this_week[1].daily_event ~= nil and this_week[1].daily_event.event_name == id
        if is_current_selection then
            love.graphics.setColor(em.r, em.g, em.b, 1)
        else
            love.graphics.setColor(txt.r, txt.g, txt.b, 1)
        end
        love.graphics.printf(id, rect.x, rect.y, rect.w, "left")
        local cost = self.costs[id]

        if cost ~= nil then
            love.graphics.setColor(deem.r, deem.g, deem.b, 1)
            love.graphics.printf(cost, rect.x, rect.y, rect.w, "right")
        end

        index = index + 1
    end)

    --love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    --love.graphics.print(lume.format("Week {1}", { self.current_week }), act_x, cal_y)
end

function ScheduleLayer:keypressed(key, scancode, isrepeat)
    if isrepeat == true then
        return
    end

    if key == layer_manager.controls["Back"] then
        layer_manager:remove_first()
    elseif key == layer_manager.controls["Up"] then
        if self.current_week > 1 then
            self.current_week = self.current_week - 1
        end
    elseif key == layer_manager.controls["Down"] then
        if self.current_week < self.calendar:week_count() then
            self.current_week = self.current_week + 1
        end
    elseif key == layer_manager.controls["Left"] then
        self:previous_set()
    elseif key == layer_manager.controls["Right"] then
        self:next_set()
    end
end

function ScheduleLayer:mousepressed(x, y, button, istouch, presses)
    -- check for collision with a week row
    for week, rect in ipairs(self.cached_week_row_rects)
    do
        local left_x = rect.x
        local right_x = rect.x + rect.w
        local top_y = rect.y
        local bottom_y = rect.y + rect.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            self.current_week = week
            return
        end
    end
    -- check for collision with an event
    for id, rect2 in pairs(self.cached_event_rects)
    do
        local left_x = rect2.x
        local right_x = rect2.x + rect2.w
        local top_y = rect2.y
        local bottom_y = rect2.y + rect2.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            self.calendar:set_week_event(self.current_week, self:event_for_id(id))
            return
        end
    end
    -- check for collision with a selector
    for id, rect3 in pairs(self.cached_selector_rects)
    do
        local left_x = rect3.x
        local right_x = rect3.x + rect3.w
        local top_y = rect3.y
        local bottom_y = rect3.y + rect3.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            self:switch_visible_set(id)
            return
        end
    end
end

function ScheduleLayer:previous_set()
    if self.current_set == "skill_events" then
        self:switch_visible_set("rest_events")
    elseif self.current_set == "rest_events" then
        self:switch_visible_set("work_events")
    elseif self.current_set == "work_events" then
        self:switch_visible_set("skill_events")
    end
end

function ScheduleLayer:next_set()
    if self.current_set == "skill_events" then
        self:switch_visible_set("work_events")
    elseif self.current_set == "rest_events" then
        self:switch_visible_set("skill_events")
    elseif self.current_set == "work_events" then
        self:switch_visible_set("rest_events")
    end
end

function ScheduleLayer:switch_visible_set(set)
    self.current_set = set
    self.events = self[set]
    self.cached_event_rects = {}
end

function ScheduleLayer:event_for_id(id)
    if id == constants.cook_event.id then
        return CookEvent()
    elseif id == constants.gym_event.id then
        return GymEvent()
    elseif id == constants.karaoke_event.id then
        return KaraokeEvent()
    elseif id == constants.library_event.id then
        return LibraryEvent()
    elseif id == constants.study_event.id then
        return StudyEvent()
    elseif id == constants.black_event.id then
        return BlackEvent()
    elseif id == constants.delivery_event.id then
        return DeliveryEvent()
    elseif id == constants.lab_event.id then
        return LabEvent()
    elseif id == constants.nap_event.id then
        return NapEvent()
    elseif id == constants.vacation_event.id then
        return VacationEvent()
    end
end