-- Daily event
DailyEvent = Object:extend()

function DailyEvent:new()
    -- Customization
    self.event_name = "Uninitialized Daily Event"
    self.event_success_text = "This event wasn't initialized correctly, but it was a success."
    self.event_critical_text = "This event wasn't initialized correctly, but it was a critical success."
    self.stat_growths = {}

    -- Result
    self.outcome_text = "The outcome was never determined."
end

function DailyEvent:create_luck_table(lifestyle_choices)
    local luck_table = {}
    lume.each(self.stat_growths, function(sg)
        luck_table[sg.impacted_stat] = constants.default_luck_value
    end)
    lume.each(lifestyle_choices, function(lsc)
        local opt = lsc:selected_option()
        if opt ~= nil then
            if lume.find(lume.keys(luck_table), opt.impacted_stat) ~= nil then
                luck_table[opt.impacted_stat] = luck_table[opt.impacted_stat] + opt.luck_delta
            end
        end
    end)
    return luck_table
end

function DailyEvent:determine_outcome(lifestyle_choices)
    local luck_table = self:create_luck_table(lifestyle_choices)
    
    -- determine outcome on each stat growth
    lume.each(self.stat_growths, function(sg)
        sg:roll(luck_table[sg.impacted_stat])
    end)

    -- find out if at least one was critical...
    local criticals = lume.any(self.stat_growths, function(sg)
        return sg.base_delta ~= sg.critical_delta and sg.outcome == sg.critical_delta
    end)
    
    -- ...and set the outcome text to the right string
    if criticals then
        self.outcome_text = self.event_critical_text
    else
        self.outcome_text = self.event_success_text
    end
end