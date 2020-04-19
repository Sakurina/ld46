StudyEvent = DailyEvent:extend()

function StudyEvent:new()
    StudyEvent.super.new(self)
    
    self.event_name = "Study"
    self.event_success_text = "{1} studied today."
    self.event_critical_text = "{1} studied and finally understood something she's been strugging with!"
    self.stat_growths = {
        StatGrowth("money", -5, -5),
        StatGrowth("int", 2, 3)
    }
end