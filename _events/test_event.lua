TestEvent = DailyEvent:extend()

function TestEvent:new()
    TestEvent.super.new(self)

    self.event_name = "Test Event"
    self.event_success_text = "Success"
    self.event_critical_text = "Critical"
    self.stat_growths = {
        StatGrowth("strength", 2, 4),
        StatGrowth("morality", 1, 3)
    }
end