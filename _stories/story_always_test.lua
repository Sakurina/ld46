AlwaysTestStory = Story:extend()

function AlwaysTestStory:new()
    AlwaysTestStory.super.new(self)
    self.lines = { 
        "Always Test Line 1", 
        "Always Test Line 2", 
        "Always Test Line 3" }
end