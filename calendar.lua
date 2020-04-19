Calendar = Object:extend()

function Calendar:new(year, month)
    self.year = year
    self.month = month
    self.current_day = 1
    self.started = false
    self.complete = false

    local daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    local daysInYear = lume.reduce(daysInMonth, function(a,b) return a + b end)
    local daysInYearUntilNow = lume.reduce(lume.slice(daysInMonth, 1, month - 1), function(a,b) return a + b end, 0)
    local startingOffset = year * daysInYear + daysInYearUntilNow
    self.days = {}
    local week_num = 1
    for i = 1, daysInMonth[month], 1
    do
        local thisDay = CalendarDay(i, startingOffset)
        if i > 1 and thisDay:day_of_week() == 0 then
            week_num = week_num + 1
        end
        thisDay.week_num = week_num
        if month == 2 and i == 1 then
            thisDay.story = AlwaysTestStory()
        elseif month == 3 and i == 15 then
            thisDay.story = PreconTestStory()
        end
        self.days[i] = thisDay
    end
end

function Calendar:week_count()
    return lume.count(lume.unique(lume.map(self.days, function(d) return d.week_num end)))
end

function Calendar:set_week_event(week_num, event)
    local daysInWeek = lume.map(lume.filter(self.days, function(d) return d.week_num == week_num end), function(d) return d.day end)
    lume.each(daysInWeek, function(day)
        self.days[day]:set_daily_event(event)
    end)
end

function Calendar:next_day()
    if self.started == false then
        self.started = true
    elseif self.current_day == lume.count(self.days) then
        self.complete = true
    else
        self.current_day = self.current_day + 1
    end
end

function Calendar:daily_event_needs_handling_today()
    return self.started and self.days[self.current_day]:daily_event_needs_handling()
end

function Calendar:todays_daily_event()
    return self.days[self.current_day].daily_event
end

function Calendar:story_needs_handling_today()
    return self.started and self.days[self.current_day]:story_needs_handling()
end

function Calendar:todays_story()
    return self.days[self.current_day].story
end

function Calendar:todays_daily_event_handled()
    self.days[self.current_day]:mark_daily_event_handled()
end

function Calendar:todays_story_handled()
    self.days[self.current_day]:mark_story_handled()
end