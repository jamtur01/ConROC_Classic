ConROC.Druid = {};

local ConROC_Druid, ids = ...;

function ConROC:EnableRotationModule()
	self.Description = "Druid";
	self.NextSpell = ConROC.Druid.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
		
	ConROC:PowerShift();	
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Druid.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

	local Racial, Spec, Bal_Ability, Bal_Talent, Feral_Ability, Feral_Talent, Resto_Ability, Resto_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Bal_Ability, ids.Bal_Talent, ids.Feral_Ability, ids.Feral_Talent, ids.Resto_Ability, ids.Resto_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;

	local _EntanglingRoots = Bal_Ability.EntanglingRootsRank1;
	local _FaerieFire = Bal_Ability.FaerieFireRank1;
	local _Hibernate = Bal_Ability.HibernateRank1;
	local _Hurricane = Bal_Ability.HurricaneRank1;
	local _Moonfire = Bal_Ability.MoonfireRank1;
	local _NaturesGrasp = Bal_Ability.NaturesGraspRank1;
	local _SootheAnimal = Bal_Ability.SootheAnimalRank1;
	local _Starfire = Bal_Ability.StarfireRank1;
	local _Thorns = Bal_Ability.ThornsRank1;
	local _Wrath = Bal_Ability.WrathRank1;
	
	local _Bash = Feral_Ability.BashRank1;
	local _BearForm = Feral_Ability.BearForm;
	local _Claw = Feral_Ability.ClawRank1;
	local _Cower = Feral_Ability.CowerRank1;
	local _Dash = Feral_Ability.DashRank1;
	local _DemoralizingRoar = Feral_Ability.DemoralizingRoarRank1;
	local _FaerieFireFeral = Feral_Ability.FaerieFireFeralRank1;
	local _FerociousBite = Feral_Ability.FerociousBiteRank1;
	local _FrenziedRegeneration = Feral_Ability.FrenziedRegenerationRank1;
	local _Maul = Feral_Ability.MaulRank1;
	local _Pounce = Feral_Ability.PounceRank1;
	local _Prowl = Feral_Ability.ProwlRank1;
	local _Rake = Feral_Ability.RakeRank1;
	local _Ravage = Feral_Ability.RavageRank1;
	local _Rip = Feral_Ability.RipRank1;
	local _Shred = Feral_Ability.ShredRank1;
	local _Swipe = Feral_Ability.SwipeRank1;
	local _TigersFury = Feral_Ability.TigersFuryRank1;

	local _HealingTouch = Resto_Ability.HealingTouchRank1;
	local _InsectSwarm = Resto_Ability.InsectSwarmRank1;
	local _MarkoftheWild = Resto_Ability.MarkoftheWildRank1;
	local _Rebirth = Resto_Ability.RebirthRank1;
	local _Regrowth = Resto_Ability.RegrowthRank1;
	local _Rejuvenation = Resto_Ability.RejuvenationRank1;
	local _Tranquility = Resto_Ability.TranquilityRank1;


function ConROC.Druid.Damage(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	local int												= UnitStat("player", 4);
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaBase											= manaMax - (math.min(20,int)+15*(int-math.min(20,int)))
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);
	local energyPercent 									= math.max(0, energy) / math.max(1, energyMax) * 100;	
    local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local comboMax 											= UnitPowerMax('player', Enum.PowerType.ComboPoints);

