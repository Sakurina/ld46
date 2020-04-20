AlchemistEnd = Story:extend()

function AlchemistEnd:new()
    AlchemistEnd.super.new(self)
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
		"[ ALCHEMIST ] ",
		"ALCHEMY IS A WELL RESPECTED TRADE.",
		"THIS TRADE OPTIMIZES POTION CREATION AND HOMUNCULUS AND HAVE VARIOUS OTHER POTION-RELATED SKILLS.",
		"ACCORDING TO OUR GIVER UNIT'S REPORT,",
		"SHE HAS OBTAINED A LARGE CONTAINMENT DEVICE FOR HOLDING HER POTION CREATIONS.",
		"YOU HAVE CREATED A REVOLUTION IN TECHNOLOGY WITH YOUR EFFORTS",
		"WE HAVE ATTACHED AN IMAGE OF YOUR GIVER AND HER NEW TRADE.",
		"#portrait gfx/portrait_end_alchemist.png",
		"YOU HAVE AVOIDED DESTRUCTION FOR NOW.",
		"SIGNED,",
		"OUTER FEDERATION",
		".",
		"..",
		"Well.",
		"At least we're still alive.",
		".",
		"..",
		"Is that a cart?",
		"ALCHEMIST END."
    }
end
