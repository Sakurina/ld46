TestEventTwo = DailyEvent:extend()

function TestEventTwo:new()
    TestEventTwo.super.new(self)

    self.event_name = "Meal Prep"
    self.event_success_text = "XYZ did some meal prep today."
    self.event_critical_text = "XYZ did some meal prep today. The neighbors said it smelled delicious!"
    self.stat_growths = {
        StatGrowth("strength", 2, 4),
        StatGrowth("morality", 1, 3)
    }
end