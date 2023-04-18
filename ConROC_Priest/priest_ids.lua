local ConROC_Priest, ids = ...;

--General
	ids.Racial = {

	}
	ids.Spec = {
		Discipline = 1,
		Holy = 2,
		Shadow = 3,
	}
	ids.Caster = {
		Shoot = 5019,
	}
--Discipline
	ids.Disc_Ability = {
		DispelMagicRank1 = 527,
		DispelMagicRank2 = 988,
		DivineSpiritRank1 = 14752,
		DivineSpiritRank2 = 14818,
		DivineSpiritRank3 = 14819,
		DivineSpiritRank4 = 27841,
		InnerFireRank1 = 588,
		InnerFireRank2 = 7128,
		InnerFireRank3 = 602,
		InnerFireRank4 = 1006,
		InnerFireRank5 = 10951,
		InnerFireRank6 = 10952,
		InnerFocus = 14751,
		Levitate = 1706,
		ManaBurnRank1 = 8129,
		ManaBurnRank2 = 8131,
		ManaBurnRank3 = 10874,
		ManaBurnRank4 = 10875,
		ManaBurnRank5 = 10876,
		PowerInfusion = 10060,
		PrayerofSpiritRank1 = 27681,
		PowerWordFortitudeRank1 = 1243,
		PowerWordFortitudeRank2 = 1244,
		PowerWordFortitudeRank3 = 1245,
		PowerWordFortitudeRank4 = 2791,
		PowerWordFortitudeRank5 = 10937,
		PowerWordFortitudeRank6 = 10938,
		PowerWordShieldRank1 = 17,
		PowerWordShieldRank2 = 592,
		PowerWordShieldRank3 = 600,
		PowerWordShieldRank4 = 3747,
		PowerWordShieldRank5 = 6065,
		PowerWordShieldRank6 = 6066,
		PowerWordShieldRank7 = 10898,
		PowerWordShieldRank8 = 10899,
		PowerWordShieldRank9 = 10900,
		PowerWordShieldRank10 = 10901,
		ShackleUndeadRank1 = 9484,
		ShackleUndeadRank2 = 9485,
		ShackleUndeadRank3 = 10955,
	}
	ids.Disc_Talent = {
		UnbreakableWill = 1,
		WandSpecialization = 2,
		 
		SilentResolve = 3,
		ImprovedPowerWordFortitude = 4,
		ImprovedPowerWordShield = 5,

		Martyrdom = 6,
		 
		InnerFocus = 7,
		Meditation = 8,
		 
		ImprovedInnerFocus = 9,
		MentalAgility = 10,
		ImprovedManaBurn = 11,
		 
		MentalStrength = 12,
		DivineSpirit = 13,
		 
		ForceofWill = 14,
		 
		PowerInfusion = 15,
	}	
--Holy
	ids.Holy_Ability = {
		AbolishDisease = 552,
		CureDisease = 528,
		DesperatePrayerRank1 = 13908,
		DesperatePrayerRank2 = 19236,
		DesperatePrayerRank3 = 19238,
		DesperatePrayerRank4 = 19240,
		DesperatePrayerRank5 = 19241,
		DesperatePrayerRank6 = 19242,
		DesperatePrayerRank7 = 19243,
		FlashHealRank1 = 2061,
		FlashHealRank2 = 9472,
		FlashHealRank3 = 9473,
		FlashHealRank4 = 9474,
		FlashHealRank5 = 10915,
		FlashHealRank6 = 10916,
		FlashHealRank7 = 10917,
		GreaterHealRank1 = 2060,
		GreaterHealRank2 = 10963,
		GreaterHealRank3 = 10964,
		GreaterHealRank4 = 10965,
		HealRank1 = 2054,
		HealRank2 = 2055,
		HealRank3 = 6063,
		HealRank4 = 6064,
		HolyFireRank1 = 14914,
		HolyFireRank2 = 15262,
		HolyFireRank3 = 15263,
		HolyFireRank4 = 15264,
		HolyFireRank5 = 15265,
		HolyFireRank6 = 15266,
		HolyFireRank7 = 15267,
		HolyFireRank8 = 15261,
		HolyNovaRank1 = 15237,
		HolyNovaRank2 = 15430,
		HolyNovaRank3 = 15431,
		HolyNovaRank4 = 27799,
		HolyNovaRank5 = 27800,
		HolyNovaRank6 = 27801,
		LesserHealRank1 = 2050,
		LesserHealRank2 = 2052,
		LesserHealRank3 = 2053,		
		LightwellRank1 = 724,
		LightwellRank2 = 27870,
		LightwellRank3 = 27871,
		PrayerofHealingRank1 = 596,
		PrayerofHealingRank2 = 996,
		PrayerofHealingRank3 = 10960,
		PrayerofHealingRank4 = 10961,
		RenewRank1 = 139,
		RenewRank2 = 6074,
		RenewRank3 = 6075,
		RenewRank4 = 6076,
		RenewRank5 = 6077,
		RenewRank6 = 6078,
		RenewRank7 = 10927,
		RenewRank8 = 10928,
		RenewRank9 = 10929,
		ResurrectionRank1 = 2006,
		ResurrectionRank2 = 2010,
		ResurrectionRank3 = 10880,
		ResurrectionRank4 = 10881,
		ResurrectionRank5 = 20770,
		SmiteRank1 = 585,
		SmiteRank2 = 591,
		SmiteRank3 = 598,
		SmiteRank4 = 984,
		SmiteRank5 = 1004,
		SmiteRank6 = 6060,
		SmiteRank7 = 10933,
		SmiteRank8 = 10934,
	}
	ids.Holy_Talent = {
		HealingFocus = 1,
		ImprovedRenew = 2,
		HolySpecialization = 3,
		 
		SpellWarding = 4,
		DivineFury = 5,
		 
		HolyNova = 6,
		BlessedRecovery = 7,
		Inspiration = 8,
		 
		HolyReach = 9,
		ImprovedHealing = 10,
		SearingLight = 11,
		 
		ImprovedPrayerofHealing = 12,
		SpiritofRedemption = 13,
		SpiritualGuidance = 14,
		 
		SpiritualHealing = 15,
		 
		Lightwell = 16,
	}
