CalendarDay = Object:extend()

function CalendarDay:new(day, startingOffset, week_num)
    self.day = day
    self.offset = startingOffset + day - 1
    self.week_num = week_num
    self.daily_event = nil
    self.daily_event_handled = false
    self.story = nil
    self.story_handled = false
end

function CalendarDay:day_of_week()
    return self.offset % 7
end

function CalendarDay:set_daily_event(event)
    self.daily_event = event
end

function CalendarDay:daily_event_needs_handling()
    return self.daily_event ~= nil and self.daily_event_handled == false
end

function CalendarDay:mark_daily_event_handled()
    self.daily_event_handled = true
end

function CalendarDay:set_story(story)
    self.story = story
end

function CalendarDay:story_needs_handling()
    return self.story ~= nil and self.story_handled == false
end

function CalendarDay:mark_story_handled()
    self.story_handled = true
end