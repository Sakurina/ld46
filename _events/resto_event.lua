RestaurantEvent = DailyEvent:extend()

function RestaurantEvent:new()
    RestaurantEvent.super.new(self)
    
    self.event_name = constants.resto_event.id
    self.event_success_text = "{1} attended to some shady business at the black market today. It was quite profitable."
    self.event_critical_text = "{1} came home from the black market with twice as much cash as usual... who knows what went down...?"
    self.stat_growths = {
        StatGrowth("money", constants.resto_event.income_per_day_regular, constants.resto_event.income_per_day_lucky),
        StatGrowth("cooking", constants.resto_event.cooking_delta, constants.resto_event.cooking_delta),
        StatGrowth("stress", constants.resto_event.stress_delta, constants.resto_event.stress_delta)
    }
end