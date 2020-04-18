Calendar = Object:extend()

function Calendar:new(year, month)
    self.year = year
    self.month = month
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