--Shadow
	ids.Shad_Ability = {
		FadeRank1 = 586,
		FadeRank2 = 9578,
		FadeRank3 = 9579,
		FadeRank4 = 9592,
		FadeRank5 = 10941,
		FadeRank6 = 10942,
		HexofWeaknessRank1 = 9035,
		HexofWeaknessRank2 = 19281,
		HexofWeaknessRank3 = 19282,
		HexofWeaknessRank4 = 19283,
		HexofWeaknessRank5 = 19284,
		HexofWeaknessRank6 = 19285,
		MindBlastRank1 = 8092,
		MindBlastRank2 = 8102,
		MindBlastRank3 = 8103,
		MindBlastRank4 = 8104,
		MindBlastRank5 = 8105,
		MindBlastRank6 = 8106,
		MindBlastRank7 = 10945,
		MindBlastRank8 = 10946,
		MindBlastRank9 = 10947,
		MindControlRank1 = 605,
		MindControlRank2 = 10911,
		MindControlRank3 = 10912,
		MindFlayRank1 = 15407,
		MindFlayRank2 = 17311,
		MindFlayRank3 = 17312,
		MindFlayRank4 = 17313,
		MindFlayRank5 = 17314,
		MindFlayRank6 = 18807,
		MindSootheRank1 = 453,
		MindSootheRank2 = 8192,
		MindSootheRank3 = 10953,
		MindVisionRank1 = 2096,
		MindVisionRank2 = 10909,
		PsychicScreamRank1 = 8122,
		PsychicScreamRank2 = 8124,
		PsychicScreamRank3 = 10888,
		PsychicScreamRank4 = 10890,
		ShadowProtectionRank1 = 976,
		ShadowProtectionRank2 = 10957,
		ShadowProtectionRank3 = 10958,
		ShadowWordPainRank1 = 589,
		ShadowWordPainRank2 = 594,
		ShadowWordPainRank3 = 970,
		ShadowWordPainRank4 = 992,
		ShadowWordPainRank5 = 2767,
		ShadowWordPainRank6 = 10892,
		ShadowWordPainRank7 = 10893,
		ShadowWordPainRank8 = 10894,
		TouchofWeaknessRank1 = 2652,
		TouchofWeaknessRank2 = 19261,
		TouchofWeaknessRank3 = 19262,
		TouchofWeaknessRank4 = 19264,
		TouchofWeaknessRank5 = 19265,
		TouchofWeaknessRank6 = 19266,
		Shadowform = 15473,
		Silence = 15487,
		VampiricEmbrace = 15286,
	}
	ids.Shad_Talent = {
		SpiritTap = 1,
		Blackout = 2,
		 
		ShadowAffinity = 3,
		ImprovedShadowWordPain = 4,
		ShadowFocus = 5,
		 
		ImprovedPsychicScream = 6,
		ImprovedMindBlast = 7,
		MindFlay = 8,
		 
		ImprovedFade = 9,
		ShadowReach = 10,
		ShadowWeaving = 11,
		 
		Silence = 12,
		VampiricEmbrace = 13,
		ImprovedVampiricEmbrace = 14,
		 
		Darkness = 15,
		 
		Shadowform = 16,
	}
-- Auras
	ids.Player_Buff = {
	
	}
	ids.Player_Debuff = {
		WeakendSoul = 6788,
	}
	ids.Target_Debuff = {
		TouchofWeaknessRank1 = 2943,
		TouchofWeaknessRank2 = 19249,
		TouchofWeaknessRank3 = 19251,
		TouchofWeaknessRank4 = 19252,
		TouchofWeaknessRank5 = 19253,
		TouchofWeaknessRank6 = 19254,	
	}