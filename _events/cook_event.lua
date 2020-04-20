CookEvent = DailyEvent:extend()

function CookEvent:new()
    CookEvent.super.new(self)

    self.event_name = constants.cook_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl}'s cooking today smelled so good."
    self.stat_growths = {
        StatGrowth("dex", constants.cook_event.dex_delta_regular, constants.cook_event.dex_delta_lucky),
        StatGrowth("cooking", constants.cook_event.cooking_delta_regular, constants.cook_event.cooking_delta_lucky)
    }
end