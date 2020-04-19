LibraryEvent = DailyEvent:extend()

function LibraryEvent:new()
    LibraryEvent.super.new(self)
    
    self.event_name = "Library"
    self.event_success_text = "{1} read philosophy books at the library today."
    self.event_critical_text = "{1} read philosophy book at the library today. How wise!"
    self.stat_growths = {
        StatGrowth("money", -2, -2),
        StatGrowth("morality", 4, 5)
    }
end