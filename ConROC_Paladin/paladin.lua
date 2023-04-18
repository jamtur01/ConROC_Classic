ConROC.Paladin = {};

local ConROC_Paladin, ids = ...;

function ConROC:EnableRotationModule()
	self.Description = "Paladin";
	self.NextSpell = ConROC.Paladin.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;

	ConROC:SpellmenuClass();
--	ConROCSpellmenuFrame:Hide();
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Paladin.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

local Racial, Spec, Holy_Ability, Holy_Talent, Prot_Ability, Prot_Talent, Ret_Ability, Ret_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Holy_Ability, ids.Holy_Talent, ids.Prot_Ability, ids.Prot_Talent, ids.Ret_Ability, ids.Ret_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;
		
function ConROC.Paladin.Damage(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);

--Ranks
	--Holy
	local _BlessingofLight = Holy_Ability.BlessingofLightRank1;
	local _BlessingofWisdom = Holy_Ability.BlessingofWisdomRank1;
	local _Consecration = Holy_Ability.ConsecrationRank1;
	local _Exorcism = Holy_Ability.ExorcismRank1;
	local _FlashofLight = Holy_Ability.FlashofLightRank1;
	local _HammerofWrath = Holy_Ability.HammerofWrathRank1;
	local _HolyLight = Holy_Ability.HolyLightRank1;
	local _HolyShock = Holy_Ability.HolyShockRank1;	
	local _HolyWrath = Holy_Ability.HolyWrathRank1;
	local _LayonHands = Holy_Ability.LayonHandsRank1;
	local _Redemption = Holy_Ability.RedemptionRank1;
	local _SealofLight = Holy_Ability.SealofLightRank1;	
		local _JudgementofLight = Target_Debuff.JudgementofLightRank1;
	local _SealofRighteousness = Holy_Ability.SealofRighteousnessRank0;
	local _SealofWisdom = Holy_Ability.SealofWisdomRank1;
		local _JudgementofWisdom = Target_Debuff.JudgementofWisdomRank1;
	local _TurnUndead = Holy_Ability.TurnUndeadRank1;

	if IsSpellKnown(Holy_Ability.BlessingofLightRank3) then _BlessingofLight = Holy_Ability.BlessingofLightRank3;	
	elseif IsSpellKnown(Holy_Ability.BlessingofLightRank2) then _BlessingofLight = Holy_Ability.BlessingofLightRank2; end
	
	if IsSpellKnown(Holy_Ability.BlessingofWisdomRank5) then _BlessingofWisdom = Holy_Ability.BlessingofWisdomRank5;
	elseif IsSpellKnown(Holy_Ability.BlessingofWisdomRank4) then _BlessingofWisdom = Holy_Ability.BlessingofWisdomRank4;
	elseif IsSpellKnown(Holy_Ability.BlessingofWisdomRank3) then _BlessingofWisdom = Holy_Ability.BlessingofWisdomRank3;	
	elseif IsSpellKnown(Holy_Ability.BlessingofWisdomRank2) then _BlessingofWisdom = Holy_Ability.BlessingofWisdomRank2; end
	
	if IsSpellKnown(Holy_Ability.ConsecrationRank5) then _Consecration = Holy_Ability.ConsecrationRank5;
	elseif IsSpellKnown(Holy_Ability.ConsecrationRank4) then _Consecration = Holy_Ability.ConsecrationRank4;
	elseif IsSpellKnown(Holy_Ability.ConsecrationRank3) then _Consecration = Holy_Ability.ConsecrationRank3;	
	elseif IsSpellKnown(Holy_Ability.ConsecrationRank2) then _Consecration = Holy_Ability.ConsecrationRank2; end
	
	if IsSpellKnown(Holy_Ability.ExorcismRank6) then _Exorcism = Holy_Ability.ExorcismRank6;
	elseif IsSpellKnown(Holy_Ability.ExorcismRank5) then _Exorcism = Holy_Ability.ExorcismRank5;
	elseif IsSpellKnown(Holy_Ability.ExorcismRank4) then _Exorcism = Holy_Ability.ExorcismRank4;
	elseif IsSpellKnown(Holy_Ability.ExorcismRank3) then _Exorcism = Holy_Ability.ExorcismRank3;
	elseif IsSpellKnown(Holy_Ability.ExorcismRank2) then _Exorcism = Holy_Ability.ExorcismRank2; end
	
	if IsSpellKnown(Holy_Ability.FlashofLightRank6) then _FlashofLight = Holy_Ability.FlashofLightRank6;
	elseif IsSpellKnown(Holy_Ability.FlashofLightRank5) then _FlashofLight = Holy_Ability.FlashofLightRank5;
	elseif IsSpellKnown(Holy_Ability.FlashofLightRank4) then _FlashofLight = Holy_Ability.FlashofLightRank4;
	elseif IsSpellKnown(Holy_Ability.FlashofLightRank3) then _FlashofLight = Holy_Ability.FlashofLightRank3;
	elseif IsSpellKnown(Holy_Ability.FlashofLightRank2) then _FlashofLight = Holy_Ability.FlashofLightRank2; end	

	if IsSpellKnown(Holy_Ability.HammerofWrathRank3) then _HammerofWrath = Holy_Ability.HammerofWrathRank3;
	elseif IsSpellKnown(Holy_Ability.HammerofWrathRank2) then _HammerofWrath = Holy_Ability.HammerofWrathRank2; end

	if IsSpellKnown(Holy_Ability.HolyLightRank8) then _HolyLight = Holy_Ability.HolyLightRank8;
	elseif IsSpellKnown(Holy_Ability.HolyLightRank7) then _HolyLight = Holy_Ability.HolyLightRank7;
	elseif IsSpellKnown(Holy_Ability.HolyLightRank6) then _HolyLight = Holy_Ability.HolyLightRank6;
	elseif IsSpellKnown(Holy_Ability.HolyLightRank5) then _HolyLight = Holy_Ability.HolyLightRank5;
	elseif IsSpellKnown(Holy_Ability.HolyLightRank4) then _HolyLight = Holy_Ability.HolyLightRank4;
	elseif IsSpellKnown(Holy_Ability.HolyLightRank3) then _HolyLight = Holy_Ability.HolyLightRank3;
	elseif IsSpellKnown(Holy_Ability.HolyLightRank2) then _HolyLight = Holy_Ability.HolyLightRank2; end

	if IsSpellKnown(Holy_Ability.HolyShockRank3) then _HolyShock = Holy_Ability.HolyShockRank3;	
	elseif IsSpellKnown(Holy_Ability.HolyShockRank2) then _HolyShock = Holy_Ability.HolyShockRank2; end	

	if IsSpellKnown(Holy_Ability.HolyWrathRank2) then _HolyWrath = Holy_Ability.HolyWrathRank2; end

	if IsSpellKnown(Holy_Ability.SealofLightRank4) then _SealofLight = Holy_Ability.SealofLightRank4; _JudgementofLight = Target_Debuff.JudgementofLightRank4;
	elseif IsSpellKnown(Holy_Ability.SealofLightRank3) then _SealofLight = Holy_Ability.SealofLightRank3; _JudgementofLight = Target_Debuff.JudgementofLightRank3;
	elseif IsSpellKnown(Holy_Ability.SealofLightRank2) then _SealofLight = Holy_Ability.SealofLightRank2; _JudgementofLight = Target_Debuff.JudgementofLightRank2; end

	if IsSpellKnown(Holy_Ability.SealofRighteousnessRank8) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank8;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank7) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank7;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank6) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank6;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank5) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank5;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank4) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank4;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank3) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank3;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank2) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank2;
	elseif IsSpellKnown(Holy_Ability.SealofRighteousnessRank1) then _SealofRighteousness = Holy_Ability.SealofRighteousnessRank1; end

	if IsSpellKnown(Holy_Ability.SealofWisdomRank3) then _SealofWisdom = Holy_Ability.SealofWisdomRank3; _JudgementofWisdom = Target_Debuff.JudgementofWisdomRank3;
	elseif IsSpellKnown(Holy_Ability.SealofWisdomRank2) then _SealofWisdom = Holy_Ability.SealofWisdomRank2; _JudgementofWisdom = Target_Debuff.JudgementofWisdomRank2; end

	--Protection
	local _BlessingofProtection = Prot_Ability.BlessingofProtectionRank1;
	local _BlessingofSacrifice = Prot_Ability.BlessingofSacrificeRank1;
	local _BlessingofSanctuary = Prot_Ability.BlessingofSanctuaryRank1;
	local _DivineProtection = Prot_Ability.DivineProtectionRank1;	
	local _DivineShield = Prot_Ability.DivineShieldRank1;
	local _HammerofJustice = Prot_Ability.HammerofJusticeRank1;
	local _HolyShield = Prot_Ability.HolyShieldRank1;

	if IsSpellKnown(Prot_Ability.BlessingofProtectionRank3) then _BlessingofProtection = Prot_Ability.BlessingofProtectionRank3;	
	elseif IsSpellKnown(Prot_Ability.BlessingofProtectionRank2) then _BlessingofProtection = Prot_Ability.BlessingofProtectionRank2; end

	if IsSpellKnown(Prot_Ability.BlessingofSacrificeRank2) then _BlessingofSacrifice = Prot_Ability.BlessingofSacrificeRank2; end
	
	if IsSpellKnown(Prot_Ability.BlessingofSanctuaryRank4) then _BlessingofSanctuary = Prot_Ability.BlessingofSanctuaryRank4;
	elseif IsSpellKnown(Prot_Ability.BlessingofSanctuaryRank3) then _BlessingofSanctuary = Prot_Ability.BlessingofSanctuaryRank3;	
	elseif IsSpellKnown(Prot_Ability.BlessingofSanctuaryRank2) then _BlessingofSanctuary = Prot_Ability.BlessingofSanctuaryRank2; end

	if IsSpellKnown(Prot_Ability.DivineProtectionRank2) then _DivineProtection = Prot_Ability.DivineProtectionRank2; end

	if IsSpellKnown(Prot_Ability.DivineShieldRank2) then _DivineShield = Prot_Ability.DivineShieldRank2; end
	
	if IsSpellKnown(Prot_Ability.HammerofJusticeRank4) then _HammerofJustice = Prot_Ability.HammerofJusticeRank4;
	elseif IsSpellKnown(Prot_Ability.HammerofJusticeRank3) then _HammerofJustice = Prot_Ability.HammerofJusticeRank3;
	elseif IsSpellKnown(Prot_Ability.HammerofJusticeRank2) then _HammerofJustice = Prot_Ability.HammerofJusticeRank2; end

	if IsSpellKnown(Prot_Ability.HolyShieldRank3) then _HolyShield = Prot_Ability.HolyShieldRank3;	
	elseif IsSpellKnown(Prot_Ability.HolyShieldRank2) then _HolyShield = Prot_Ability.HolyShieldRank2; end
	
	--Retribution
	local _BlessingofMight = Ret_Ability.BlessingofMightRank1;
	local _SealofCommand = Ret_Ability.SealofCommandRank1;	
	local _SealoftheCrusader = Ret_Ability.SealoftheCrusaderRank1;
		local _JudgementoftheCrusader = Target_Debuff.JudgementoftheCrusaderRank1;	

	if IsSpellKnown(Ret_Ability.BlessingofMightRank6) then _BlessingofMight = Ret_Ability.BlessingofMightRank6;
	elseif IsSpellKnown(Ret_Ability.BlessingofMightRank5) then _BlessingofMight = Ret_Ability.BlessingofMightRank5;
	elseif IsSpellKnown(Ret_Ability.BlessingofMightRank4) then _BlessingofMight = Ret_Ability.BlessingofMightRank4;
	elseif IsSpellKnown(Ret_Ability.BlessingofMightRank3) then _BlessingofMight = Ret_Ability.BlessingofMightRank3;	
	elseif IsSpellKnown(Ret_Ability.BlessingofMightRank2) then _BlessingofMight = Ret_Ability.BlessingofMightRank2; end
	
	if IsSpellKnown(Ret_Ability.SealofCommandRank5) then _SealofCommand = Ret_Ability.SealofCommandRank5;
	elseif IsSpellKnown(Ret_Ability.SealofCommandRank4) then _SealofCommand = Ret_Ability.SealofCommandRank4;
	elseif IsSpellKnown(Ret_Ability.SealofCommandRank3) then _SealofCommand = Ret_Ability.SealofCommandRank3;	
	elseif IsSpellKnown(Ret_Ability.SealofCommandRank2) then _SealofCommand = Ret_Ability.SealofCommandRank2; end
	
	if IsSpellKnown(Ret_Ability.SealoftheCrusaderRank6) then _SealoftheCrusader = Ret_Ability.SealoftheCrusaderRank6; _JudgementoftheCrusader = Target_Debuff.JudgementoftheCrusaderRank6;
	elseif IsSpellKnown(Ret_Ability.SealoftheCrusaderRank5) then _SealoftheCrusader = Ret_Ability.SealoftheCrusaderRank5; _JudgementoftheCrusader = Target_Debuff.JudgementoftheCrusaderRank5;
	elseif IsSpellKnown(Ret_Ability.SealoftheCrusaderRank4) then _SealoftheCrusader = Ret_Ability.SealoftheCrusaderRank4; _JudgementoftheCrusader = Target_Debuff.JudgementoftheCrusaderRank4;
	elseif IsSpellKnown(Ret_Ability.SealoftheCrusaderRank3) then _SealoftheCrusader = Ret_Ability.SealoftheCrusaderRank3; _JudgementoftheCrusader = Target_Debuff.JudgementoftheCrusaderRank3;	
	elseif IsSpellKnown(Ret_Ability.SealoftheCrusaderRank2) then _SealoftheCrusader = Ret_Ability.SealoftheCrusaderRank2; _JudgementoftheCrusader = Target_Debuff.JudgementoftheCrusaderRank2; end
		
