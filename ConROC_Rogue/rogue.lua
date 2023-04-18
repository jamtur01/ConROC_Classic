ConROC.Rogue = {};

local ConROC_Rogue, ids = ...;

function ConROC:EnableRotationModule()
	self.Description = 'Rogue';
	self.NextSpell = ConROC.Rogue.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
	
	ConROC:SpellmenuClass();
--	ConROCSpellmenuFrame:Hide();	
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Rogue.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

	local Racial, Spec, Ass_Ability, Ass_Talent, Com_Ability, Com_Talent, Sub_Ability, Sub_Talent, Poisons, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Ass_Ability, ids.Ass_Talent, ids.Com_Ability, ids.Com_Talent, ids.Sub_Ability, ids.Sub_Talent, ids.Poisons, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;

	local _Ambush = Ass_Ability.AmbushRank1;
	local _Eviscerate = Ass_Ability.EviscerateRank1;	
	local _ExposeArmor = Ass_Ability.ExposeArmorRank1;	
	local _Garrote = Ass_Ability.GarroteRank1;	
	local _KidneyShot = Ass_Ability.KidneyShotRank1;	
	local _Rupture = Ass_Ability.RuptureRank1;	
	local _SliceandDice = Ass_Ability.SliceandDiceRank1;
	
	local _Backstab = Com_Ability.BackstabRank1;
	local _Feint = Com_Ability.FeintRank1;
	local _Gouge = Com_Ability.GougeRank1;
	local _Kick = Com_Ability.KickRank1;
	local _SinisterStrike = Com_Ability.SinisterStrikeRank1;
	local _Sprint = Com_Ability.SprintRank1;
	
	local _Hemorrhage = Sub_Ability.HemorrhageRank1;
	local _Sap = Sub_Ability.SapRank1;
	local _Stealth = Sub_Ability.StealthRank1;
	local _Vanish = Sub_Ability.VanishRank1;
	
function ConROC.Rogue.Damage(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');

--Racials

--Resources
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);
	local energyPercent 									= math.max(0, energy) / math.max(1, energyMax) * 100;	
    local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local comboMax 											= UnitPowerMax('player', Enum.PowerType.ComboPoints);

