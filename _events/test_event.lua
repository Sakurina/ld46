TestEvent = DailyEvent:extend()

function TestEvent:new()
    TestEvent.super.new(self)

    self.event_name = "Studying"
    self.event_success_text = "XYZ studied for exams today."
    self.event_critical_text = "XYZ studied for exams today and seemed to retain more than usual."
    self.stat_growths = {
        StatGrowth("strength", 2, 4),
        StatGrowth("morality", 1, 3)
    }
end