--Abilities	
	local boMight											= ConROC:AbilityReady(_BlessingofMight, timeShift);
		local bomBuff											= ConROC:Buff(_BlessingofMight, timeShift);	
	local boWisdom											= ConROC:AbilityReady(_BlessingofWisdom, timeShift);
		local bowBuff											= ConROC:Buff(_BlessingofWisdom, timeShift);	
	local boKings											= ConROC:AbilityReady(Prot_Ability.BlessingofKings, timeShift);
		local bokBuff											= ConROC:Buff(Prot_Ability.BlessingofKings, timeShift);	
	local boSalv											= ConROC:AbilityReady(Prot_Ability.BlessingofSalvation, timeShift);
		local bosBuff											= ConROC:Buff(Prot_Ability.BlessingofSalvation, timeShift);	
	local boSanc											= ConROC:AbilityReady(_BlessingofSanctuary, timeShift);
		local bosaBuff											= ConROC:Buff(_BlessingofSanctuary, timeShift);	
	local boLight											= ConROC:AbilityReady(_BlessingofLight, timeShift);
		local bolBuff											= ConROC:Buff(_BlessingofLight, timeShift);			
	local judgement, judgeCD, judgeMCD						= ConROC:AbilityReady(Ret_Ability.Judgement, timeShift);	
	local soCrusader										= ConROC:AbilityReady(_SealoftheCrusader, timeShift);
		local socBuff											= ConROC:Buff(_SealoftheCrusader, timeShift);
	local soJustice											= ConROC:AbilityReady(Prot_Ability.SealofJustice, timeShift);
		local sojBuff											= ConROC:Buff(Prot_Ability.SealofJustice, timeShift);
	local soLight											= ConROC:AbilityReady(_SealofLight, timeShift);
		local solBuff											= ConROC:Buff(_SealofLight, timeShift);
	local soWisdom											= ConROC:AbilityReady(_SealofWisdom, timeShift);
		local sowBuff											= ConROC:Buff(_SealofWisdom, timeShift);
	local soRighteousness									= ConROC:AbilityReady(_SealofRighteousness, timeShift);
		local sorBuff											= ConROC:Buff(_SealofRighteousness, timeShift);	
	local soCommand											= ConROC:AbilityReady(_SealofCommand, timeShift);
		local socomBuff											= ConROC:Buff(_SealofCommand, timeShift);
	local exorcism											= ConROC:AbilityReady(_Exorcism, timeShift);
	local hoJustice											= ConROC:AbilityReady(_HammerofJustice, timeShift);
		local hojDebuff											= ConROC:TargetDebuff(_HammerofJustice, timeShift);
	
    local judgeDebuff = {
		joc													= ConROC:TargetDebuff(_JudgementoftheCrusader, timeShift);
        joj													= ConROC:TargetDebuff(Target_Debuff.JudgementofJustice, timeShift);
		jol													= ConROC:TargetDebuff(_JudgementofLight, timeShift);
        jow													= ConROC:TargetDebuff(_JudgementofWisdom, timeShift);
    }	

	local judgeUp = false;
		for k, v in pairs(judgeDebuff) do
			if v then
				judgeUp = true;
				break
			end
		end
		
