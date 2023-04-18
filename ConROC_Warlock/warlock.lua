ConROC.Warlock = {};

local ConROC_Warlock, ids = ...;

function ConROC:EnableRotationModule()
	self.Description = 'Warlock';
	self.NextSpell = ConROC.Warlock.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;	
	
	ConROC:SpellmenuClass();
--	ConROCSpellmenuFrame:Hide();
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Warlock.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

local Racial, Spec, Caster, Aff_Ability, Aff_Talent, Demo_Ability, Demo_Talent, Dest_Ability, Dest_Talent, Pet, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Caster, ids.Aff_Ability, ids.Aff_Talent, ids.Demo_Ability, ids.Demo_Talent, ids.Dest_Ability, ids.Dest_Talent, ids.Pet, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;

function ConROC.Warlock.Damage(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');

--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPercent 										= math.max(0, mana) / math.max(1, manaMax) * 100;
	local soulShards										= GetItemCount(6265);

--Ranks
	--Affliction
	local _Corruption = Aff_Ability.CorruptionRank1;
	local _CurseofAgony = Aff_Ability.CurseofAgonyRank1;
	local _CurseofRecklessness = Aff_Ability.CurseofRecklessnessRank1;
	local _CurseofShadow = Aff_Ability.CurseofShadowRank1;
	local _CurseofTongues = Aff_Ability.CurseofTonguesRank1;
	local _CurseoftheElements = Aff_Ability.CurseoftheElementsRank1;
	local _CurseofWeakness = Aff_Ability.CurseofWeaknessRank1;
	local _DarkPact = Aff_Ability.DarkPactRank1;
	local _DeathCoil = Aff_Ability.DeathCoilRank1;
	local _DrainMana = Aff_Ability.DrainManaRank1;
	local _DrainSoul = Aff_Ability.DrainSoulRank1;
	local _Fear = Aff_Ability.FearRank1;
	local _HowlofTerror = Aff_Ability.HowlofTerrorRank1;
	local _LifeTap = Aff_Ability.LifeTapRank1;
	local _SiphonLife = Aff_Ability.SiphonLifeRank1;
	
	if IsSpellKnown(Aff_Ability.CorruptionRank7) then _Corruption = Aff_Ability.CorruptionRank7;
	elseif IsSpellKnown(Aff_Ability.CorruptionRank6) then _Corruption = Aff_Ability.CorruptionRank6;
	elseif IsSpellKnown(Aff_Ability.CorruptionRank5) then _Corruption = Aff_Ability.CorruptionRank5;
	elseif IsSpellKnown(Aff_Ability.CorruptionRank4) then _Corruption = Aff_Ability.CorruptionRank4;
	elseif IsSpellKnown(Aff_Ability.CorruptionRank3) then _Corruption = Aff_Ability.CorruptionRank3;
	elseif IsSpellKnown(Aff_Ability.CorruptionRank2) then _Corruption = Aff_Ability.CorruptionRank2; end

	if IsSpellKnown(Aff_Ability.CurseofAgonyRank6) then _CurseofAgony = Aff_Ability.CurseofAgonyRank6;
	elseif IsSpellKnown(Aff_Ability.CurseofAgonyRank5) then _CurseofAgony = Aff_Ability.CurseofAgonyRank5;
	elseif IsSpellKnown(Aff_Ability.CurseofAgonyRank4) then _CurseofAgony = Aff_Ability.CurseofAgonyRank4;
	elseif IsSpellKnown(Aff_Ability.CurseofAgonyRank3) then _CurseofAgony = Aff_Ability.CurseofAgonyRank3;
	elseif IsSpellKnown(Aff_Ability.CurseofAgonyRank2) then _CurseofAgony = Aff_Ability.CurseofAgonyRank2; end

	if IsSpellKnown(Aff_Ability.CurseofRecklessnessRank4) then _CurseofRecklessness = Aff_Ability.CurseofRecklessnessRank4;
	elseif IsSpellKnown(Aff_Ability.CurseofRecklessnessRank3) then _CurseofRecklessness = Aff_Ability.CurseofRecklessnessRank3;
	elseif IsSpellKnown(Aff_Ability.CurseofRecklessnessRank2) then _CurseofRecklessness = Aff_Ability.CurseofRecklessnessRank2; end

	if IsSpellKnown(Aff_Ability.CurseofShadowRank2) then _CurseofShadow = Aff_Ability.CurseofShadowRank2; end

	if IsSpellKnown(Aff_Ability.CurseofTonguesRank2) then _CurseofTongues = Aff_Ability.CurseofTonguesRank2; end

	if IsSpellKnown(Aff_Ability.CurseoftheElementsRank3) then _CurseoftheElements = Aff_Ability.CurseoftheElementsRank3;
	elseif IsSpellKnown(Aff_Ability.CurseoftheElementsRank2) then _CurseoftheElements = Aff_Ability.CurseoftheElementsRank2; end

	if IsSpellKnown(Aff_Ability.CurseofWeaknessRank6) then _CurseofWeakness = Aff_Ability.CurseofWeaknessRank6;
	elseif IsSpellKnown(Aff_Ability.CurseofWeaknessRank5) then _CurseofWeakness = Aff_Ability.CurseofWeaknessRank5;
	elseif IsSpellKnown(Aff_Ability.CurseofWeaknessRank4) then _CurseofWeakness = Aff_Ability.CurseofWeaknessRank4;
	elseif IsSpellKnown(Aff_Ability.CurseofWeaknessRank3) then _CurseofWeakness = Aff_Ability.CurseofWeaknessRank3;
	elseif IsSpellKnown(Aff_Ability.CurseofWeaknessRank2) then _CurseofWeakness = Aff_Ability.CurseofWeaknessRank2; end
	
	if IsSpellKnown(Aff_Ability.DarkPactRank3) then _DarkPact = Aff_Ability.DarkPactRank3;
	elseif IsSpellKnown(Aff_Ability.DarkPactRank2) then _DarkPact = Aff_Ability.DarkPactRank2; end

	if IsSpellKnown(Aff_Ability.DeathCoilRank3) then _DeathCoil = Aff_Ability.DeathCoilRank3;
	elseif IsSpellKnown(Aff_Ability.DeathCoilRank2) then _DeathCoil = Aff_Ability.DeathCoilRank2; end

	if IsSpellKnown(Aff_Ability.DrainManaRank4) then _DrainMana = Aff_Ability.DrainManaRank4;
	elseif IsSpellKnown(Aff_Ability.DrainManaRank3) then _DrainMana = Aff_Ability.DrainManaRank3;
	elseif IsSpellKnown(Aff_Ability.DrainManaRank2) then _DrainMana = Aff_Ability.DrainManaRank2; end
	
	if IsSpellKnown(Aff_Ability.DrainSoulRank4) then _DrainSoul = Aff_Ability.DrainSoulRank4;
	elseif IsSpellKnown(Aff_Ability.DrainSoulRank3) then _DrainSoul = Aff_Ability.DrainSoulRank3;
	elseif IsSpellKnown(Aff_Ability.DrainSoulRank2) then _DrainSoul = Aff_Ability.DrainSoulRank2; end	
	
	if IsSpellKnown(Aff_Ability.FearRank3) then _Fear = Aff_Ability.FearRank3;
	elseif IsSpellKnown(Aff_Ability.FearRank2) then _Fear = Aff_Ability.FearRank2; end

	if IsSpellKnown(Aff_Ability.HowlofTerrorRank2) then _HowlofTerror = Aff_Ability.HowlofTerrorRank2; end

	if IsSpellKnown(Aff_Ability.LifeTapRank6) then _LifeTap = Aff_Ability.LifeTapRank6;
	elseif IsSpellKnown(Aff_Ability.LifeTapRank5) then _LifeTap = Aff_Ability.LifeTapRank5;
	elseif IsSpellKnown(Aff_Ability.LifeTapRank4) then _LifeTap = Aff_Ability.LifeTapRank4;
	elseif IsSpellKnown(Aff_Ability.LifeTapRank3) then _LifeTap = Aff_Ability.LifeTapRank3;
	elseif IsSpellKnown(Aff_Ability.LifeTapRank2) then _LifeTap = Aff_Ability.LifeTapRank2; end

	if IsSpellKnown(Aff_Ability.SiphonLifeRank4) then _SiphonLife = Aff_Ability.SiphonLifeRank4;
	elseif IsSpellKnown(Aff_Ability.SiphonLifeRank3) then _SiphonLife = Aff_Ability.SiphonLifeRank3;
	elseif IsSpellKnown(Aff_Ability.SiphonLifeRank2) then _SiphonLife = Aff_Ability.SiphonLifeRank2; end

	--Demonology
	local _Banish = Demo_Ability.BanishRank1;
	local _CreateFirestone = Demo_Ability.CreateFirestoneLesser;
	local _CreateHealthstone = Demo_Ability.CreateHealthstoneMinor;
	local _CreateSoulstone = Demo_Ability.CreateSoulstoneMinor;	
	local _CreateSpellstone = Demo_Ability.CreateSpellstone;
	local _DetectInvisibility = Demo_Ability.DetectLesserInvisibility;
	local _EnslaveDemon = Demo_Ability.EnslaveDemonRank1;
	
	if IsSpellKnown(Demo_Ability.BanishRank2) then _Banish = Demo_Ability.BanishRank2; end

	if IsSpellKnown(Demo_Ability.CreateFirestoneMajor) then _CreateFirestone = Demo_Ability.CreateFirestoneMajor;
	elseif IsSpellKnown(Demo_Ability.CreateFirestoneGreater) then _CreateFirestone = Demo_Ability.CreateFirestoneGreater;
	elseif IsSpellKnown(Demo_Ability.CreateFirestone) then _CreateFirestone = Demo_Ability.CreateFirestone; end

	if IsSpellKnown(Demo_Ability.CreateHealthstoneMajor) then _CreateHealthstone = Demo_Ability.CreateHealthstoneMajor;
	elseif IsSpellKnown(Demo_Ability.CreateHealthstoneGreater) then _CreateHealthstone = Demo_Ability.CreateHealthstoneGreater;
	elseif IsSpellKnown(Demo_Ability.CreateHealthstone) then _CreateHealthstone = Demo_Ability.CreateHealthstone;
	elseif IsSpellKnown(Demo_Ability.CreateHealthstoneLesser) then _CreateHealthstone = Demo_Ability.CreateHealthstoneLesser; end

	if IsSpellKnown(Demo_Ability.CreateSoulstoneMajor) then _CreateSoulstone = Demo_Ability.CreateSoulstoneMajor;
	elseif IsSpellKnown(Demo_Ability.CreateSoulstoneGreater) then _CreateSoulstone = Demo_Ability.CreateSoulstoneGreater;
	elseif IsSpellKnown(Demo_Ability.CreateSoulstone) then _CreateSoulstone = Demo_Ability.CreateSoulstone;
	elseif IsSpellKnown(Demo_Ability.CreateSoulstoneLesser) then _CreateSoulstone = Demo_Ability.CreateSoulstoneLesser; end

	if IsSpellKnown(Demo_Ability.CreateSpellstoneMajor) then _CreateSpellstone = Demo_Ability.CreateSpellstoneMajor;
	elseif IsSpellKnown(Demo_Ability.CreateSpellstoneGreater) then _CreateSpellstone = Demo_Ability.CreateSpellstoneGreater; end
	
	if IsSpellKnown(Demo_Ability.DetectGreaterInvisibility) then _DetectInvisibility = Demo_Ability.DetectGreaterInvisibility;
	elseif IsSpellKnown(Demo_Ability.DetectInvisibility) then _DetectInvisibility = Demo_Ability.DetectInvisibility; end
	
	if IsSpellKnown(Demo_Ability.EnslaveDemonRank3) then _EnslaveDemon = Demo_Ability.EnslaveDemonRank3;
	elseif IsSpellKnown(Demo_Ability.EnslaveDemonRank2) then _EnslaveDemon = Demo_Ability.EnslaveDemonRank2; end

	--Destruction
	local _Conflagrate = Dest_Ability.ConflagrateRank1;
	local _Hellfire = Dest_Ability.HellfireRank1;
	local _Immolate = Dest_Ability.ImmolateRank1;
	local _RainofFire = Dest_Ability.RainofFireRank1;
	local _SearingPain = Dest_Ability.SearingPainRank1;
	local _ShadowBolt = Dest_Ability.ShadowBoltRank1;
	local _Shadowburn = Dest_Ability.ShadowburnRank1;
	local _SoulFire = Dest_Ability.SoulFireRank1;
	
	if IsSpellKnown(Dest_Ability.ConflagrateRank4) then _Conflagrate = Dest_Ability.ConflagrateRank4;
	elseif IsSpellKnown(Dest_Ability.ConflagrateRank3) then _Conflagrate = Dest_Ability.ConflagrateRank3;
	elseif IsSpellKnown(Dest_Ability.ConflagrateRank2) then _Conflagrate = Dest_Ability.ConflagrateRank2; end
	
	if IsSpellKnown(Dest_Ability.HellfireRank3) then _Hellfire = Dest_Ability.HellfireRank3;
	elseif IsSpellKnown(Dest_Ability.HellfireRank2) then _Hellfire = Dest_Ability.HellfireRank2; end
	
	if IsSpellKnown(Dest_Ability.ImmolateRank8) then _Immolate = Dest_Ability.ImmolateRank8;
	elseif IsSpellKnown(Dest_Ability.ImmolateRank7) then _Immolate = Dest_Ability.ImmolateRank7;
	elseif IsSpellKnown(Dest_Ability.ImmolateRank6) then _Immolate = Dest_Ability.ImmolateRank6;
	elseif IsSpellKnown(Dest_Ability.ImmolateRank5) then _Immolate = Dest_Ability.ImmolateRank5;
	elseif IsSpellKnown(Dest_Ability.ImmolateRank4) then _Immolate = Dest_Ability.ImmolateRank4;
	elseif IsSpellKnown(Dest_Ability.ImmolateRank3) then _Immolate = Dest_Ability.ImmolateRank3;
	elseif IsSpellKnown(Dest_Ability.ImmolateRank2) then _Immolate = Dest_Ability.ImmolateRank2; end	
	
	if IsSpellKnown(Dest_Ability.RainofFireRank4) then _RainofFire = Dest_Ability.RainofFireRank4;
	elseif IsSpellKnown(Dest_Ability.RainofFireRank3) then _RainofFire = Dest_Ability.RainofFireRank3;
	elseif IsSpellKnown(Dest_Ability.RainofFireRank2) then _RainofFire = Dest_Ability.RainofFireRank2; end	
	
	if IsSpellKnown(Dest_Ability.SearingPainRank6) then _SearingPain = Dest_Ability.SearingPainRank6;
	elseif IsSpellKnown(Dest_Ability.SearingPainRank5) then _SearingPain = Dest_Ability.SearingPainRank5;
	elseif IsSpellKnown(Dest_Ability.SearingPainRank4) then _SearingPain = Dest_Ability.SearingPainRank4;
	elseif IsSpellKnown(Dest_Ability.SearingPainRank3) then _SearingPain = Dest_Ability.SearingPainRank3;
	elseif IsSpellKnown(Dest_Ability.SearingPainRank2) then _SearingPain = Dest_Ability.SearingPainRank2; end
	
	if IsSpellKnown(Dest_Ability.ShadowBoltRank10) then _ShadowBolt = Dest_Ability.ShadowBoltRank10;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank9) then _ShadowBolt = Dest_Ability.ShadowBoltRank9;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank8) then _ShadowBolt = Dest_Ability.ShadowBoltRank8;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank7) then _ShadowBolt = Dest_Ability.ShadowBoltRank7;	
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank6) then _ShadowBolt = Dest_Ability.ShadowBoltRank6;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank5) then _ShadowBolt = Dest_Ability.ShadowBoltRank5;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank4) then _ShadowBolt = Dest_Ability.ShadowBoltRank4;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank3) then _ShadowBolt = Dest_Ability.ShadowBoltRank3;
	elseif IsSpellKnown(Dest_Ability.ShadowBoltRank2) then _ShadowBolt = Dest_Ability.ShadowBoltRank2; end

	if IsSpellKnown(Dest_Ability.ShadowburnRank6) then _Shadowburn = Dest_Ability.ShadowburnRank6;
	elseif IsSpellKnown(Dest_Ability.ShadowburnRank5) then _Shadowburn = Dest_Ability.ShadowburnRank5;
	elseif IsSpellKnown(Dest_Ability.ShadowburnRank4) then _Shadowburn = Dest_Ability.ShadowburnRank4;
	elseif IsSpellKnown(Dest_Ability.ShadowburnRank3) then _Shadowburn = Dest_Ability.ShadowburnRank3;
	elseif IsSpellKnown(Dest_Ability.ShadowburnRank2) then _Shadowburn = Dest_Ability.ShadowburnRank2; end

	if IsSpellKnown(Dest_Ability.SoulFireRank2) then _SoulFire = Dest_Ability.SoulFireRank2; end
	
