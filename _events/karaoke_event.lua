KaraokeEvent = DailyEvent:extend()

function KaraokeEvent:new()
    KaraokeEvent.super.new(self)
    
    self.event_name = constants.karaoke_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl} sang her favorite artist's top singles at karaoke today. Might as well have fun, sing every single one!"
    self.stat_growths = {
        StatGrowth("money", constants.karaoke_event.cost_per_day, constants.karaoke_event.cost_per_day),
        StatGrowth("cha", constants.karaoke_event.cha_delta_regular, constants.karaoke_event.cha_delta_lucky)
    }
end