--Ranks
	if IsSpellKnown(Ass_Ability.AmbushRank6) then _Ambush = Ass_Ability.AmbushRank6;
	elseif IsSpellKnown(Ass_Ability.AmbushRank5) then _Ambush = Ass_Ability.AmbushRank5;
	elseif IsSpellKnown(Ass_Ability.AmbushRank4) then _Ambush = Ass_Ability.AmbushRank4;
	elseif IsSpellKnown(Ass_Ability.AmbushRank3) then _Ambush = Ass_Ability.AmbushRank3;
	elseif IsSpellKnown(Ass_Ability.AmbushRank2) then _Ambush = Ass_Ability.AmbushRank2; end

	if IsSpellKnown(Ass_Ability.EviscerateRank8) then _Eviscerate = Ass_Ability.EviscerateRank8;
	elseif IsSpellKnown(Ass_Ability.EviscerateRank7) then _Eviscerate = Ass_Ability.EviscerateRank7;
	elseif IsSpellKnown(Ass_Ability.EviscerateRank6) then _Eviscerate = Ass_Ability.EviscerateRank6;
	elseif IsSpellKnown(Ass_Ability.EviscerateRank5) then _Eviscerate = Ass_Ability.EviscerateRank5;
	elseif IsSpellKnown(Ass_Ability.EviscerateRank4) then _Eviscerate = Ass_Ability.EviscerateRank4;
	elseif IsSpellKnown(Ass_Ability.EviscerateRank3) then _Eviscerate = Ass_Ability.EviscerateRank3;
	elseif IsSpellKnown(Ass_Ability.EviscerateRank2) then _Eviscerate = Ass_Ability.EviscerateRank2; end

	if IsSpellKnown(Ass_Ability.ExposeArmorRank5) then _ExposeArmor = Ass_Ability.ExposeArmorRank5;
	elseif IsSpellKnown(Ass_Ability.ExposeArmorRank4) then _ExposeArmor = Ass_Ability.ExposeArmorRank4;
	elseif IsSpellKnown(Ass_Ability.ExposeArmorRank3) then _ExposeArmor = Ass_Ability.ExposeArmorRank3;
	elseif IsSpellKnown(Ass_Ability.ExposeArmorRank2) then _ExposeArmor = Ass_Ability.ExposeArmorRank2; end

	if IsSpellKnown(Ass_Ability.GarroteRank6) then _Garrote = Ass_Ability.GarroteRank6;
	elseif IsSpellKnown(Ass_Ability.GarroteRank5) then _Garrote = Ass_Ability.GarroteRank5;
	elseif IsSpellKnown(Ass_Ability.GarroteRank4) then _Garrote = Ass_Ability.GarroteRank4;
	elseif IsSpellKnown(Ass_Ability.GarroteRank3) then _Garrote = Ass_Ability.GarroteRank3;
	elseif IsSpellKnown(Ass_Ability.GarroteRank2) then _Garrote = Ass_Ability.GarroteRank2; end
	
	if IsSpellKnown(Ass_Ability.KidneyShotRank2) then _KidneyShot = Ass_Ability.KidneyShotRank2; end
	
	if IsSpellKnown(Ass_Ability.RuptureRank6) then _Rupture = Ass_Ability.RuptureRank6;
	elseif IsSpellKnown(Ass_Ability.RuptureRank5) then _Rupture = Ass_Ability.RuptureRank5;
	elseif IsSpellKnown(Ass_Ability.RuptureRank4) then _Rupture = Ass_Ability.RuptureRank4;
	elseif IsSpellKnown(Ass_Ability.RuptureRank3) then _Rupture = Ass_Ability.RuptureRank3;
	elseif IsSpellKnown(Ass_Ability.RuptureRank2) then _Rupture = Ass_Ability.RuptureRank2; end	
	
	if IsSpellKnown(Ass_Ability.SliceandDiceRank2) then _SliceandDice = Ass_Ability.SliceandDiceRank2; end	
	
	if IsSpellKnown(Com_Ability.BackstabRank8) then _Backstab = Com_Ability.BackstabRank8;
	elseif IsSpellKnown(Com_Ability.BackstabRank7) then _Backstab = Com_Ability.BackstabRank7;
	elseif IsSpellKnown(Com_Ability.BackstabRank6) then _Backstab = Com_Ability.BackstabRank6;
	elseif IsSpellKnown(Com_Ability.BackstabRank5) then _Backstab = Com_Ability.BackstabRank5;
	elseif IsSpellKnown(Com_Ability.BackstabRank4) then _Backstab = Com_Ability.BackstabRank4;
	elseif IsSpellKnown(Com_Ability.BackstabRank3) then _Backstab = Com_Ability.BackstabRank3;
	elseif IsSpellKnown(Com_Ability.BackstabRank2) then _Backstab = Com_Ability.BackstabRank2; end
	
	if IsSpellKnown(Com_Ability.FeintRank4) then _Feint = Com_Ability.FeintRank4;
	elseif IsSpellKnown(Com_Ability.FeintRank3) then _Feint = Com_Ability.FeintRank3;
	elseif IsSpellKnown(Com_Ability.FeintRank2) then _Feint = Com_Ability.FeintRank2; end		

	if IsSpellKnown(Com_Ability.GougeRank5) then _Gouge = Com_Ability.GougeRank5;
	elseif IsSpellKnown(Com_Ability.GougeRank4) then _Gouge = Com_Ability.GougeRank4;
	elseif IsSpellKnown(Com_Ability.GougeRank3) then _Gouge = Com_Ability.GougeRank3;
	elseif IsSpellKnown(Com_Ability.GougeRank2) then _Gouge = Com_Ability.GougeRank2; end

	if IsSpellKnown(Com_Ability.KickRank4) then _Kick = Com_Ability.KickRank4;
	elseif IsSpellKnown(Com_Ability.KickRank3) then _Kick = Com_Ability.KickRank3;
	elseif IsSpellKnown(Com_Ability.KickRank2) then _Kick = Com_Ability.KickRank2; end

	if IsSpellKnown(Com_Ability.SinisterStrikeRank8) then _SinisterStrike = Com_Ability.SinisterStrikeRank8;
	elseif IsSpellKnown(Com_Ability.SinisterStrikeRank7) then _SinisterStrike = Com_Ability.SinisterStrikeRank7;
	elseif IsSpellKnown(Com_Ability.SinisterStrikeRank6) then _SinisterStrike = Com_Ability.SinisterStrikeRank6;
	elseif IsSpellKnown(Com_Ability.SinisterStrikeRank5) then _SinisterStrike = Com_Ability.SinisterStrikeRank5;
	elseif IsSpellKnown(Com_Ability.SinisterStrikeRank4) then _SinisterStrike = Com_Ability.SinisterStrikeRank4;
	elseif IsSpellKnown(Com_Ability.SinisterStrikeRank3) then _SinisterStrike = Com_Ability.SinisterStrikeRank3;
	elseif IsSpellKnown(Com_Ability.SinisterStrikeRank2) then _SinisterStrike = Com_Ability.SinisterStrikeRank2; end

	if IsSpellKnown(Com_Ability.SprintRank3) then _Sprint = Com_Ability.SprintRank3;
	elseif IsSpellKnown(Com_Ability.SprintRank2) then _Sprint = Com_Ability.SprintRank2; end

	if IsSpellKnown(Sub_Ability.HemorrhageRank3) then _Hemorrhage = Sub_Ability.HemorrhageRank3;
	elseif IsSpellKnown(Sub_Ability.HemorrhageRank2) then _Hemorrhage = Sub_Ability.HemorrhageRank2; end

	if IsSpellKnown(Sub_Ability.SapRank3) then _Sap = Sub_Ability.SapRank3;
	elseif IsSpellKnown(Sub_Ability.SapRank2) then _Sap = Sub_Ability.SapRank2; end

	if IsSpellKnown(Sub_Ability.VanishRank2) then _Vanish = Sub_Ability.VanishRank2; end

	if IsSpellKnown(Poisons.CripplingPoisonRank2) then _CripplingPoison = Poisons.CripplingPoisonRank2; end

	if IsSpellKnown(Poisons.DeadlyPoisonRank4) then _DeadlyPoison = Poisons.DeadlyPoisonRank4;
	elseif IsSpellKnown(Poisons.DeadlyPoisonRank3) then _DeadlyPoison = Poisons.DeadlyPoisonRank3;
	elseif IsSpellKnown(Poisons.DeadlyPoisonRank2) then _DeadlyPoison = Poisons.DeadlyPoisonRank2; end
	
	if IsSpellKnown(Poisons.InstantPoisonRank6) then _InstantPoison = Poisons.InstantPoisonRank6;
	elseif IsSpellKnown(Poisons.InstantPoisonRank5) then _InstantPoison = Poisons.InstantPoisonRank5;
	elseif IsSpellKnown(Poisons.InstantPoisonRank4) then _InstantPoison = Poisons.InstantPoisonRank4;
	elseif IsSpellKnown(Poisons.InstantPoisonRank3) then _InstantPoison = Poisons.InstantPoisonRank3;
	elseif IsSpellKnown(Poisons.InstantPoisonRank2) then _InstantPoison = Poisons.InstantPoisonRank2; end
	
	if IsSpellKnown(Poisons.MindnumbingPoisonRank3) then _MindnumbingPoison = Poisons.MindnumbingPoisonRank3;
	elseif IsSpellKnown(Poisons.MindnumbingPoisonRank2) then _MindnumbingPoison = Poisons.MindnumbingPoisonRank2; end	
	
	if IsSpellKnown(Poisons.WoundPoisonRank4) then _WoundPoison = Poisons.WoundPoisonRank4;
	elseif IsSpellKnown(Poisons.WoundPoisonRank3) then _WoundPoison = Poisons.WoundPoisonRank3;
	elseif IsSpellKnown(Poisons.WoundPoisonRank2) then _WoundPoison = Poisons.WoundPoisonRank2; end
	