--Abilities
	local ampCurseRDY										= ConROC:AbilityReady(Aff_Ability.AmplifyCurse, timeShift);
	local corrRDY											= ConROC:AbilityReady(_Corruption, timeShift);
		local corrDEBUFF										= ConROC:TargetDebuff(_Corruption);
	local cofaRDY											= ConROC:AbilityReady(_CurseofAgony, timeShift);
		local cofaDEBUFF										= ConROC:TargetDebuff(_CurseofAgony);
	local cofdRDY											= ConROC:AbilityReady(Aff_Ability.CurseofDoom, timeShift);
		local cofdDEBUFF										= ConROC:TargetDebuff(Aff_Ability.CurseofDoom);		
	local cofeRDY											= ConROC:AbilityReady(Aff_Ability.CurseofExhaustion, timeShift);
		local cofeDEBUFF										= ConROC:TargetDebuff(Aff_Ability.CurseofExhaustion);			
	local cofrRDY											= ConROC:AbilityReady(_CurseofRecklessness, timeShift);
		local cofrDEBUFF										= ConROC:TargetDebuff(_CurseofRecklessness);		
	local cofsRDY											= ConROC:AbilityReady(_CurseofShadow, timeShift);
		local cofsDEBUFF										= ConROC:TargetDebuff(_CurseofShadow);
	local coftRDY											= ConROC:AbilityReady(_CurseofTongues, timeShift);
		local coftDEBUFF										= ConROC:TargetDebuff(_CurseofTongues);		
	local cofteRDY											= ConROC:AbilityReady(_CurseoftheElements, timeShift);
		local cofteDEBUFF										= ConROC:TargetDebuff(_CurseoftheElements);
	local cofwRDY											= ConROC:AbilityReady(_CurseofWeakness, timeShift);
		local cofwDEBUFF										= ConROC:TargetDebuff(_CurseofWeakness);
	local dPactRDY											= ConROC:AbilityReady(_DarkPact, timeShift);
	local dCoilRDY											= ConROC:AbilityReady(_DeathCoil, timeShift);
	local dManaRDY											= ConROC:AbilityReady(_DrainMana, timeShift);
	local dSoulRDY											= ConROC:AbilityReady(_DrainSoul, timeShift);
	local fearRDY											= ConROC:AbilityReady(_Fear, timeShift);	
	local hoftRDY											= ConROC:AbilityReady(_HowlofTerror, timeShift);	
	local lTapRDY											= ConROC:AbilityReady(_LifeTap, timeShift);	
	local slifeRDY											= ConROC:AbilityReady(_SiphonLife, timeShift);
		local slifeDEBUFF										= ConROC:TargetDebuff(_SiphonLife);

	local banishRDY											= ConROC:AbilityReady(_Banish, timeShift);	
	local cFirestoneRDY										= ConROC:AbilityReady(_CreateFirestone, timeShift);	
	local cHealthstoneRDY									= ConROC:AbilityReady(_CreateHealthstone, timeShift);	
	local cSoulstoneRDY										= ConROC:AbilityReady(_CreateSoulstone, timeShift);	
	local cSpellstoneRDY									= ConROC:AbilityReady(_CreateSpellstone, timeShift);	
	local dSacRDY											= ConROC:AbilityReady(Demo_Ability.DemonicSacrifice, timeShift);
	local detInvisRDY										= ConROC:AbilityReady(_DetectInvisibility, timeShift);
	local enDemonRDY										= ConROC:AbilityReady(_EnslaveDemon, timeShift);	
	local felDomRDY											= ConROC:AbilityReady(Demo_Ability.FelDomination, timeShift);
	local sumFelhRDY										= ConROC:AbilityReady(Demo_Ability.SummonFelhunter, timeShift);
	local sumImpRDY											= ConROC:AbilityReady(Demo_Ability.SummonImp, timeShift);
	local sumSucRDY											= ConROC:AbilityReady(Demo_Ability.SummonSuccubus, timeShift);
	local sumVoidRDY										= ConROC:AbilityReady(Demo_Ability.SummonVoidwalker, timeShift);

	local confRDY											= ConROC:AbilityReady(_Conflagrate, timeShift);	
	local hfireRDY											= ConROC:AbilityReady(_Hellfire, timeShift);
	local immoRDY											= ConROC:AbilityReady(_Immolate, timeShift);
		local immoDEBUFF										= ConROC:TargetDebuff(_Immolate);
	local roffireRDY										= ConROC:AbilityReady(_RainofFire, timeShift);
	local sPainRDY											= ConROC:AbilityReady(_SearingPain, timeShift);
	local sBoltRDY											= ConROC:AbilityReady(_ShadowBolt, timeShift);
		local sTranceBUFF										= ConROC:Buff(Player_Buff.ShadowTrance, timeShift);
	local sburnRDY											= ConROC:AbilityReady(_Shadowburn, timeShift);
	local sfireRDY											= ConROC:AbilityReady(_SoulFire, timeShift);
	
