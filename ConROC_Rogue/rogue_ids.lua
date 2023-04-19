local ConROC_Rogue, ids = ...;

--General
	ids.Racial = {
		Berserking = 20554,
		Shadowmeld = 20580,
	}
	ids.Spec = {
		Assassination = 1,
		Combat = 2,
		Subtlety = 3,
	}	
--Assassination
	ids.Ass_Ability = {
		AmbushRank1 = 8676,
		AmbushRank2 = 8724,
		AmbushRank3 = 8725,
		AmbushRank4 = 11267,
		AmbushRank5 = 11268,
		AmbushRank6 = 11269,
		AmbushRank7 = 27441, -- new from here
		AmbushRank8 = 48689,
		AmbushRank9 = 48690,
		AmbushRank10 = 48691,
		CheapShot = 1833,
		ColdBlood = 213981,
		DeadlyThrowRank1 = 26679, -- new from here
		DeadlyThrowRank2 = 48673,
		DeadlyThrowRank3 = 48674,
		DismantleRank1 = 51722, -- new from here
		EnvenomRank1 = 32645, -- new from here
		EnvenomRank2 = 32684,
		EnvenomRank3 = 57992,
		EnvenomRank4 = 57993,
		EviscerateRank1 = 2098,
		EviscerateRank2 = 6760,
		EviscerateRank3 = 6761,
		EviscerateRank4 = 6762,
		EviscerateRank5 = 8623,
		EviscerateRank6 = 8624,
		EviscerateRank7 = 11299,
		EviscerateRank8 = 11300,
		EviscerateRank9 = 31016, -- new from here
		EviscerateRank10 = 26865,
		EviscerateRank11 = 48667,
		EviscerateRank12 = 48668,
		ExposeArmorRank1 = 8647,
		--ExposeArmorRank2 = 8649,
		--ExposeArmorRank3 = 8650,
		--ExposeArmorRank4 = 11197,
		--ExposeArmorRank5 = 11198,
		GarroteRank1 = 703,
		GarroteRank2 = 8631,
		GarroteRank3 = 8632,
		GarroteRank4 = 8633,
		GarroteRank5 = 11289,
		GarroteRank6 = 11290,
		GarroteRank7 = 26839, -- new from here
		GarroteRank8 = 26884,
		GarroteRank9 = 48675,
		GarroteRank10 = 48676,
		KidneyShotRank1 = 408,
		KidneyShotRank2 = 8643,
		RuptureRank1 = 1943,
		RuptureRank2 = 8639,
		RuptureRank3 = 8640,
		RuptureRank4 = 11273,
		RuptureRank5 = 11274,
		RuptureRank6 = 11275,
		RuptureRank7 = 26867,
		RuptureRank8 = 48671, -- new from here
		RuptureRank9 = 48672,
		SliceandDiceRank1 = 5171,
		SliceandDiceRank2 = 6774,
	}
	ids.Ass_Talent = {
		ImprovedEviscerate = 1,
		RemorselessAttacks = 2,
		Malice = 3,
		 
		Ruthlessness = 4,
		BloodSpatter = 5,
		PuncturingWounds = 6,

		Vigor = 7,
		ImprovedExposeArmor = 8,
		Lethality = 9,

		VilePoisons = 10,
		ImprovedPoisons = 11,

		FleetFooted = 12,
		ColdBlood = 13,
		ImprovedKidneyShot = 14,
		QuickRecovery = 15,

		SealFate = 16,
		Murder = 17,

		DeadlyBrew = 18,
		Overkill = 19,
		DeadenedNerves = 20,

		FocusedAttacs = 21,
		FindWeakness = 22,

		MasterPoisoner = 23,
		Mutilate = 24,
		TurntheTables = 25,

		CuttoChase = 26,

		HungerforBlood = 27,
	}
