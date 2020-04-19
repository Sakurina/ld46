LabEvent = DailyEvent:extend()

function LabEvent:new()
    LabEvent.super.new(self)
    
    self.event_name = constants.lab_event.id
    self.event_success_text = "{1} conducted some experiments at the lab today."
    self.event_critical_text = "{1} made a new breakthrough in her lab research today and was given a bonus."
    self.stat_growths = {
        StatGrowth("money", constants.lab_event.income_per_day_regular, constants.lab_event.income_per_day_lucky),
        StatGrowth("int", constants.lab_event.int_delta, constants.lab_event.int_delta),
        StatGrowth("research", constants.lab_event.research_delta, constants.lab_event.research_delta)
    }
end