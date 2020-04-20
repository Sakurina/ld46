BadEnd = Story:extend()

function BadEnd:new()
    BadEnd.super.new(self)
    self.lines = { 
		"#bg gfx/bg1.png",
		"#music bgm/Lazy Marine - 91 T1.wav",
		"*BEEP*",
		"*BEEP*",
		"SUBJECT: !!!!! A.C.P.P. RESULTS !!!!!",
		"BODY:",
		"TAKER.",
		"WHAT HAVE YOU DONE?",
		"YOU HAVE FAILED TO PROPERLY CARE FOR YOUR GIVER UNIT.",
		"YOUR REARING PERIOD WILL BE CUT SHORT,",
		"AND YOUR PLANET DETONATED.",
		"EFFECTIVE IMMEDIATELY.",
		"THANK YOU FOR PARTICIPATING.",
		"GOODBYE.",
		"BAD END."
    }
end
