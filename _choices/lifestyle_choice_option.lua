LifestyleChoiceOption = Object:extend()

function LifestyleChoiceOption:new(name, stat)
    self.option_name = name
    self.impacted_stat = stat
    self.luck_delta = constants.default_buffed_luck_delta
end