--Ranks
	if IsSpellKnown(ids.Bal_Ability.FaerieFireRank4) then _FaerieFire = ids.Bal_Ability.FaerieFireRank4;
	elseif IsSpellKnown(ids.Bal_Ability.FaerieFireRank3) then _FaerieFire = ids.Bal_Ability.FaerieFireRank3;
	elseif IsSpellKnown(ids.Bal_Ability.FaerieFireRank2) then _FaerieFire = ids.Bal_Ability.FaerieFireRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.HibernateRank3) then _Hibernate = ids.Bal_Ability.HibernateRank3;
	elseif IsSpellKnown(ids.Bal_Ability.HibernateRank2) then _Hibernate = ids.Bal_Ability.HibernateRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.HurricaneRank3) then _Hurricane = ids.Bal_Ability.HurricaneRank3;
	elseif IsSpellKnown(ids.Bal_Ability.HurricaneRank2) then _Hurricane = ids.Bal_Ability.HurricaneRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.MoonfireRank10) then _Moonfire = ids.Bal_Ability.MoonfireRank10;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank9) then _Moonfire = ids.Bal_Ability.MoonfireRank9;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank8) then _Moonfire = ids.Bal_Ability.MoonfireRank8;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank7) then _Moonfire = ids.Bal_Ability.MoonfireRank7;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank6) then _Moonfire = ids.Bal_Ability.MoonfireRank6;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank5) then _Moonfire = ids.Bal_Ability.MoonfireRank5;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank4) then _Moonfire = ids.Bal_Ability.MoonfireRank4;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank3) then _Moonfire = ids.Bal_Ability.MoonfireRank3;
	elseif IsSpellKnown(ids.Bal_Ability.MoonfireRank2) then _Moonfire = ids.Bal_Ability.MoonfireRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.SootheAnimalRank3) then _SootheAnimal = ids.Bal_Ability.SootheAnimalRank3;
	elseif IsSpellKnown(ids.Bal_Ability.SootheAnimalRank2) then _SootheAnimal = ids.Bal_Ability.SootheAnimalRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.StarfireRank6) then _Starfire = ids.Bal_Ability.StarfireRank6;
	elseif IsSpellKnown(ids.Bal_Ability.StarfireRank5) then _Starfire = ids.Bal_Ability.StarfireRank5;
	elseif IsSpellKnown(ids.Bal_Ability.StarfireRank4) then _Starfire = ids.Bal_Ability.StarfireRank4;
	elseif IsSpellKnown(ids.Bal_Ability.StarfireRank3) then _Starfire = ids.Bal_Ability.StarfireRank3;
	elseif IsSpellKnown(ids.Bal_Ability.StarfireRank2) then _Starfire = ids.Bal_Ability.StarfireRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.WrathRank8) then _Wrath = ids.Bal_Ability.WrathRank8;
	elseif IsSpellKnown(ids.Bal_Ability.WrathRank7) then _Wrath = ids.Bal_Ability.WrathRank7;
	elseif IsSpellKnown(ids.Bal_Ability.WrathRank6) then _Wrath = ids.Bal_Ability.WrathRank6;
	elseif IsSpellKnown(ids.Bal_Ability.WrathRank5) then _Wrath = ids.Bal_Ability.WrathRank5;
	elseif IsSpellKnown(ids.Bal_Ability.WrathRank4) then _Wrath = ids.Bal_Ability.WrathRank4;
	elseif IsSpellKnown(ids.Bal_Ability.WrathRank3) then _Wrath = ids.Bal_Ability.WrathRank3;
	elseif IsSpellKnown(ids.Bal_Ability.WrathRank2) then _Wrath = ids.Bal_Ability.WrathRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.BashRank3) then _Bash = ids.Feral_Ability.BashRank3;
	elseif IsSpellKnown(ids.Feral_Ability.BashRank2) then _Bash = ids.Feral_Ability.BashRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.DireBearForm) then _BearForm = ids.Feral_Ability.DireBearForm; end
	
	if IsSpellKnown(ids.Feral_Ability.ClawRank5) then _Claw = ids.Feral_Ability.ClawRank5;
	elseif IsSpellKnown(ids.Feral_Ability.ClawRank4) then _Claw = ids.Feral_Ability.ClawRank4;
	elseif IsSpellKnown(ids.Feral_Ability.ClawRank3) then _Claw = ids.Feral_Ability.ClawRank3;
	elseif IsSpellKnown(ids.Feral_Ability.ClawRank2) then _Claw = ids.Feral_Ability.ClawRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.DashRank2) then _Dash = ids.Feral_Ability.DashRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.FaerieFireFeralRank4) then _FaerieFireFeral = ids.Feral_Ability.FaerieFireFeralRank4;
	elseif IsSpellKnown(ids.Feral_Ability.FaerieFireFeralRank3) then _FaerieFireFeral = ids.Feral_Ability.FaerieFireFeralRank3;
	elseif IsSpellKnown(ids.Feral_Ability.FaerieFireFeralRank2) then _FaerieFireFeral = ids.Feral_Ability.FaerieFireFeralRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.FerociousBiteRank4) then _FerociousBite = ids.Feral_Ability.FerociousBiteRank4;
	elseif IsSpellKnown(ids.Feral_Ability.FerociousBiteRank3) then _FerociousBite = ids.Feral_Ability.FerociousBiteRank3;
	elseif IsSpellKnown(ids.Feral_Ability.FerociousBiteRank2) then _FerociousBite = ids.Feral_Ability.FerociousBiteRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.MaulRank7) then _Maul = ids.Feral_Ability.MaulRank7;
	elseif IsSpellKnown(ids.Feral_Ability.MaulRank6) then _Maul = ids.Feral_Ability.MaulRank6;
	elseif IsSpellKnown(ids.Feral_Ability.MaulRank5) then _Maul = ids.Feral_Ability.MaulRank5;
	elseif IsSpellKnown(ids.Feral_Ability.MaulRank4) then _Maul = ids.Feral_Ability.MaulRank4;
	elseif IsSpellKnown(ids.Feral_Ability.MaulRank3) then _Maul = ids.Feral_Ability.MaulRank3;
	elseif IsSpellKnown(ids.Feral_Ability.MaulRank2) then _Maul = ids.Feral_Ability.MaulRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.PounceRank3) then _Pounce = ids.Feral_Ability.PounceRank3;
	elseif IsSpellKnown(ids.Feral_Ability.PounceRank2) then _Pounce = ids.Feral_Ability.PounceRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.ProwlRank3) then _Prowl = ids.Feral_Ability.ProwlRank3;
	elseif IsSpellKnown(ids.Feral_Ability.ProwlRank2) then _Prowl = ids.Feral_Ability.ProwlRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.RakeRank4) then _Rake = ids.Feral_Ability.RakeRank4;
	elseif IsSpellKnown(ids.Feral_Ability.RakeRank3) then _Rake = ids.Feral_Ability.RakeRank3;
	elseif IsSpellKnown(ids.Feral_Ability.RakeRank2) then _Rake = ids.Feral_Ability.RakeRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.RavageRank4) then _Ravage = ids.Feral_Ability.RavageRank4;
	elseif IsSpellKnown(ids.Feral_Ability.RavageRank3) then _Ravage = ids.Feral_Ability.RavageRank3;
	elseif IsSpellKnown(ids.Feral_Ability.RavageRank2) then _Ravage = ids.Feral_Ability.RavageRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.RipRank6) then _Rip = ids.Feral_Ability.RipRank6;
	elseif IsSpellKnown(ids.Feral_Ability.RipRank5) then _Rip = ids.Feral_Ability.RipRank5;
	elseif IsSpellKnown(ids.Feral_Ability.RipRank4) then _Rip = ids.Feral_Ability.RipRank4;
	elseif IsSpellKnown(ids.Feral_Ability.RipRank3) then _Rip = ids.Feral_Ability.RipRank3;
	elseif IsSpellKnown(ids.Feral_Ability.RipRank2) then _Rip = ids.Feral_Ability.RipRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.ShredRank5) then _Shred = ids.Feral_Ability.ShredRank5;
	elseif IsSpellKnown(ids.Feral_Ability.ShredRank4) then _Shred = ids.Feral_Ability.ShredRank4;
	elseif IsSpellKnown(ids.Feral_Ability.ShredRank3) then _Shred = ids.Feral_Ability.ShredRank3;
	elseif IsSpellKnown(ids.Feral_Ability.ShredRank2) then _Shred = ids.Feral_Ability.ShredRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.SwipeRank5) then _Swipe = ids.Feral_Ability.SwipeRank5;
	elseif IsSpellKnown(ids.Feral_Ability.SwipeRank4) then _Swipe = ids.Feral_Ability.SwipeRank4;
	elseif IsSpellKnown(ids.Feral_Ability.SwipeRank3) then _Swipe = ids.Feral_Ability.SwipeRank3;
	elseif IsSpellKnown(ids.Feral_Ability.SwipeRank2) then _Swipe = ids.Feral_Ability.SwipeRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.TigersFuryRank4) then _TigersFury = ids.Feral_Ability.TigersFuryRank4;
	elseif IsSpellKnown(ids.Feral_Ability.TigersFuryRank3) then _TigersFury = ids.Feral_Ability.TigersFuryRank3;
	elseif IsSpellKnown(ids.Feral_Ability.TigersFuryRank2) then _TigersFury = ids.Feral_Ability.TigersFuryRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.HealingTouchRank10) then _HealingTouch = ids.Resto_Ability.HealingTouchRank10;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank9) then _HealingTouch = ids.Resto_Ability.HealingTouchRank9;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank8) then _HealingTouch = ids.Resto_Ability.HealingTouchRank8;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank7) then _HealingTouch = ids.Resto_Ability.HealingTouchRank7;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank6) then _HealingTouch = ids.Resto_Ability.HealingTouchRank6;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank5) then _HealingTouch = ids.Resto_Ability.HealingTouchRank5;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank4) then _HealingTouch = ids.Resto_Ability.HealingTouchRank4;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank3) then _HealingTouch = ids.Resto_Ability.HealingTouchRank3;
	elseif IsSpellKnown(ids.Resto_Ability.HealingTouchRank2) then _HealingTouch = ids.Resto_Ability.HealingTouchRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.InsectSwarmRank5) then _InsectSwarm = ids.Resto_Ability.InsectSwarmRank5;
	elseif IsSpellKnown(ids.Resto_Ability.InsectSwarmRank4) then _InsectSwarm = ids.Resto_Ability.InsectSwarmRank4;
	elseif IsSpellKnown(ids.Resto_Ability.InsectSwarmRank3) then _InsectSwarm = ids.Resto_Ability.InsectSwarmRank3;
	elseif IsSpellKnown(ids.Resto_Ability.InsectSwarmRank2) then _InsectSwarm = ids.Resto_Ability.InsectSwarmRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.MarkoftheWildRank7) then _MarkoftheWild = ids.Resto_Ability.MarkoftheWildRank7;
	elseif IsSpellKnown(ids.Resto_Ability.MarkoftheWildRank6) then _MarkoftheWild = ids.Resto_Ability.MarkoftheWildRank6;
	elseif IsSpellKnown(ids.Resto_Ability.MarkoftheWildRank5) then _MarkoftheWild = ids.Resto_Ability.MarkoftheWildRank5;
	elseif IsSpellKnown(ids.Resto_Ability.MarkoftheWildRank4) then _MarkoftheWild = ids.Resto_Ability.MarkoftheWildRank4;
	elseif IsSpellKnown(ids.Resto_Ability.MarkoftheWildRank3) then _MarkoftheWild = ids.Resto_Ability.MarkoftheWildRank3;
	elseif IsSpellKnown(ids.Resto_Ability.MarkoftheWildRank2) then _MarkoftheWild = ids.Resto_Ability.MarkoftheWildRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.RebirthRank5) then _Rebirth = ids.Resto_Ability.RebirthRank5;
	elseif IsSpellKnown(ids.Resto_Ability.RebirthRank4) then _Rebirth = ids.Resto_Ability.RebirthRank4;
	elseif IsSpellKnown(ids.Resto_Ability.RebirthRank3) then _Rebirth = ids.Resto_Ability.RebirthRank3;
	elseif IsSpellKnown(ids.Resto_Ability.RebirthRank2) then _Rebirth = ids.Resto_Ability.RebirthRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.RegrowthRank9) then _Regrowth = ids.Resto_Ability.RegrowthRank9;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank8) then _Regrowth = ids.Resto_Ability.RegrowthRank8;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank7) then _Regrowth = ids.Resto_Ability.RegrowthRank7;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank6) then _Regrowth = ids.Resto_Ability.RegrowthRank6;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank5) then _Regrowth = ids.Resto_Ability.RegrowthRank5;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank4) then _Regrowth = ids.Resto_Ability.RegrowthRank4;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank3) then _Regrowth = ids.Resto_Ability.RegrowthRank3;
	elseif IsSpellKnown(ids.Resto_Ability.RegrowthRank2) then _Regrowth = ids.Resto_Ability.RegrowthRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.RejuvenationRank10) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank10;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank9) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank9;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank8) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank8;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank7) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank7;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank6) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank6;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank5) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank5;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank4) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank4;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank3) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank3;
	elseif IsSpellKnown(ids.Resto_Ability.RejuvenationRank2) then _Rejuvenation = ids.Resto_Ability.RejuvenationRank2; end
	
	if IsSpellKnown(ids.Resto_Ability.TranquilityRank4) then _Tranquility = ids.Resto_Ability.TranquilityRank4;
	elseif IsSpellKnown(ids.Resto_Ability.TranquilityRank3) then _Tranquility = ids.Resto_Ability.TranquilityRank3;
	elseif IsSpellKnown(ids.Resto_Ability.TranquilityRank2) then _Tranquility = ids.Resto_Ability.TranquilityRank2; end

