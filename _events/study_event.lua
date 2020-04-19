StudyEvent = DailyEvent:extend()

function StudyEvent:new()
    StudyEvent.super.new(self)
    
    self.event_name = constants.study_event.id
    self.event_success_text = "{1} studied today."
    self.event_critical_text = "{1} studied and finally understood something she's been strugging with!"
    self.stat_growths = {
        StatGrowth("money", constants.study_event.cost_per_day, constants.study_event.cost_per_day),
        StatGrowth("int", constants.study_event.int_delta_regular, constants.study_event.int_delta_lucky)
    }
end