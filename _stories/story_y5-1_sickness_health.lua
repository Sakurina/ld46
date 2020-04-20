SicknessHealthStory = Story:extend()

function SicknessHealthStory:new()
    SicknessHealthStory.super.new(self)
    self.lines = {
        "#bg gfx/bg1.png",
        "3018.UC",
        "12.18 1900 HOME",
        "#bg gfx/bg7.png",
        "It's..already this late?",
        "Oh man..",
        "I'm..",
        "Not sure I feel too good...",
        "My body aches with every step as I drag my body over to my bed.",
        "Time seems slow to a crawl as I lay on my bed.",
        "My body is burning..to the point where I feel like I may singe the clothes on it.",
        "(cough)",
        "(cough) (cough)",
        "When..did this happen?",
        "In my mouth, I can taste it.",
        "A tasteless, yet bitter feeling.",
        "My body was clearly fighting some sort of infection.",
        "..",
        "Water.",
        "I need water.",
        "I attempt to pull myself up to head to my kitchen but my knees knock together as they give out from under me.",
        "*THUD*",
        "With a loud crash, my body falls a limp mess onto the floor.",
        "My vision blurs--its focus coming in and out like a broken camera.",
        "I'm able to make out my door swinging open from the corner of my eye.",
        "This floor feels nice.",
        "It's nice and cold...",
        "#portrait gfx/portrait_baby_{type}.png",
        "{girl}: (muffled noise)",
        "Oh..",
        "{girl}.",
        "She's coming towards me?",
        "..",
        "...",
        "Even through my impairments I can tell she's distraught.",
        "..",
        "Don't cry.",
        "..",
        "I'm just going to take..",
        "..a nap for a little bit...",
        "..."
    }
end
