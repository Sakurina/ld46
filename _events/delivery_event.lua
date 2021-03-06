DeliveryEvent = DailyEvent:extend()

function DeliveryEvent:new()
    LabEvent.super.new(self)
    
    self.event_name = constants.delivery_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl} fulfilled the speed guarantee! She was tipped more than usual!"
    self.stat_growths = {
        StatGrowth("money", constants.delivery_event.income_per_day_regular, constants.delivery_event.income_per_day_lucky),
        StatGrowth("stress", constants.delivery_event.stress_delta, constants.delivery_event.stress_delta),
        StatGrowth("dex", constants.delivery_event.dex_delta, constants.delivery_event.dex_delta)
    }
end
