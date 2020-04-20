PirateEnd = Story:extend()

function PirateEnd:new()
    PirateEnd.super.new(self)
    self.lines = { 
		"#bg gfx/bg1.png",
		"#music bgm/Lazy Marine - 91 T2.wav",
		"EPILOGUE",
		"1 week later.",
		"*BEEP*",
		"*BEEP*",
		"An email.",
		"SUBJECT: !!!!! A.C.P.P. RESULTS !!!!!",
		"BODY:",
		"CONGRATULATIONS TAKER.",
		"YOUR GIVER UNIT BECAME A:",
		"[ PIRATE ] ",
		"YOUR LACK OF MORALS HAVE CREATED A GALACTIC TERROR.",
		"YOUR GIVER HAS RANSACKED THE MAJORITY OF OUR FOOD SUPPLY AND HAS BEEN USING HER INFLUENCE IN NEFARIOUS WAYS.",
		"SHE THIRSTS FOR BOOZE AND WENCHES REGULARLY.",
		"WE DO NOT EVEN HAVE A CONCEPT FOR BOOZE OR WENCHES.",
		"WE ARE NOT SURE HOW YOU DID THIS.",
		"WE HAVE ATTACHED AN IMAGE OF YOUR GIVER AND HER NEW TRADE.",
		"#portrait gfx/portrait_pirate.png",
		"YOU HAVE AVOIDED DESTRUCTION FOR NOW AS WE NO LONGER HAVE THE MEANS TO DESTROY YOUR PLANET.",
		"ONCE WE ARE FREE FROM HER REIGN, YOU WILL HEAR FROM US AGAIN.",
		"SIGNED,",
		"OUTER FEDERATION",
		".",
		"..",
		"Well.",
		"That is one way to prevent the apocalypse.",
		"PIRATE END."
    }
end
