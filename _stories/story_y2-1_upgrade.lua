UpgradeStory = Story:extend()

function UpgradeStory:new()
    UpgradeStory.super.new(self)
    self.lines = { 
        "#bg gfx/bg1.png",
        "3015.UC",
        "01.01 0900 HOME",
        "#bg gfx/bg7.png",
        "#music bgm/Lazy Marine - 91 T1.wav",
        "{player}: \"Good morning, {girl}.\"",
        "{girl}: ...",
        "#portrait gfx/portrait_baby_{type}.png",
        "{girl}: \"Good morning..TAKER.\"",
        "With the dawn, came a new year and with it a reminder of what was to come.",
        "5 more years, huh...",
        "I've gotten used to {girl} and her presence in and around the house.",
        "But man...",
        "I'll never get used to the TAKER title.",
        "{player}: \"Hey, could you.. possibly call me something else?\"",
        "{girl} tilts her head with an inquisitive expression.",
        "{girl}: \"Like what?\"",
        "{player}: \"Oh you know, like anything else.\"",
        "She raises her hand to her chin, clearly deep in thought.",
        "{girl}: ...",
        "{girl}: \"..Daddy?\"",
        "No.",
        "Absolutely not.",
        "That's way, way worse.",
        "{player}: \"Actually you know what, TAKER is fine.\"",
        "{girl}: \"The name clearly seems to bother you though...\"",
        "{girl}: \"How about {player}?\"",
        "Yes, that's me, I'm {player}.",
        "{player}: \"Truth be told, that's still a bit awkward.\"",
        "{girl}: \"?\"",
        "{player}: \"Well, it's just that names are usually reserved for use when you're close with one another.\"",
        "{girl}: \"We live in the same house.\"",
        "{player}: \"That is certainly true--\"",
        "{girl}: \"Is this not close?\"",
        "She shortens the distance between us.",
        "I can see the top of her head even while she's looking up at me.",
        "{player}: \"Names are--\"",
        "{girl}: \"No.\"",
        "{girl}: \"This is fine..{player}.\"",
        "Yes, that's me, I'm {player}."
		,"#music bgm/Lazy Marine - 91 full.wav"
    }
end
