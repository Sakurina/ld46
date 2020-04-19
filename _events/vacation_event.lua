VacationEvent = DailyEvent:extend()

function VacationEvent:new()
    VacationEvent.super.new(self)

    self.event_name = constants.vacation_event.id
    self.event_success_text = "{1} went on vacation."
    self.event_critical_text = "{1} went on vacation and feels refreshed."
    self.stat_growths = {
        StatGrowth("money", constants.vacation_event.cost_per_day, constants.vacation_event.cost_per_day),
        StatGrowth("stress", constants.vacation_event.stress_delta_regular, constants.vacation_event.stress_delta_lucky)
    }
end