KaraokeEvent = DailyEvent:extend()

function KaraokeEvent:new()
    KaraokeEvent.super.new(self)
    
    self.event_name = "Karaoke"
    self.event_success_text = "{1} went to karaoke with friends today."
    self.event_critical_text = "{1} sang all her favorite artist's top singles at karaoke today. Might as well have fun, sing every single one!"
    self.stat_growths = {
        StatGrowth("money", constants.karaoke_event.cost_per_day, constants.karaoke_event.cost_per_day),
        StatGrowth("cha", constants.karaoke_event.cha_delta_regular, constants.karaoke_event.cha_delta_lucky)
    }
end