UpgradeStory = Story:extend()

function UpgradeStory:new()
    UpgradeStory.super.new(self)
    self.lines = { 
        "#portrait gfx/portrait_baby_cool.png",
        "{1} has evolved!"
    }
end