--Conditions	
	local isEnemy 											= ConROC:TarHostile();
	local Close 											= CheckInteractDistance("target", 3);
	
--Indicators	
	ConROC:AbilityRaidBuffs(_BlessingofMight, ConROC:CheckBox(ConROC_SM_Bless_Might) and boMight and not bomBuff);	
	ConROC:AbilityRaidBuffs(_BlessingofWisdom, ConROC:CheckBox(ConROC_SM_Bless_Wisdom) and boWisdom and not bowBuff);	
	ConROC:AbilityRaidBuffs(Prot_Ability.BlessingofKings, ConROC:CheckBox(ConROC_SM_Bless_Kings) and boKings and not bokBuff);	
	ConROC:AbilityRaidBuffs(Prot_Ability.BlessingofSalvation, ConROC:CheckBox(ConROC_SM_Bless_Salvation) and boSalv and not bosBuff);	
	ConROC:AbilityRaidBuffs(_BlessingofSanctuary, ConROC:CheckBox(ConROC_SM_Bless_Sanctuary) and boSanc and not bosaBuff);	
	ConROC:AbilityRaidBuffs(_BlessingofLight, ConROC:CheckBox(ConROC_SM_Bless_Light) and boLight and not bolBuff);
	
--Warnings
	
--Rotations
	if (ConROC:CheckBox(ConROC_SM_Role_Healer) and ConROC:TarHostile()) or not ConROC:CheckBox(ConROC_SM_Role_Healer) then
		if ConROC:CheckBox(ConROC_SM_Judgement_Crusader) and soCrusader and not socBuff and not judgeDebuff.joc and (judgeCD >= judgeMCD - 1) then
			return _SealoftheCrusader;
		end
		
		if ConROC:CheckBox(ConROC_SM_Judgement_Justice) and soJustice and not sojBuff and not judgeDebuff.joj and (judgeCD >= judgeMCD - 1) then
			return Prot_Ability.SealofJustice;
		end
		
		if ConROC:CheckBox(ConROC_SM_Judgement_Light) and soLight and not solBuff and not judgeDebuff.jol and (judgeCD >= judgeMCD - 1) then
			return _SealofLight;
		end	
		
		if ConROC:CheckBox(ConROC_SM_Judgement_Wisdom) and soWisdom and not sowBuff and not judgeDebuff.jow and (judgeCD >= judgeMCD - 1) then
			return _SealofWisdom;
		end	
		
		if judgement and not judgeUp then
			return Ret_Ability.Judgement;
		end	

		if ConROC:CheckBox(ConROC_SM_Seal_Righteousness) and soRighteousness and not sorBuff then
			return _SealofRighteousness;
		end
		
		if ConROC:CheckBox(ConROC_SM_Seal_Crusader) and soCrusader and not socBuff then
			return _SealoftheCrusader;
		end

		if ConROC:CheckBox(ConROC_SM_Seal_Command) and soCommand and not socomBuff then
			return _SealofCommand;
		end	
			
		if ConROC:CheckBox(ConROC_SM_Seal_Justice) and soJustice and not sojBuff then
			return Prot_Ability.SealofJustice;
		end
		
		if ConROC:CheckBox(ConROC_SM_Seal_Light) and soLight and not solBuff then
			return _SealofLight;
		end	
		
		if ConROC:CheckBox(ConROC_SM_Seal_Wisdom) and soWisdom and not sowBuff then
			return _SealofWisdom;
		end	
		
		if ConROC:CheckBox(ConROC_SM_Stun_HammerofJustice) and hoJustice and judgement then
			return _HammerofJustice;
		end

		if judgement and (socomBuff or sorBuff) then
			return Ret_Ability.Judgement;
		end
		
		if exorcism and (ConROC:CreatureType("Undead") or ConROC:CreatureType("Demon")) then
			return _Exorcism;
		end
	end
	return nil;