--Combat
	ids.Com_Ability = {
		AdrenalineRush = 13750,
		BackstabRank1 = 53,
		BackstabRank2 = 2589,
		BackstabRank3 = 2590,
		BackstabRank4 = 2591,
		BackstabRank5 = 8721,
		BackstabRank6 = 11279,
		BackstabRank7 = 11280,
		BackstabRank8 = 11281,
		BackstabRank9 = 25300, -- new from here
		BackstabRank10 = 26863,
		BackstabRank11 = 48656,
		BackstabRank12 = 48657,
		BladeFlurry = 13877,
		EvasionRank1 = 5277, -- new from here
		EvasionRank2 = 26669,
		FanofKnives = 51723, -- new from here
		FeintRank1 = 1966,
		FeintRank2 = 6768,
		FeintRank3 = 8637,
		FeintRank4 = 11303,
		FeintRank5 = 25302, -- new from here
		FeintRank6 = 27448,
		FeintRank7 = 48658,
		FeintRank8 = 48659,
		GougeRank1 = 1776,
		--GougeRank2 = 1777,
		--GougeRank3 = 8629,
		--GougeRank4 = 11285,
		--GougeRank5 = 11286,
		KickRank1 = 1766,
		--KickRank2 = 1767,
		--KickRank3 = 1768,
		--KickRank4 = 1769,
		Riposte = 14251,
		SinisterStrikeRank1 = 1752,
		SinisterStrikeRank2 = 1757,
		SinisterStrikeRank3 = 1758,
		SinisterStrikeRank4 = 1759,
		SinisterStrikeRank5 = 1760,
		SinisterStrikeRank6 = 8621,
		SinisterStrikeRank7 = 11293,
		SinisterStrikeRank8 = 11294,
		SinisterStrikeRank9 = 26861, -- new from here
		SinisterStrikeRank10 = 26862,
		SinisterStrikeRank11 = 48637,
		SinisterStrikeRank12 = 48638,
		SprintRank1 = 2983,
		SprintRank2 = 8696,
		SprintRank3 = 11305,
	}
	ids.Com_Talent = {
		ImprovedGouge = 1,
		ImprovedSinisterStrike = 2,
		DualWieldSpecialization = 3,

		ImprovedSliceAndDice = 4,
		Deflection = 5,
		Precision = 6,

		Endurance = 7,
		Riposte = 8,
		CloseQuartersCombat = 9,

		ImprovedKick = 10,
		ImprovedSprint = 11,
		LightningReflexes = 12,
		Aggression = 13,

		MaceSpecialization = 14,
		BladeFlurry = 15,
		HackandSlash = 16,

		WeaponExpertise = 17,
		BladeTwisting = 18,

		Vitality = 19,
		AdrenalineRush = 20,
		NervesofSteel = 21,

		ThrowingSpecialization = 22,
		CombatPotency = 23,

		UnfairAdvantage = 24,
		SurpriseAttacks = 25,
		SavageCombat = 26,

		PreyontheWeak = 27,

		KillingSpree = 28,
	}
--Subtlety
	ids.Sub_Ability = {
		Blind = 2094,
		CloakofShadows = 31224, -- new from here
		DetectTraps = 2836,
		DisarmTrap = 1842,
		Distract = 1725,
		GhostlyStrike = 14278,
		HemorrhageRank1 = 16511,
		HemorrhageRank2 = 17347,
		HemorrhageRank3 = 17348,
		HemorrhageRank4 = 26864, -- new from here
		HemorrhageRank5 = 48660,
		PickPocket = 921,
		Premeditation = 14183,
		Preparation = 14185,
		SapRank1 = 6770,
		SapRank2 = 2070,
		SapRank3 = 11297,
		SapRank4 = 51724, -- new from here
		StealthRank1 = 1784,
		--StealthRank2 = 1785,
		--StealthRank3 = 1786,
		--StealthRank4 = 1787,
		VanishRank1 = 1856,
		VanishRank2 = 1857,
		VanishRank3 = 26889, -- new from here
	}
	ids.Sub_Talent = {
		RelentlessStrikes = 1,
		MasterofDeception = 2,
		Opportunity = 3,

		SleightofHand = 4,
		DirtyTricks = 5,
		Camouflage = 6,

		Elusiveness = 7,
		GhostlyStrike = 8,
		SerratedBlades = 9,

		Setup = 10,
		Initiative = 11,
		ImprovedAmbush = 12,

		HeightenedSenses = 13,
		Preparation = 14,
		DirtyDeeds = 15,
		Hemorrhage = 16,

		MasterofSubtlety = 17,
		Deadliness = 18,

		EnvelopingShadows = 19,
		Premeditation = 20,
		CheatDeath = 21,

		SinisterCalling = 22,
		Waylay = 23,
		
		HonorAmongThieves = 24,
		Shadowstep = 25,
		FilthyTricks = 26,

		SlaughterfromtheShadows = 27,

		ShadowDance = 28,
	}
