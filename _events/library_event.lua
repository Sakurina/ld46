LibraryEvent = DailyEvent:extend()

function LibraryEvent:new()
    LibraryEvent.super.new(self)
    
    self.event_name = constants.library_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl} read philosophy books at the library today. How wise!"
    self.stat_growths = {
        StatGrowth("money", constants.library_event.cost_per_day, constants.library_event.cost_per_day),
        StatGrowth("morality", constants.library_event.morality_delta_regular, constants.library_event.morality_delta_lucky)
    }
end