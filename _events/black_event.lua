BlackEvent = DailyEvent:extend()

function BlackEvent:new()
    BlackEvent.super.new(self)
    
    self.event_name = constants.black_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl} came home from the black market with twice as much cash as usual... who knows what went down...?"
    self.stat_growths = {
        StatGrowth("money", constants.black_event.income_per_day_regular, constants.black_event.income_per_day_lucky),
        StatGrowth("morality", constants.black_event.morality_delta, constants.black_event.morality_delta),
        StatGrowth("combat", constants.black_event.combat_delta, constants.black_event.combat_delta),
        StatGrowth("stress", constants.black_event.stress_delta, constants.black_event.stress_delta)
    }
end