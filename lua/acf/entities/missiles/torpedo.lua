local Classes = ACF.Classes
Classes.DefineClass("ACF.Missiles.Torpedoes", "ACF.Missiles.BaseMissile", function(CLASS)
	CLASS.Name			= "Torpedoes"
	CLASS.ID 			= "TPD"
	CLASS.Description	= "Sub-aquatic munitions designed to destroy naval targets."
	CLASS.Sound			= ""
	CLASS.Effect		= "underwaterexplosion"
	CLASS.Spread		= 1
	CLASS.Blacklist		= { ["ACF.Ammunition.AP"] = true, ["ACF.Ammunition.APHE"] = false, ["ACF.Ammunition.HEAT"] = false, ["ACF.Ammunition.HP"] = true, ["ACF.Ammunition.FL"] = true, ["ACF.Ammunition.SM"] = true }
	CLASS.LimitConVar 	= {
		Name = "_acfm_tpd",
		Amount = 8,
		Text = "Maximum number of torpedoes that can be loaded at once. Differentiates from the acf_rack limit."
	}
end)

Classes.DefineClass("ACF.Missiles.Torpedoes.MK54", "ACF.Missiles.Torpedoes", function(CLASS)
	CLASS.Name			= "MK54 LHT"
	CLASS.Description	= "A lightweight torpedo ideal for short range coastal fleets. Can be equipped with sonar or wire guidance packages."
	CLASS.Model			= "models/torpedoes/mk54.mdl"
	CLASS.Length		= 272
	CLASS.Caliber		= 324
	CLASS.Mass			= 85
	CLASS.Year			= 1999
	CLASS.Diameter		= 324 -- in mm
	CLASS.ReloadTime	= 10
	CLASS.ExhaustPos  	= Vector(-42)
	CLASS.Racks			= { ["ACF.Racks.1xRK_small"] = true, ["ACF.Racks.1xRK"] = true, ["ACF.Racks.2xRK"] = true, ["ACF.Racks.4xRK"] = true }
	CLASS.Guidances		= { ["ACF.Missiles.Guidance.Acoustic"] = true, ["ACF.Missiles.Guidance.Dumb"] = true, ["ACF.Missiles.Guidance.WireMCLOS"] = true }
	CLASS.Navigation  	= "APN"
	CLASS.Fuzes			= { ["ACF.Missiles.Fuze.Contact"] = true, ["ACF.Missiles.Fuze.Radio"] = true }
	CLASS.SeekCone		= 10
	CLASS.ViewCone		= 30
	CLASS.Agility		= 3
	CLASS.ArmDelay		= 0.2
	CLASS.HitDeviate  	= true
	CLASS.Round 		= {
		Model           	= "models/torpedoes/mk54.mdl",
		MaxLength       	= 289,
		ProjLength      	= 68,
		Armor           	= 1,
		PropLength      	= 160,
		Thrust          	= 800000, -- in kg*in/s^2
		FuelConsumption 	= 0.02, -- in g/s/f
		StarterPercent  	= 0.05,
		MaxAgilitySpeed 	= 300, -- in m/s
		DragCoef        	= 10,
		FinMul          	= 0.35,
		GLimit          	= 20,
		TailFinMul      	= 0.15,
		CanDelayLaunch  	= true,
		ActualLength    	= 272,
		ActualWidth     	= 18

	}
	CLASS.Preview 			= {
		Height = 100,
		FOV    = 60,
	}
end)

