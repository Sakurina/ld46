JobEvent = DailyEvent:extend()

function JobEvent:new()
    JobEvent.super.new(self)
    
    self.event_name = "Part-Time Job"
    self.event_success_text = "{1} went to her part-time job."
    self.event_critical_text = "{1} went to her part-time job. Her boss gave her a little extra today!"
    self.stat_growths = {
        StatGrowth("money", 5, 8),
        StatGrowth("stress", 3, 4)
    }
end