--Conditions		
	local summoned 											= ConROC:CallPet();
--	local HasVoid											= IsSpellKnown(ids.Aff_PetAbility.ThreateningPresence, true);
	local assist 											= ConROC:PetAssist();
	local moving 											= ConROC:PlayerSpeed();
	local incombat 											= UnitAffectingCombat('player');
	local inmelee											= CheckInteractDistance("target", 3);
	local targetPh 											= ConROC:PercentHealth('target');	
	local playerPh 											= ConROC:PercentHealth('player');	
	local hasWand											= HasWandEquipped();
	local tarHasMana 										= UnitPower('target', Enum.PowerType.Mana);

    local dSacBUFF = {
		fe														= ConROC:Buff(Player_Buff.FelEnergy);
		bw														= ConROC:Buff(Player_Buff.BurningWish);
		tofs													= ConROC:Buff(Player_Buff.TouchofShadow);	
		fs														= ConROC:Buff(Player_Buff.FelStamina);
    }	

	local dSacUp = false;
		for k, v in pairs(dSacBUFF) do
			if v then
				dSacUp = true;
				break
			end
		end
		
--Indicators
	ConROC:AbilityBurst(_SoulFire, sfireRDY);
	ConROC:AbilityBurst(Aff_Ability.AmplifyCurse, ampCurseRDY and (ConROC:CheckBox(ConROC_SM_Curse_Weakness) or ConROC:CheckBox(ConROC_SM_Curse_Agony)));
	