--Abilities
	local ambushRDY											= ConROC:AbilityReady(_Ambush, timeShift);
	local cShotRDY											= ConROC:AbilityReady(Ass_Ability.CheapShot, timeShift);
	local kShotRDY											= ConROC:AbilityReady(_KidneyShot, timeShift);	
	local evisRDY											= ConROC:AbilityReady(_Eviscerate, timeShift);
	local cBloodRDY											= ConROC:AbilityReady(Ass_Ability.ColdBlood, timeShift);
		local cBloodBUFF										= ConROC:Buff(Ass_Ability.ColdBlood, timeShift);
	local exArmorRDY										= ConROC:AbilityReady(_ExposeArmor, timeShift);
		local exArmorDEBUFF										= ConROC:TargetDebuff(_ExposeArmor, timeShift);	
	local garRDY											= ConROC:AbilityReady(_Garrote, timeShift);
		local garDEBUFF											= ConROC:TargetDebuff(_Garrote, timeShift);
	local rupRDY											= ConROC:AbilityReady(_Rupture, timeShift);
		local rupDEBUFF											= ConROC:TargetDebuff(_Rupture, timeShift);
	local sndRDY											= ConROC:AbilityReady(_SliceandDice, timeShift);
		local sndBUFF, _, sndDUR								= ConROC:Buff(_SliceandDice, timeShift);
	local aRushRDY											= ConROC:AbilityReady(Com_Ability.AdrenalineRush, timeShift);
		local aRushBUFF											= ConROC:Buff(Com_Ability.AdrenalineRush, timeShift);
	local bStabRDY											= ConROC:AbilityReady(_Backstab, timeShift);
	local bFlurryRDY										= ConROC:AbilityReady(Com_Ability.BladeFlurry, timeShift);
	local gougeRDY											= ConROC:AbilityReady(_Gouge, timeShift);
	local kickRDY											= ConROC:AbilityReady(_Kick, timeShift);
	local sStrikeRDY										= ConROC:AbilityReady(_SinisterStrike, timeShift);
	local sprintRDY											= ConROC:AbilityReady(_Sprint, timeShift);
	local gStrikeRDY										= ConROC:AbilityReady(Sub_Ability.GhostlyStrike, timeShift);
	local hemoRDY											= ConROC:AbilityReady(_Hemorrhage, timeShift);
		local hemoDEBUFF										= ConROC:TargetDebuff(_Hemorrhage, timeShift);
	local premRDY											= ConROC:AbilityReady(Sub_Ability.Premeditation, timeShift);
	local prepRDY											= ConROC:AbilityReady(Sub_Ability.Preparation, timeShift);
	local vanishRDY											= ConROC:AbilityReady(_Vanish, timeShift);
	local ripRDY											= ConROC:AbilityReady(Com_Ability.Riposte, timeShift);
	local blindRDY											= ConROC:AbilityReady(Sub_Ability.Blind, timeShift);
	
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local stealthed											= IsStealthed();
	local resting 											= IsResting();
	local mounted 											= IsMounted();
	local targetPh 											= ConROC:PercentHealth('target');	
	local toClose 											= CheckInteractDistance("target", 3);
	local hasDagger											= ConROC:Equipped('Daggers', "MAINHANDSLOT");
	local tarInMelee										= ConROC:Targets(_SinisterStrike);
	local poisonMH, _, _, _, poisonOH						= GetWeaponEnchantInfo();
	