--Abilities
	local fFireRDY											= ConROC:AbilityReady(_FaerieFire, timeShift);
		local fFireDEBUFF										= ConROC:DebuffName(_FaerieFire, timeShift);		
	local hiberRDY											= ConROC:AbilityReady(_Hibernate, timeShift);
	local hurrRDY											= ConROC:AbilityReady(_Hurricane, timeShift);
	local mfireRDY											= ConROC:AbilityReady(_Moonfire, timeShift);
		local mfireDEBUFF										= ConROC:TargetDebuff(_Moonfire, timeShift);	
	local mFormRDY											= ConROC:AbilityReady(Bal_Ability.MoonkinForm, timeShift);
		local mFormBUFF											= ConROC:Form(Bal_Ability.MoonkinForm, timeShift);		
	local sootheRDY											= ConROC:AbilityReady(_SootheAnimal, timeShift);
	local sfireRDY											= ConROC:AbilityReady(_Starfire, timeShift);
	local wrathRDY											= ConROC:AbilityReady(_Wrath, timeShift);
	
	local bashRDY											= ConROC:AbilityReady(_Bash, timeShift);
	local bFormRDY											= ConROC:AbilityReady(_BearForm, timeShift);
		local bFormBUFF											= ConROC:Form(_BearForm);	
	local cFormRDY											= ConROC:AbilityReady(Feral_Ability.CatForm, timeShift);
		local cFormBUFF											= ConROC:Form(Feral_Ability.CatForm);	
	local cRoarRDY											= ConROC:AbilityReady(Feral_Ability.ChallengingRoar, timeShift);
	local clawRDY											= ConROC:AbilityReady(_Claw, timeShift);
	local dashRDY											= ConROC:AbilityReady(_Dash, timeShift);
	local enrageRDY											= ConROC:AbilityReady(Feral_Ability.Enrage, timeShift);
	local ffFeralRDY										= ConROC:AbilityReady(_FaerieFireFeral, timeShift);
		local ffFeralDEBUFF										= ConROC:DebuffName(_FaerieFireFeral, timeShift);	
	local fChargeRDY										= ConROC:AbilityReady(Feral_Ability.FeralCharge, timeShift);
	local fBiteRDY											= ConROC:AbilityReady(_FerociousBite, timeShift);
	local maulRDY											= ConROC:AbilityReady(_Maul, timeShift);
	local pounceRDY											= ConROC:AbilityReady(_Pounce, timeShift);
	local prowlRDY											= ConROC:AbilityReady(_Prowl, timeShift);
	local rakeRDY											= ConROC:AbilityReady(_Rake, timeShift);
		local rakeDEBUFF										= ConROC:TargetDebuff(_Rake, timeShift);		
	local ravageRDY											= ConROC:AbilityReady(_Ravage, timeShift);
	local ripRDY											= ConROC:AbilityReady(_Rip, timeShift);
		local ripDEBUFF											= ConROC:TargetDebuff(_Rip, timeShift);	
	local shredRDY											= ConROC:AbilityReady(_Shred, timeShift);
	local swipeRDY											= ConROC:AbilityReady(_Swipe, timeShift);
	local tFuryRDY											= ConROC:AbilityReady(_TigersFury, timeShift);
		local tFuryBUFF											= ConROC:Buff(_TigersFury, timeShift);		
	local trackHRDY											= ConROC:AbilityReady(Feral_Ability.TrackHumanoid, timeShift);
	local tFormRDY											= ConROC:AbilityReady(Feral_Ability.TravelForm, timeShift);
		local tFormBUFF											= ConROC:Form(Feral_Ability.TravelForm);	
	
	local hTouchRDY											= ConROC:AbilityReady(_HealingTouch, timeShift);
	local innerRDY											= ConROC:AbilityReady(Resto_Ability.Innervate, timeShift);
	local iSwarmRDY											= ConROC:AbilityReady(_InsectSwarm, timeShift);
		local iSwarmDEBUFF										= ConROC:TargetDebuff(_InsectSwarm, timeShift);	
	local moftwRDY											= ConROC:AbilityReady(_MarkoftheWild, timeShift);
		local moftwBUFF											= ConROC:Buff(_MarkoftheWild, timeShift);	
	local nSwiftRDY											= ConROC:AbilityReady(Resto_Ability.NaturesSwiftness, timeShift);
	local rebirthRDY										= ConROC:AbilityReady(_Rebirth, timeShift);
	local regrowthRDY										= ConROC:AbilityReady(_Regrowth, timeShift);
		local regrowthBUFF										= ConROC:Buff(_Regrowth, timeShift);	
	local rejuvRDY											= ConROC:AbilityReady(_Rejuvenation, timeShift);
		local rejuvBUFF											= ConROC:Buff(_Rejuvenation, timeShift);	
	local sMendRDY											= ConROC:AbilityReady(Resto_Ability.Swiftmend, timeShift);
	local tranqRDY											= ConROC:AbilityReady(_Tranquility, timeShift);	
	
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local stealthed											= IsStealthed();
	local targetPh 											= ConROC:PercentHealth('target');	
	local moving 											= ConROC:PlayerSpeed();
	local Close 											= CheckInteractDistance("target", 3);
	local isEnemy 											= ConROC:TarHostile();
	local tarInMelee										= 0;
	
	if plvl >= 10 and IsSpellKnown(Feral_Ability.Growl) then
		tarInMelee = ConROC:Targets(Feral_Ability.Growl);	
	elseif plvl >= 20 and IsSpellKnown(_Claw) then
		tarInMelee = ConROC:Targets(_Claw);
	end
	
	local bearCost = 0;
	local maulCost = 15;
	local swipeCost = 20;
	
	local catCost = manaBase * (.55 * (1.0 - (.1 * select(2, ConROC:TalentChosen(Spec.Balance, Bal_Talent.NaturalShapeshifter)))))
	local rakeCost = 40;
	local clawCost = 45;
	local shredCost = 60;

		
	if ConROC:TalentChosen(Spec.Feral, Feral_Talent.Ferocity) then
		ferocityBonus = select(2, ConROC:TalentChosen(Spec.Feral, Feral_Talent.Ferocity));
		
		maulCost = maulCost - ferocityBonus;
		swipeCost = swipeCost - ferocityBonus;
		rakeCost = rakeCost - ferocityBonus;
		clawCost = clawCost - ferocityBonus;
	end
	
	if ConROC:TalentChosen(Spec.Feral, Feral_Talent.ImprovedShred) then
		shredBonus = select(2, ConROC:TalentChosen(Spec.Feral, Feral_Talent.ImprovedShred));
		
		shredCost = shredCost - (shredBonus * 6);
	end
	
	
	ConROCPowerShift:Hide();
	
