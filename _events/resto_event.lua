RestaurantEvent = DailyEvent:extend()

function RestaurantEvent:new()
    RestaurantEvent.super.new(self)
    
    self.event_name = constants.resto_event.id
    self.event_success_text = ""
    -- this critical is negative so be careful
    self.event_critical_text = "{girl} dropped some plates at work today and it came out of her paycheck..."
    self.stat_growths = {
        StatGrowth("money", constants.resto_event.income_per_day_regular, constants.resto_event.income_per_day_lucky),
        StatGrowth("cooking", constants.resto_event.cooking_delta, constants.resto_event.cooking_delta),
        StatGrowth("stress", constants.resto_event.stress_delta, constants.resto_event.stress_delta)
    }
end