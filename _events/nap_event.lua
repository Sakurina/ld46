NapEvent = DailyEvent:extend()

function NapEvent:new()
    NapEvent.super.new(self)

    self.event_name = "Nap"
    self.event_success_text = "{1} took a nap."
    self.event_critical_text = "{1} took a nap and feels refreshed."
    self.stat_growths = {
        StatGrowth("stress", -2, -4)
    }
end