--Indicators
	ConROC:AbilityRaidBuffs(_MarkoftheWild, moftwRDY and not moftwBUFF);
	
--Rotations	
	if hurrRDY and tarInMelee >= 4 then
		return _Hurricane;
	end
	
	if stealthed and cFormBUFF then
		if tFuryRDY and not tFuryBUFF and energy >= 80 then
			return _TigersFury;
		end
		
		if ravageRDY and combo < comboMax and not ConROC:TarYou() then
			return _Ravage;
		end
		
		if shredRDY and combo < comboMax and not ConROC:TarYou() then
			if ConROC:TalentChosen(Spec.Restoration, Resto_Talent.Furor) and catCost <= mana and energy - shredCost <= 8 then
				ConROCPowerShift:Show();
			end
			return _Shred;
		end	
	end
	
	if cFormBUFF then
		if ffFeralRDY and not (fFireDEBUFF or ffFeralDEBUFF) then
			return _FaerieFireFeral;
		end
		
		if tFuryRDY and not tFuryBUFF and energy >= 80 then
			return _TigersFury;
		end
		
		--[[if ripRDY and not ripDEBUFF and combo >= 5 and not (ConROC:CreatureType("Undead") or ConROC:CreatureType("Mechanical") or ConROC:CreatureType("Elemental")) then
			return _Rip;
		end]] --Not good output unless player wants chosen in SpellMenu
	
		if fBiteRDY and combo >= 5 then
			if ConROC:TalentChosen(Spec.Restoration, Resto_Talent.Furor) and catCost <= mana and energy - 35 <= 8 then
				ConROCPowerShift:Show();
			end
			return _FerociousBite;
		end
		
		if rakeRDY and not rakeDEBUFF and not (ConROC:CreatureType("Undead") or ConROC:CreatureType("Mechanical") or ConROC:CreatureType("Elemental")) then
			if ConROC:TalentChosen(Spec.Restoration, Resto_Talent.Furor) and catCost <= mana and energy - rakeCost <= 8 then
				ConROCPowerShift:Show();
			end
			return _Rake;
		end
		
		if shredRDY and combo < comboMax and not ConROC:TarYou() then
			if ConROC:TalentChosen(Spec.Restoration, Resto_Talent.Furor) and catCost <= mana and energy - shredCost <= 8 then
				ConROCPowerShift:Show();
			end
			return _Shred;
		end

		if clawRDY and combo < comboMax and (not IsSpellKnown(_Shred) or ConROC:TarYou()) then
			if ConROC:TalentChosen(Spec.Restoration, Resto_Talent.Furor) and catCost <= mana and energy - clawCost <= 8 then
				ConROCPowerShift:Show();
			end
			return _Claw;
		end

	elseif bFormBUFF then
		if ffFeralRDY and not (fFireDEBUFF or ffFeralDEBUFF) then
			return _FaerieFireFeral;
		end	
		
		ConROC:AbilityTaunt(_Maul, maulRDY);
		
		if swipeRDY and (rage >= rageMax - 40 or tarInMelee >= 3) then
			return _Swipe;
		end
	end
	
	if mFormRDY and not mFormBUFF then
		return Bal_Ability.MoonkinForm;
	end
	
	if not incombat then
		if sfireRDY then
			return _Starfire;
		end
		
		if wrathRDY then
			return _Wrath;
		end	
	end
	
	if fFireRDY and not (fFireDEBUFF or ffFeralDEBUFF)  then
		return _FaerieFire;
	end
		
	if mfireRDY and not mfireDEBUFF then
		return _Moonfire;
	end
	
	if wrathRDY then
		return _Wrath;
	end

	return nil;
