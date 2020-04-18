CalendarDay = Object:extend()

function CalendarDay:new(day, startingOffset, week_num)
    self.day = day
    self.offset = startingOffset + day - 1
    self.week_num = week_num
    self.daily_event = nil
    self.special_event = nil
end

function CalendarDay:day_of_week()
    return self.offset % 7
end

function CalendarDay:set_daily_event(event)
    self.daily_event = event
end