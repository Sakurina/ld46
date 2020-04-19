NapEvent = DailyEvent:extend()

function NapEvent:new()
    NapEvent.super.new(self)

    self.event_name = "Nap"
    self.event_success_text = "{1} took a nap."
    self.event_critical_text = "{1} took a nap and feels refreshed."
    self.stat_growths = {
        StatGrowth("stress", constants.nap_event.stress_delta_regular, constants.nap_event.stress_delta_lucky)
    }
end