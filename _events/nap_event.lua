NapEvent = DailyEvent:extend()

function NapEvent:new()
    NapEvent.super.new(self)

    self.event_name = constants.nap_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl} took a nap and felt more refreshed than usual."
    self.stat_growths = {
        StatGrowth("stress", constants.nap_event.stress_delta_regular, constants.nap_event.stress_delta_lucky)
    }
end