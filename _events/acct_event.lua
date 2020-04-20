AccountingEvent = DailyEvent:extend()

function AccountingEvent:new()
    AccountingEvent.super.new(self)
    
    self.event_name = constants.acct_event.id
    self.event_success_text = ""
    self.event_critical_text = "{girl} got a bonus today for filing a rich client's taxes!"
    self.stat_growths = {
        StatGrowth("money", constants.acct_event.income_per_day_regular, constants.acct_event.income_per_day_lucky),
        StatGrowth("business", constants.acct_event.business_delta, constants.acct_event.business_delta),
        StatGrowth("stress", constants.acct_event.stress_delta, constants.acct_event.stress_delta),
        StatGrowth("int", constants.acct_event.int_delta, constants.acct_event.int_delta)
    }
end