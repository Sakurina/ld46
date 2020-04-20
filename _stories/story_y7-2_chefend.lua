ChefEnd = Story:extend()

function ChefEnd:new()
    ChefEnd.super.new(self)
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
		"[ CHEF ] ",
		"YOUR GIVER UNIT HAS CREATED A UNIQUE MULTI-DIMENSIONAL RESTAURANT.",
		"IT'S FAME STRETCHES OVER NOT JUST THE UNIVERSE, BUT THE TEMPORAL PLANE AS WELL.",
		"HER SIGNATURE LEFT-N-RIGHT BURGER HAS CHANGED THE DIETS OF THE OUTER FEDERATION FOREVER.",
		"THE PROLONGED HEALTH EFFECTS FROM EATING HER BURGERS ARE STILL UNKNOWN.",
		"BUT THEY ARE DAMN GOOD.",
		"WE EAT THREE OR FOUR OF THEM IN A SINGLE SITTING.",
		"WE HAVE ATTACHED AN IMAGE OF YOUR GIVER AND HER NEW TRADE.",
		"#portrait gfx/portrait_chef.png",
		"YOU HAVE AVOIDED DESTRUCTION FOR NOW AS THE OUTER FEDERATION LOVES FOOD.",
		"SIGNED,",
		"OUTER FEDERATION",
		".",
		"..",
		"I could go for some Up-N-Down right now.",
		"CHEF END."
    }
end
