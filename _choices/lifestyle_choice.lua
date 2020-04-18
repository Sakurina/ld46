LifestyleChoice = Object:extend()

function LifestyleChoice:new()
    self.choice_name = "Uninitialized Lifestyle Choice"
    self.options = {}
    self.current_selection = nil
end

function LifestyleChoice:choose(option_key)
    self.current_selection = option_key
end

function LifestyleChoice:selected_option()
    return self.options[self.current_selection]
end