end

function ConROC.Paladin.Defense(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);

--Ranks
	--Holy
	
	--Protection
	local _DevotionAura = Prot_Ability.DevotionAuraRank1;
	local _FireResistanceAura = Prot_Ability.FireResistanceAuraRank1;
	local _FrostResistanceAura = Prot_Ability.FrostResistanceAuraRank1;	
	local _ShadowResistanceAura = Prot_Ability.ShadowResistanceAuraRank1;

	if IsSpellKnown(Prot_Ability.DevotionAuraRank7) then _DevotionAura = Prot_Ability.DevotionAuraRank7;
	elseif IsSpellKnown(Prot_Ability.DevotionAuraRank6) then _DevotionAura = Prot_Ability.DevotionAuraRank6;
	elseif IsSpellKnown(Prot_Ability.DevotionAuraRank5) then _DevotionAura = Prot_Ability.DevotionAuraRank5;
	elseif IsSpellKnown(Prot_Ability.DevotionAuraRank4) then _DevotionAura = Prot_Ability.DevotionAuraRank4;
	elseif IsSpellKnown(Prot_Ability.DevotionAuraRank3) then _DevotionAura = Prot_Ability.DevotionAuraRank3;	
	elseif IsSpellKnown(Prot_Ability.DevotionAuraRank2) then _DevotionAura = Prot_Ability.DevotionAuraRank2; end

	if IsSpellKnown(Prot_Ability.FireResistanceAuraRank3) then _FireResistanceAura = Prot_Ability.FireResistanceAuraRank3;	
	elseif IsSpellKnown(Prot_Ability.FireResistanceAuraRank2) then _FireResistanceAura = Prot_Ability.FireResistanceAuraRank2; end

	if IsSpellKnown(Prot_Ability.FrostResistanceAuraRank3) then _FrostResistanceAura = Prot_Ability.FrostResistanceAuraRank3;	
	elseif IsSpellKnown(Prot_Ability.FrostResistanceAuraRank2) then _FrostResistanceAura = Prot_Ability.FrostResistanceAuraRank2; end

	if IsSpellKnown(Prot_Ability.ShadowResistanceAuraRank3) then _ShadowResistanceAura = Prot_Ability.ShadowResistanceAuraRank3;	
	elseif IsSpellKnown(Prot_Ability.ShadowResistanceAuraRank2) then _ShadowResistanceAura = Prot_Ability.ShadowResistanceAuraRank2; end	
	
	--Retribution
	local _RetributionAura = Ret_Ability.RetributionAuraRank1;	

	if IsSpellKnown(Ret_Ability.RetributionAuraRank5) then _RetributionAura = Ret_Ability.RetributionAuraRank5;
	elseif IsSpellKnown(Ret_Ability.RetributionAuraRank4) then _RetributionAura = Ret_Ability.RetributionAuraRank4;
	elseif IsSpellKnown(Ret_Ability.RetributionAuraRank3) then _RetributionAura = Ret_Ability.RetributionAuraRank3;	
	elseif IsSpellKnown(Ret_Ability.RetributionAuraRank2) then _RetributionAura = Ret_Ability.RetributionAuraRank2; end	
	
