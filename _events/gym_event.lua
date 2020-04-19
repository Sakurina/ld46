GymEvent = DailyEvent:extend()

function GymEvent:new()
    GymEvent.super.new(self)
    
    self.event_name = "Gym"
    self.event_success_text = "{1} went to the gym today."
    self.event_critical_text = "{1} went to the gym today and lifted more than she ever could before!"
    self.stat_growths = {
        StatGrowth("money", -2, -2),
        StatGrowth("combat", 3, 4)
    }
end