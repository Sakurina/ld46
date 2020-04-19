PreconTestStory = Story:extend()

function PreconTestStory:new()
    PreconTestStory.super.new(self)

    self.preconditions = {
        StoryPrecondition("morality", "<", 150)
    }
    
    self.lines = { 
        "Precondition Test Line 1", 
        "Precondition Test Line 2", 
        "Precondition Test Line 3" 
    }
end