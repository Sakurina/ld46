KaraokeEvent = DailyEvent:extend()

function KaraokeEvent:new()
    KaraokeEvent.super.new(self)
    
    self.event_name = "Karaoke"
    self.event_success_text = "{1} went to karaoke with friends today."
    self.event_critical_text = "{1} sang all her favorite artist's top singles at karaoke today. Might as well have fun, sing every single one!"
    self.stat_growths = {
        StatGrowth("money", -3, -3),
        StatGrowth("cha", 2, 4)
    }
end