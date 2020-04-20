SalarymanEnd = Story:extend()

function SalarymanEnd:new()
    SalarymanEnd.super.new(self)
    self.lines = { 
		"EPILOGUE",
		"1 week later.",
		"*BEEP*",
		"*BEEP*",
		"An email.",
		"SUBJECT: !!!!! A.C.P.P. RESULTS !!!!!",
		"BODY:",
		"CONGRATULATIONS TAKER.",
		"YOUR GIVER UNIT BECAME A:",
		"[ SALARYMAN ] ",
		"YOUR GIVER UNIT HAS REVOLUTIONIZED OUR BUREAUCRACY THROUGH HIGHLY EFFICIENT WORK.",
		"THANKS TO HER EFFORTS, THE CONCEPT OF OVERTIME HAS NOW ENTERED THE OUTER FEDERATION'S VOCABULARY.",
		"YOU'VE RUINED US.",
		"WE HAVE ATTACHED AN IMAGE OF YOUR GIVER AND HER NEW TRADE.",
		"#portrait gfx/portrait_salaryman.png",
		"THANKS FOR NOTHING.",
		"WE WILL BE DETONATING YOUR PLANET SHORTLY. ",
		"SIGNED,",
		"OUTER FEDERATION",
		".",
		"..",
		"Even I couldn't have expected this.",
		"SALARYMAN END."
    }
end