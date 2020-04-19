GymEvent = DailyEvent:extend()

function GymEvent:new()
    GymEvent.super.new(self)
    
    self.event_name = constants.gym_event.id
    self.event_success_text = "{1} went to the gym today."
    self.event_critical_text = "{1} went to the gym today and lifted more than she ever could before!"
    self.stat_growths = {
        StatGrowth("money", constants.gym_event.cost_per_day, constants.gym_event.cost_per_day),
        StatGrowth("str", constants.gym_event.str_delta_regular, constants.gym_event.str_delta_lucky),
        StatGrowth("combat", constants.gym_event.combat_delta_regular, constants.gym_event.combat_delta_lucky)
    }
end