--Indicators		
	ConROC:AbilityBurst(Com_Ability.AdrenalineRush, aRushRDY and incombat and energyPercent <= 40);
	ConROC:AbilityBurst(Ass_Ability.ColdBlood, cBloodRDY and ((stealthed and hasDagger) or combo == comboMax));	
--	ConROC:AbilityBurst(Sub_Ability.Preparation, prepRDY and incombat);
	ConROC:AbilityBurst(_Gouge, ConROC:CheckBox(ConROC_SM_Stun_Gouge) and gougeRDY and not rupDEBUFF and not garDEBUFF and incombat and ConROC:TarYou());
	ConROC:AbilityBurst(Sub_Ability.Blind, ConROC:CheckBox(ConROC_SM_Stun_Blind) and blindRDY and not rupDEBUFF and not garDEBUFF and incombat and ConROC:TarYou());
	
--Warnings	
	if ConROC:CheckBox(ConROC_SM_PoisonMH_Instant) and not poisonMH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Instant Poison on your mainhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end

	if ConROC:CheckBox(ConROC_SM_PoisonMH_Crippling) and not poisonMH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Crippling Poison on your mainhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end

	if ConROC:CheckBox(ConROC_SM_PoisonMH_Mindnumbing) and not poisonMH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Mind-numbing Poison on your mainhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end

	if ConROC:CheckBox(ConROC_SM_PoisonMH_Deadly) and not poisonMH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Deadly Poison on your mainhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end
	
	if ConROC:CheckBox(ConROC_SM_PoisonMH_Wound) and not poisonMH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Wound Poison on your mainhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end
	
	if ConROC:CheckBox(ConROC_SM_PoisonOH_Instant) and not poisonOH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Instant Poison on your offhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end

	if ConROC:CheckBox(ConROC_SM_PoisonOH_Crippling) and not poisonOH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Crippling Poison on your offhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end

	if ConROC:CheckBox(ConROC_SM_PoisonOH_Mindnumbing) and not poisonOH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Mind-numbing Poison on your offhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end

	if ConROC:CheckBox(ConROC_SM_PoisonOH_Deadly) and not poisonOH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Deadly Poison on your offhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end
	
	if ConROC:CheckBox(ConROC_SM_PoisonOH_Wound) and not poisonOH and not mounted and (not resting or stealthed) then
		UIErrorsFrame:AddMessage("Put Wound Poison on your offhand weapon!!!", 1.0, 0.0, 0.0, 53, 5);
	end
	