end

function ConROC.Druid.Defense(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);
	local energy 											= UnitPower('player', Enum.PowerType.Energy);
	local energyMax 										= UnitPowerMax('player', Enum.PowerType.Energy);
	local energyPercent 									= math.max(0, energy) / math.max(1, energyMax) * 100;	
    local combo 											= UnitPower('player', Enum.PowerType.ComboPoints);
	local comboMax 											= UnitPowerMax('player', Enum.PowerType.ComboPoints);
	
--Ranks
	if IsSpellKnown(ids.Bal_Ability.EntanglingRootsRank6) then _EntanglingRoots = ids.Bal_Ability.EntanglingRootsRank6;
	elseif IsSpellKnown(ids.Bal_Ability.EntanglingRootsRank5) then _EntanglingRoots = ids.Bal_Ability.EntanglingRootsRank5;
	elseif IsSpellKnown(ids.Bal_Ability.EntanglingRootsRank4) then _EntanglingRoots = ids.Bal_Ability.EntanglingRootsRank4;
	elseif IsSpellKnown(ids.Bal_Ability.EntanglingRootsRank3) then _EntanglingRoots = ids.Bal_Ability.EntanglingRootsRank3;
	elseif IsSpellKnown(ids.Bal_Ability.EntanglingRootsRank2) then _EntanglingRoots = ids.Bal_Ability.EntanglingRootsRank2; end

	if IsSpellKnown(ids.Bal_Ability.NaturesGraspRank6) then _NaturesGrasp = ids.Bal_Ability.NaturesGraspRank6;
	elseif IsSpellKnown(ids.Bal_Ability.NaturesGraspRank5) then _NaturesGrasp = ids.Bal_Ability.NaturesGraspRank5;
	elseif IsSpellKnown(ids.Bal_Ability.NaturesGraspRank4) then _NaturesGrasp = ids.Bal_Ability.NaturesGraspRank4;
	elseif IsSpellKnown(ids.Bal_Ability.NaturesGraspRank3) then _NaturesGrasp = ids.Bal_Ability.NaturesGraspRank3;
	elseif IsSpellKnown(ids.Bal_Ability.NaturesGraspRank2) then _NaturesGrasp = ids.Bal_Ability.NaturesGraspRank2; end
	
	if IsSpellKnown(ids.Bal_Ability.ThornsRank6) then _Thorns = ids.Bal_Ability.ThornsRank6;
	elseif IsSpellKnown(ids.Bal_Ability.ThornsRank5) then _Thorns = ids.Bal_Ability.ThornsRank5;
	elseif IsSpellKnown(ids.Bal_Ability.ThornsRank4) then _Thorns = ids.Bal_Ability.ThornsRank4;
	elseif IsSpellKnown(ids.Bal_Ability.ThornsRank3) then _Thorns = ids.Bal_Ability.ThornsRank3;
	elseif IsSpellKnown(ids.Bal_Ability.ThornsRank2) then _Thorns = ids.Bal_Ability.ThornsRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.CowerRank3) then _Cower = ids.Feral_Ability.CowerRank3;
	elseif IsSpellKnown(ids.Feral_Ability.CowerRank2) then _Cower = ids.Feral_Ability.CowerRank2; end
	
	if IsSpellKnown(ids.Feral_Ability.DemoralizingRoarRank5) then _DemoralizingRoar = ids.Feral_Ability.DemoralizingRoarRank5;
	elseif IsSpellKnown(ids.Feral_Ability.DemoralizingRoarRank4) then _DemoralizingRoar = ids.Feral_Ability.DemoralizingRoarRank4;
	elseif IsSpellKnown(ids.Feral_Ability.DemoralizingRoarRank3) then _DemoralizingRoar = ids.Feral_Ability.DemoralizingRoarRank3;
	elseif IsSpellKnown(ids.Feral_Ability.DemoralizingRoarRank2) then _DemoralizingRoar = ids.Feral_Ability.DemoralizingRoarRank2; end

	if IsSpellKnown(ids.Feral_Ability.FrenziedRegenerationRank3) then _FrenziedRegeneration = ids.Feral_Ability.FrenziedRegenerationRank3;
	elseif IsSpellKnown(ids.Feral_Ability.FrenziedRegenerationRank2) then _FrenziedRegeneration = ids.Feral_Ability.FrenziedRegenerationRank2; end
	