--Warnings
	if not assist and summoned and incombat then
		UIErrorsFrame:AddMessage("Pet is NOT attacking!!!", 1.0, 0.0, 0.0, 53, 5);
	end

--Rotations	
	--Demons--
	if ConROC:CheckBox(ConROC_SM_Demon_Felhunter) and sumFelhRDY and not summoned and not dSacUp then
		return Demo_Ability.SummonFelhunter;
	end

	if ConROC:CheckBox(ConROC_SM_Demon_Imp) and sumImpRDY and not summoned and not dSacUp then
		return Demo_Ability.SummonImp;
	end

	if ConROC:CheckBox(ConROC_SM_Demon_Succubus) and sumSucRDY and not summoned and not dSacUp then
		return Demo_Ability.SummonSuccubus;
	end

	if ConROC:CheckBox(ConROC_SM_Demon_Voidwalker) and sumVoidRDY and not summoned and not dSacUp then
		return Demo_Ability.SummonVoidwalker;
	end
	--
	
	if sBoltRDY and sTranceBUFF then
		return _ShadowBolt;
	end
	
	if confRDY and immoDEBUFF then
		return _Conflagrate;
	end
	
	if sburnRDY and ((ConROC:Raidmob() and targetPh <= 5) or (not ConROC:Raidmob() and targetPh <= 20)) then
		return _Shadowburn;
	end
	
	if dSoulRDY and ConROC:SoulShards() < ConROC_SM_Option_SoulShard:GetNumber() and ((ConROC:Raidmob() and targetPh <= 5) or (not ConROC:Raidmob() and targetPh <= 20)) then --Soul Shard counter needed.
		return _DrainSoul;
	end
	
	if dManaRDY and tarHasMana > 0 and manaPercent < 20 then
		return _DrainMana;
	end
	
	if lTapRDY and manaPercent < 20 and playerPh >= 30 then
		return _LifeTap;
	end

	if ConROC_AoEButton:IsVisible() and hfireRDY and inMelee and playerPh >= 30 then
		return _Hellfire;
	end
	
	if ConROC_AoEButton:IsVisible() and roffireRDY then
		return _RainofFire;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_Corruption) and corrRDY and not corrDEBUFF and currentSpell ~= _Corruption and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then
		return _Corruption;
	end	

	--Curses
	if ConROC:CheckBox(ConROC_SM_Curse_Weakness) and cofwRDY and not cofwDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then 
		return _CurseofWeakness;
	end
	
	if ConROC:CheckBox(ConROC_SM_Curse_Agony) and cofaRDY and not cofaDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then 
		return _CurseofAgony;
	end

	if ConROC:CheckBox(ConROC_SM_Curse_Recklessness) and cofrRDY and not cofrDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then 
		return _CurseofRecklessness;
	end

	if ConROC:CheckBox(ConROC_SM_Curse_Tongues) and coftRDY and not coftDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then 
		return _CurseofTongues;
	end

	if ConROC:CheckBox(ConROC_SM_Curse_Exhaustion) and cofeRDY and not cofeDEBUFF then 
		return Aff_Ability.CurseofExhaustion;
	end

	if ConROC:CheckBox(ConROC_SM_Curse_Elements) and cofteRDY and not cofteDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then 
		return _CurseoftheElements;
	end

	if ConROC:CheckBox(ConROC_SM_Curse_Shadow) and cofsRDY and not cofsDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then 
		return _CurseofShadow;
	end

	if ConROC:CheckBox(ConROC_SM_Curse_Doom) and cofdRDY and not cofdDEBUFF and ((ConROC:Raidmob() and targetPh >= 75) or (not ConROC:Raidmob() and targetPh == 100)) then 
		return Aff_Ability.CurseofDoom;
	end	
	--
	
	if ConROC:CheckBox(ConROC_SM_Debuff_SiphonLife) and slifeRDY and not slifeDEBUFF and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then
		return _SiphonLife;
	end		
	
	if ConROC:CheckBox(ConROC_SM_Debuff_Immolate) and immoRDY and not immoDEBUFF and currentSpell ~= _Immolate and ((ConROC:Raidmob() and targetPh >= 5) or (not ConROC:Raidmob() and targetPh >= 20)) then
		return _Immolate;
	end

	if ConROC:CheckBox(ConROC_SM_Option_UseWand) and hasWand and (manaPercent <= 20 or targetPh <= 5) then
		return Caster.Shoot;
	end	
	
	if ConROC:CheckBox(ConROC_SM_Spell_ShadowBolt) and sBoltRDY then
		return _ShadowBolt;
	end
	
	if ConROC:CheckBox(ConROC_SM_Spell_SearingPain) and sPainRDY then
		return _SearingPain;
	end

	return nil;
