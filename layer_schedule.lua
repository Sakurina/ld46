ScheduleLayer = Layer:extend()

function ScheduleLayer:new(calendar)
    ScheduleLayer.super.new(self)
    self.layer_name = "ScheduleLayer"
    self.calendar = calendar
    self.current_week = 1
    self.propagate_input_to_underlying = false
    self.box_patch = patchy.load("gfx/textbox.9.png")

    self.events = { "Gym", "Karaoke", "Library", "Study", "Part-Time Job", "Nap" }
    self.cached_week_row_rects = {}
    self.cached_weekday_col_rects = {}
    self.cached_weekday_rects = {}
    self.cached_event_rects = {}
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

    local cal_x = 60
    local cal_y = 60
    local cal_w = 115 * 7
    local cal_h = 100 * 6

    -- column A "calendar view" / 2/3
    local txt = constants.system_txt_color
    local em = constants.db16_col12
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
                y = cal_y + 100 * (w - 1),
                w = cal_w,
                h = 100
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
                x = cal_x + 115 * (wd - 1),
                y = cal_y,
                w = 115,
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
                x = cal_x + 115 * (day:day_of_week()),
                y = cal_y + 100 * (day.week_num - 1),
                w = 115,
                h = 100
            }
        end
        local rect = self.cached_weekday_rects[day.day]
        love.graphics.printf(day.day, rect.x, rect.y, rect.w, "center")
    end)

    -- column B "activity choices" / 1/3
    local act_x = cal_x + cal_w + 30
    local index = 1
    local this_week = lume.filter(self.calendar.days, function(d) return d.week_num == self.current_week end)

    lume.each(self.events, function(id)
        if self.cached_event_rects[id] == nil then
            self.cached_event_rects[id] = {
                x = act_x,
                y = cal_y + constants.unit_menu_height_per_item * index,
                w = 1220 - act_x - 60,
                h = constants.unit_menu_height_per_item
            }
        end
        local rect = self.cached_event_rects[id]
        local is_current_selection = #this_week > 0 and this_week[1].daily_event ~= nil and this_week[1].daily_event.event_name == id
        if is_current_selection then
            love.graphics.setColor(em.r, em.g, em.b, 1)
        else
            love.graphics.setColor(txt.r, txt.g, txt.b, 1)
        end
        love.graphics.printf(id, rect.x, rect.y, rect.w, "center")
        index = index + 1
    end)

    love.graphics.setColor(txt.r, txt.g, txt.b, 1)
    love.graphics.print(lume.format("Week {1}", { self.current_week }), act_x, cal_y)
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
    end
end

function ScheduleLayer:mousepressed(x, y, button, istouch, presses)
    log(lume.format("[{1}] click at {2}, {3}", { self.layer_name, x, y }))

    -- check for collision with a week row
    for week, rect in ipairs(self.cached_week_row_rects)
    do
        local left_x = rect.x
        local right_x = rect.x + rect.w
        local top_y = rect.y
        local bottom_y = rect.y + rect.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            log(lume.format("[{1}] week clicked: {2}", { self.layer_name, week }))
            self.current_week = week
            return
        end
    end

    for id, rect2 in pairs(self.cached_event_rects)
    do
        local left_x = rect2.x
        local right_x = rect2.x + rect2.w
        local top_y = rect2.y
        local bottom_y = rect2.y + rect2.h
        if x >= left_x and x <= right_x and y >= top_y and y <= bottom_y then
            log(lume.format("[{1}] event clicked: {2}", { self.layer_name, id }))
            self.calendar:set_week_event(self.current_week, self:event_for_id(id))
            return
        end
    end
end

function ScheduleLayer:event_for_id(id)
    if id == "Gym" then
        return GymEvent()
    elseif id == "Karaoke" then
        return KaraokeEvent()
    elseif id == "Library" then
        return LibraryEvent()
    elseif id == "Study" then
        return StudyEvent()
    elseif id == "Part-Time Job" then
        return JobEvent()
    elseif id == "Nap" then
        return NapEvent()
    end
end