--Abilities	
	local bskinRDY											= ConROC:AbilityReady(Bal_Ability.Barkskin, timeShift);
	local eRootsRDY											= ConROC:AbilityReady(_EntanglingRoots, timeShift);
		local eRootsDebuff										= ConROC:TargetDebuff(_EntanglingRoots, timeShift);
	local nGraspRDY											= ConROC:AbilityReady(_NaturesGrasp, timeShift);
		local nGraspBUFF										= ConROC:Buff(_NaturesGrasp, timeShift);
	local oofcRDY											= ConROC:AbilityReady(Bal_Ability.OmenofClarity, timeShift);
		local oofcBUFF											= ConROC:Buff(Bal_Ability.OmenofClarity, timeShift);		
	local thornsRDY											= ConROC:AbilityReady(_Thorns, timeShift);
		local thornsBUFF										= ConROC:Buff(_Thorns, timeShift);

		local bFormBUFF											= ConROC:Form(_BearForm);		
	local cowerRDY											= ConROC:AbilityReady(_Cower, timeShift);
	local dRoarRDY											= ConROC:AbilityReady(_DemoralizingRoar, timeShift);
		local dRoarDebuff										= ConROC:TargetDebuff(_DemoralizingRoar, timeShift);	
	local fRegenRDY											= ConROC:AbilityReady(_FrenziedRegeneration, timeShift);

	local aPoisonRDY										= ConROC:AbilityReady(Resto_Ability.AbolishPoison, timeShift);
	local rCurseRDY											= ConROC:AbilityReady(Resto_Ability.RemoveCurse, timeShift);
	
