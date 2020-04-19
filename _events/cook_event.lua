CookEvent = DailyEvent:extend()

function CookEvent:new()
    CookEvent.super.new(self)

    self.event_name = "Cook"
    self.event_success_text = "{1} cooked some food."
    self.event_critical_text = "{1} cooked food that smelled so yummy, the neighbors came over to see what it was."
    self.stat_growths = {
        StatGrowth("dex", constants.cook_event.dex_delta_regular, constants.cook_event.dex_delta_lucky),
        StatGrowth("cooking", constants.cook_event.cooking_delta_regular, constants.cook_event.cooking_delta_lucky)
    }
end