--Rotations	
	if stealthed then
		if premRDY then
			return Sub_Ability.Premeditation;
		end

		if ConROC:CheckBox(ConROC_SM_Stun_CheapShot) and cShotRDY and not cBloodBUFF then
			return Ass_Ability.CheapShot;
		end
		
		if ambushRDY and hasDagger then
			return _Ambush;
		end
		
		if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and garRDY and not garDEBUFF then
			return _Garrote;
		end

		if bStabRDY and hasDagger and not ConROC:TarYou() then
			return _Backstab;
		end
	
		if sStrikeRDY and not hasDagger then
			return _SinisterStrike;
		end
	end
	
	if ripRDY then
		return Com_Ability.Riposte;
	end

	if ConROC:CheckBox(ConROC_SM_Stun_KidneyShot) and kShotRDY and combo == comboMax then
		return _KidneyShot;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
		return _SliceandDice;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_ExposeArmor) and exArmorRDY and not exArmorDEBUFF and combo == comboMax and targetPh >= 20 then
		return _ExposeArmor;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_Rupture) and rupRDY and not rupDEBUFF and combo == comboMax and targetPh >= 15 then
		return _Rupture;
	end
	
	if bFlurryRDY and tarInMelee >= 2 then
		return Com_Ability.BladeFlurry;
	end
	
	if evisRDY and (combo == comboMax or (combo >= 1 and ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob())))) then
		return _Eviscerate;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_Hemorrhage) and hemoRDY and not hemoDEBUFF then
		return _Hemorrhage;
	end
	
	if bStabRDY and hasDagger and not ConROC:TarYou() and incombat then
		return _Backstab;
	end
	
	if gStrikeRDY and ConROC:TarYou() then
		return Sub_Ability.GhostlyStrike;
	end

	if sStrikeRDY and (not hasDagger or ConROC:TarYou()) then
		return _SinisterStrike;
	end

	return nil;
end

function ConROC.Rogue.Defense(_, timeShift, currentSpell, gcd)

--Ranks
	if IsSpellKnown(Sub_Ability.StealthRank4) then _Stealth = Sub_Ability.StealthRank4;
	elseif IsSpellKnown(Sub_Ability.StealthRank3) then _Stealth = Sub_Ability.StealthRank3;
	elseif IsSpellKnown(Sub_Ability.StealthRank2) then _Stealth = Sub_Ability.StealthRank2; end
	
--Abilities	
	local stealthRDY										= ConROC:AbilityReady(_Stealth, timeShift);
	local evasionRDY										= ConROC:AbilityReady(Com_Ability.Evasion, timeShift);
	
--Conditions	
	local ph 												= ConROC:PercentHealth('player');
	local stealthed											= IsStealthed();
	local incombat 											= UnitAffectingCombat('player');
	
--Rotations	
	if stealthRDY and not stealthed and not incombat then
		return _Stealth;
	end
	
	if evasionRDY and incombat and ConROC:TarYou() and ph <= 75 then
		return Com_Ability.Evasion;
	end	
	
	return nil;
end
