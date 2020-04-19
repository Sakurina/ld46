AccountingEvent = DailyEvent:extend()

function AccountingEvent:new()
    AccountingEvent.super.new(self)
    
    self.event_name = constants.acct_event.id
    self.event_success_text = "{1} attended to some shady business at the black market today. It was quite profitable."
    self.event_critical_text = "{1} came home from the black market with twice as much cash as usual... who knows what went down...?"
    self.stat_growths = {
        StatGrowth("money", constants.acct_event.income_per_day_regular, constants.acct_event.income_per_day_lucky),
        StatGrowth("business", constants.acct_event.business_delta, constants.acct_event.business_delta),
        StatGrowth("stress", constants.acct_event.stress_delta, constants.acct_event.stress_delta),
        StatGrowth("int", constants.acct_event.int_delta, constants.acct_event.int_delta)
    }
end