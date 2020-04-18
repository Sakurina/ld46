TestChoice = LifestyleChoice:extend()

function TestChoice:new()
    TestChoice.super.new(self)

    self.choice_name = "Diet"
    self.options = {
        beef = LifestyleChoiceOption("Beef", "strength"),
        chicken = LifestyleChoiceOption("Chicken", "morality"),
        fish = LifestyleChoiceOption("Fish", "agility")
    }
    self.current_selection = nil
end