--Poisons
	ids.Poisons = { -- is items not spells
		BlindingPowder = 5530,
		AnestheticPoisonRank1 = 21835,
		AnestheticPoisonRank2 = 43237,	
		CripplingPoisonRank1 = 3775,
		CripplingPoisonRank2 = 3776,	
		DeadlyPoisonRank1 = 2892,
		DeadlyPoisonRank2 = 2893,
		DeadlyPoisonRank3 = 8984,
		DeadlyPoisonRank4 = 8985,
		DeadlyPoisonRank5 = 20844,
		DeadlyPoisonRank6 = 22053,
		DeadlyPoisonRank7 = 22054,
		DeadlyPoisonRank8 = 43232,
		DeadlyPoisonRank9 = 43233,
		InstantPoisonRank1 = 6947,
		InstantPoisonRank2 = 6949,
		InstantPoisonRank3 = 6950,
		InstantPoisonRank4 = 8926,
		InstantPoisonRank5 = 8927,
		InstantPoisonRank6 = 8928,
		InstantPoisonRank7 = 21927,
		InstantPoisonRank8 = 43230,
		InstantPoisonRank9 = 43231,
		MindnumbingPoisonRank1 = 5237,
		MindnumbingPoisonRank2 = 6951,
		MindnumbingPoisonRank3 = 9186,		
		WoundPoisonRank1 = 10918,
		WoundPoisonRank2 = 10920,
		WoundPoisonRank3 = 10921,
		WoundPoisonRank4 = 10922,
		WoundPoisonRank5 = 22055,
		WoundPoisonRank6 = 43234,
		WoundPoisonRank7 = 43235,
	}
	ids.ActivePoison = { -- list of EnchantId and Poison name to map against Poisons
		[218]	=	"Anesthetic Poison",
		[3774]	=	"Anesthetic Poison II",	
		[22]	=	"Crippling Poison",
		[603]	=	"Crippling Poison II",
		[7]		=	"Deadly Poison",
		[8]		=	"Deadly Poison II",
		[626]	=	"Deadly Poison III",
		[627]	=	"Deadly Poison IV",
		[2630]	=	"Deadly Poison V",
		[2642]	=	"Deadly Poison VI",
		[2643]	=	"Deadly Poison VII",
		[3770]	=	"Deadly Poison VIII",
		[3771]	=	"Deadly Poison IX",
		[323]	=	"Instant Poison",
		[324]	=	"Instant Poison II",
		[325]	=	"Instant Poison III",
		[623]	=	"Instant Poison IV",
		[624]	=	"Instant Poison V",
		[625]	=	"Instant Poison VI",
		[2641]	=	"Instant Poison VII",
		[3768]	=	"Instant Poison VIII",
		[3769]	=	"Instant Poison IX",
		[35]	=	"Mind Numbing Poison",
		[23]	=	"Mind-numbing Poison II",
		[643]	=	"Mind-Numbing Poison III",	
		[703]	=	"Wound Poison",
		[704]	=	"Wound Poison II",
		[705]	=	"Wound Poison III",
		[706]	=	"Wound Poison IV",
		[2644]	=	"Wound Poison V",
		[3772]	=	"Wound Poison VI",
		[3773]	=	"Wound Poison VII",
	}
-- Auras
	ids.Player_Buff = {
	
	}
	ids.Player_Debuff = {

	}
	ids.Target_Debuff = {
	
	}
	ids.optionMaxIds = {
		
	}