end

function ConROC.Warlock.Defense(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');

--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPercent 										= math.max(0, mana) / math.max(1, manaMax) * 100;
	local soulShards										= GetItemCount(6265);

--Ranks
	--Affliction
	local _DrainLife = Aff_Ability.DrainLifeRank1;

	if IsSpellKnown(Aff_Ability.DrainLifeRank6) then _DrainLife = Aff_Ability.DrainLifeRank6;
	elseif IsSpellKnown(Aff_Ability.DrainLifeRank5) then _DrainLife = Aff_Ability.DrainLifeRank5;
	elseif IsSpellKnown(Aff_Ability.DrainLifeRank4) then _DrainLife = Aff_Ability.DrainLifeRank4;
	elseif IsSpellKnown(Aff_Ability.DrainLifeRank3) then _DrainLife = Aff_Ability.DrainLifeRank3;
	elseif IsSpellKnown(Aff_Ability.DrainLifeRank2) then _DrainLife = Aff_Ability.DrainLifeRank2; end	
	
	--Demonology
	local _DemonArmor = Demo_Ability.DemonSkinRank1;
	local _HealthFunnel = Demo_Ability.HealthFunnelRank1;
	local _ShadowWard = Demo_Ability.ShadowWardRank1;
	
	if IsSpellKnown(Demo_Ability.DemonArmorRank5) then _DemonArmor = Demo_Ability.DemonArmorRank5;
	elseif IsSpellKnown(Demo_Ability.DemonArmorRank4) then _DemonArmor = Demo_Ability.DemonArmorRank4;
	elseif IsSpellKnown(Demo_Ability.DemonArmorRank3) then _DemonArmor = Demo_Ability.DemonArmorRank3;
	elseif IsSpellKnown(Demo_Ability.DemonArmorRank2) then _DemonArmor = Demo_Ability.DemonArmorRank2;
	elseif IsSpellKnown(Demo_Ability.DemonArmorRank1) then _DemonArmor = Demo_Ability.DemonArmorRank1;
	elseif IsSpellKnown(Demo_Ability.DemonSkinRank2) then _DemonArmor = Demo_Ability.DemonSkinRank2; end	

	if IsSpellKnown(Demo_Ability.HealthFunnelRank7) then _HealthFunnel = Demo_Ability.HealthFunnelRank7;
	elseif IsSpellKnown(Demo_Ability.HealthFunnelRank6) then _HealthFunnel = Demo_Ability.HealthFunnelRank6;
	elseif IsSpellKnown(Demo_Ability.HealthFunnelRank5) then _HealthFunnel = Demo_Ability.HealthFunnelRank5;
	elseif IsSpellKnown(Demo_Ability.HealthFunnelRank4) then _HealthFunnel = Demo_Ability.HealthFunnelRank4;
	elseif IsSpellKnown(Demo_Ability.HealthFunnelRank3) then _HealthFunnel = Demo_Ability.HealthFunnelRank3;
	elseif IsSpellKnown(Demo_Ability.HealthFunnelRank2) then _HealthFunnel = Demo_Ability.HealthFunnelRank2; end

	if IsSpellKnown(Demo_Ability.ShadowWardRank3) then _ShadowWard = Demo_Ability.ShadowWardRank3;
	elseif IsSpellKnown(Demo_Ability.ShadowWardRank2) then _ShadowWard = Demo_Ability.ShadowWardRank2; end
	
--Abilities
	local dLifeRDY											= ConROC:AbilityReady(_DrainLife, timeShift);
	
	local dArmorRDY											= ConROC:AbilityReady(_DemonArmor, timeShift);
		local dArmorBUFF, _, dArmorDUR							= ConROC:Buff(_DemonArmor, timeShift);	
	local hFunnelRDY										= ConROC:AbilityReady(_HealthFunnel, timeShift);
	local sWardRDY											= ConROC:AbilityReady(_ShadowWard, timeShift);
		local sWardBUFF											= ConROC:Buff(_ShadowWard, timeShift);	
	local sLinkRDY											= ConROC:AbilityReady(Demo_Ability.SoulLink, timeShift);
		local sLinkBUFF											= ConROC:Buff(Demo_Ability.SoulLink, timeShift);	
		
--Conditions	
	local petPh												= ConROC:PercentHealth('pet');
	local summoned 											= ConROC:CallPet();
	local playerPh 											= ConROC:PercentHealth('player');	
	
--Rotations	
	if dArmorRDY and not dArmorBUFF then
		return _DemonArmor;
	end
	
	if sLinkRDY and not sLinkBUFF then
		return Demo_Ability.SoulLink;
	end	

	if dLifeRDY and playerPh <= 30 then
		return _DrainLife;
	end
	
	if hFunnelRDY and petPh <= 25 and playerPh >= 50 and not ConROC:TarYou() then
		return _HealthFunnel;
	end
	
	return nil;
end

function ConROC:SoulShards()
	local SoulShardItemID = 6265;
	local numShards = 0;
	for bag = 0, 5 do 
		for slot = GetContainerNumSlots(bag), 1, -1 do
			if GetContainerItemID(bag, slot) == SoulShardItemID then
				numShards = numShards + 1;
			end
		end
	end
	return numShards;
end