--Conditions	
	local playerPh 											= ConROC:PercentHealth('player');
	local incombat 											= UnitAffectingCombat('player');
	
--Rotations	
	if thornsRDY and not thornsBUFF then
		return _Thorns;
	end
	
	if oofcRDY and not oofcBUFF then
		return Bal_Ability.OmenofClarity;
	end
	
	if nGraspRDY and not nGraspBUFF then
		return _NaturesGrasp;
	end
	
	if bFormBUFF then
		if dRoarRDY and not dRoarDebuff then
			return _DemoralizingRoar;
		end
	end
	
	if bskinRDY then
		return Bal_Ability.Barkskin;
	end
	
	return nil;
end

function ConROC:PowerShift()

	local frame = CreateFrame("Frame", "ConROCPowerShift", UIParent)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(50, 10) -- 50 with Roles turned on. 20 when off.
		frame:SetAlpha(1)
		
		frame:SetPoint("LEFT", "ConROCWindow", "RIGHT", 15, -15)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		
		local fonttitle = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalMed3");
			fonttitle:SetText("Powershift");
			fonttitle:SetPoint('TOP', frame, 'TOP', 0, 0);
		local fonttitle2 = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalMed3");
			fonttitle2:SetText("Cat Next");
			fonttitle2:SetPoint('TOP', frame, 'TOP', 0, -15);
			
		frame:Hide();
end
