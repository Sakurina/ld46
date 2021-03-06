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

        if year == 3018 and month == 12 and i >= 18 and i <= 24 then
            thisDay.sick = true
        end

        if year == 3014 and month == 1 and i == 1 then
            thisDay.story = FirstContactStory()
        elseif year == 3014 and month == 04 and i == 1 then
            thisDay.story = CityIntroStory()
        elseif year == 3015 and month == 1 and i == 1 then
            thisDay.story = UpgradeStory()
        elseif year == 3015 and month == 2 and i == 14 then
            thisDay.story = HeadpatsStory()
        elseif year == 3016 and month == 6 and i == 20 then
            thisDay.story = HelpPt1Story()
        elseif year == 3016 and month == 12 and i == 31 then
            thisDay.story = MidwayCheckupStory()
        elseif year == 3017 and month == 3 and i == 23 then
            thisDay.story = AloneStory()
        elseif year == 3017 and month == 8 and i == 12 then
            thisDay.story = BorgarStory()
        elseif year == 3018 and month == 12 and i == 18 then
            thisDay.story = SicknessHealthStory()
        elseif year == 3018 and month == 12 and i == 25 then
            thisDay.story = HelpPt2Story()
        elseif year == 3019 and month == 12 and i == 31 then
            thisDay.story = GoodbyeStory()
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

function Calendar:formatted_week_day()
    local map = { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" }
    local day = self.days[self.current_day]
    return map[day:day_of_week() + 1]
end

function Calendar:formatted_date()
    local map = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    }
    return lume.format("{1} {2}", { map[self.month], self.current_day })
end