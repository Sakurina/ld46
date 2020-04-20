AloneStory = Story:extend()

function AloneStory:new()
    AloneStory.super.new(self)
    self.lines = { 
        "#bg gfx/bg1.png",
        "3017.UC",
        "03.23 0030 HOME",
        "#bg gfx/bg3.png",
        "{girl} is fast asleep in her room right now.",
        "For some reason I can't sleep.",
        "So, like I've done in the past, I immerse myself in my research.",
        "To date, I've tried a multitude of algorithms seeking to perfect my robotics.",
        "The A.I. system was sufficiently advanced but never seemed reach \"it\".",
        "\"It\", however, was never a measurable quantity.",
        "Nothing ever \"felt\" complete--",
        "--but I could never explain what.",
        "Compared to training A.I., training {girl} has been completely different.",
        "Nothing was ever perfect.",
        "She was prone failure and the things she did were not necessarily bound by human logic.",
        "..",
        "...",
        "But it is fun raising her.",
        "Imperfection, huh.",
        "Maybe that's what I'm missing.",
        "When I think about it, imperfection lays bare our inadequacies.",
        "Without imperfection, we have nothing to strive for.",
        "Through imperfection we fail.",
        "With failure comes a new goal.",
        "Failure...",
        "Failure is tough to swallow.",
        "But failure allows us to pinpoint where we must improve.",
        "So that we don't make the same mistakes again.",
        "Am I not seeing what we need because my A.I. doesn't sufficiently fail?",
        "I'll bring it up with the rest of R&D tomorrow...",
        ".",
        ".",
        ".",
        ".",
        "The next day I suggested we make our A.I. fail to my colleagues.",
        "They thought I was joking..."
    }
end