--Abilities	
	local dAura												= ConROC:AbilityReady(_DevotionAura, timeShift);
		local daBuff											= ConROC:Form(_DevotionAura);
	local rAura												= ConROC:AbilityReady(_RetributionAura, timeShift);
		local raBuff											= ConROC:Form(_RetributionAura);
	local cAura												= ConROC:AbilityReady(Prot_Ability.ConcentrationAura, timeShift);
		local caBuff											= ConROC:Form(Prot_Ability.ConcentrationAura);
	local sAura												= ConROC:AbilityReady(Ret_Ability.SanctityAura, timeShift);
		local saBuff											= ConROC:Form(Ret_Ability.SanctityAura);
	local fRAura											= ConROC:AbilityReady(_FireResistanceAura, timeShift);
		local fRBuff											= ConROC:Form(_FireResistanceAura);
	local frRAura											= ConROC:AbilityReady(_FrostResistanceAura, timeShift);
		local frRBuff											= ConROC:Form(_FrostResistanceAura);
	local shaAura											= ConROC:AbilityReady(_ShadowResistanceAura, timeShift);
		local shaBuff											= ConROC:Form(_ShadowResistanceAura);
		
--Conditions
	local playerPh 											= ConROC:PercentHealth('player');

--Rotations
	if dAura and not daBuff and ConROC:CheckBox(ConROC_SM_Aura_Devotion) then
		return _DevotionAura;
	end
	
	if rAura and not raBuff and ConROC:CheckBox(ConROC_SM_Aura_Retribution) then
		return _RetributionAura;
	end
	
	if cAura and not caBuff and ConROC:CheckBox(ConROC_SM_Aura_Concentration) then
		return Prot_Ability.ConcentrationAura;
	end

	if sAura and not saBuff and ConROC:CheckBox(ConROC_SM_Aura_Sanctity) then
		return Ret_Ability.SanctityAura;
	end
	
	if fRAura and not fRBuff and ConROC:CheckBox(ConROC_SM_Aura_FireResistance) then
		return _FireResistanceAura;
	end
	
	if frRAura and not frRBuff and ConROC:CheckBox(ConROC_SM_Aura_FrostResistance) then
		return _FrostResistanceAura;
	end
	
	if shaAura and not shaBuff and ConROC:CheckBox(ConROC_SM_Aura_ShadowResistance) then
		return _ShadowResistanceAura;
	end
	
	return nil;
end
