ConROC.Shaman = {};

local ConROC_Shaman, ids = ...;

function ConROC:EnableRotationModule()
	self.Description = 'Shaman';
	self.NextSpell = ConROC.Shaman.Damage;
	
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
	
--	ConROC:SpellmenuClass();	
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Shaman.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

	local Racial, Spec, Ele_Ability, Ele_Talent, Enh_Ability, Enh_Talent, Resto_Ability, Resto_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Ele_Ability, ids.Ele_Talent, ids.Enh_Ability, ids.Enh_Talent, ids.Resto_Ability, ids.Resto_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;

	local _ChainLightning = Ele_Ability.ChainLightningRank1;
	local _EarthShock = Ele_Ability.EarthShockRank1;
	local _FireNovaTotem = Ele_Ability.FireNovaTotemRank1;
	local _FlameShock = Ele_Ability.FlameShockRank1;
	local _FrostShock = Ele_Ability.FrostShockRank1;
	local _LightningBolt = Ele_Ability.LightningBoltRank1;
	local _MagmaTotem = Ele_Ability.MagmaTotemRank1;
	local _Purge = Ele_Ability.PurgeRank1;
	local _SearingTotem = Ele_Ability.SearingTotemRank1;	
	local _StoneclawTotem = Ele_Ability.StoneclawTotemRank1;
	
	local _FireResistanceTotem = Enh_Ability.FireResistanceTotemRank1;
	local _FlametongueTotem = Enh_Ability.FlametongueTotemRank1;
	local _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank1;
	local _FrostResistanceTotem = Enh_Ability.FrostResistanceTotemRank1;
	local _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank1;
	local _GraceofAirTotem = Enh_Ability.GraceofAirTotemRank1;
	local _LightningShield = Enh_Ability.LightningShieldRank1;
	local _NatureResistanceTotem = Enh_Ability.NatureResistanceTotemRank1;
	local _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank1;
	local _StoneskinTotem = Enh_Ability.StoneskinTotemRank1;
	local _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank1;
	local _WindfuryTotem = Enh_Ability.WindfuryTotemRank1;
	local _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank1;
	local _WindwallTotem = Enh_Ability.WindwallTotemRank1;
	
	local _AncestralSpirit = Resto_Ability.AncestralSpiritRank1;
	local _ChainHeal = Resto_Ability.ChainHealRank1;
	local _LesserHealingWave = Resto_Ability.LesserHealingWaveRank1;
	local _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank1;
	local _HealingWave = Resto_Ability.HealingWaveRank1;
	local _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank1;
	local _ManaTideTotem = Resto_Ability.ManaTideTotemRank1;

function ConROC.Shaman.Damage(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	
--Ranks
	if IsSpellKnown(Ele_Ability.ChainLightningRank4) then _ChainLightning = Ele_Ability.ChainLightningRank4;
	elseif IsSpellKnown(Ele_Ability.ChainLightningRank3) then _ChainLightning = Ele_Ability.ChainLightningRank3;
	elseif IsSpellKnown(Ele_Ability.ChainLightningRank2) then _ChainLightning = Ele_Ability.ChainLightningRank2; end	
	
	if IsSpellKnown(Ele_Ability.EarthShockRank7) then _EarthShock = Ele_Ability.EarthShockRank7;
	elseif IsSpellKnown(Ele_Ability.EarthShockRank6) then _EarthShock = Ele_Ability.EarthShockRank6;
	elseif IsSpellKnown(Ele_Ability.EarthShockRank5) then _EarthShock = Ele_Ability.EarthShockRank5;
	elseif IsSpellKnown(Ele_Ability.EarthShockRank4) then _EarthShock = Ele_Ability.EarthShockRank4;
	elseif IsSpellKnown(Ele_Ability.EarthShockRank3) then _EarthShock = Ele_Ability.EarthShockRank3;
	elseif IsSpellKnown(Ele_Ability.EarthShockRank2) then _EarthShock = Ele_Ability.EarthShockRank2; end	
	
	if IsSpellKnown(Ele_Ability.FireNovaTotemRank5) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank5;
	elseif IsSpellKnown(Ele_Ability.FireNovaTotemRank4) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank4;
	elseif IsSpellKnown(Ele_Ability.FireNovaTotemRank3) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank3;
	elseif IsSpellKnown(Ele_Ability.FireNovaTotemRank2) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank2; end	
	
	if IsSpellKnown(Ele_Ability.FlameShockRank5) then _FlameShock = Ele_Ability.FlameShockRank5;
	elseif IsSpellKnown(Ele_Ability.FlameShockRank4) then _FlameShock = Ele_Ability.FlameShockRank4;
	elseif IsSpellKnown(Ele_Ability.FlameShockRank3) then _FlameShock = Ele_Ability.FlameShockRank3;
	elseif IsSpellKnown(Ele_Ability.FlameShockRank2) then _FlameShock = Ele_Ability.FlameShockRank2; end	
	
	if IsSpellKnown(Ele_Ability.FrostShockRank4) then _FrostShock = Ele_Ability.FrostShockRank4;
	elseif IsSpellKnown(Ele_Ability.FrostShockRank3) then _FrostShock = Ele_Ability.FrostShockRank3;
	elseif IsSpellKnown(Ele_Ability.FrostShockRank2) then _FrostShock = Ele_Ability.FrostShockRank2; end	
		
	if IsSpellKnown(Ele_Ability.LightningBoltRank10) then _LightningBolt = Ele_Ability.LightningBoltRank10;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank9) then _LightningBolt = Ele_Ability.LightningBoltRank9;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank8) then _LightningBolt = Ele_Ability.LightningBoltRank8;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank7) then _LightningBolt = Ele_Ability.LightningBoltRank7;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank6) then _LightningBolt = Ele_Ability.LightningBoltRank6;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank5) then _LightningBolt = Ele_Ability.LightningBoltRank5;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank4) then _LightningBolt = Ele_Ability.LightningBoltRank4;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank3) then _LightningBolt = Ele_Ability.LightningBoltRank3;
	elseif IsSpellKnown(Ele_Ability.LightningBoltRank2) then _LightningBolt = Ele_Ability.LightningBoltRank2; end

	if IsSpellKnown(Ele_Ability.MagmaTotemRank4) then _MagmaTotem = Ele_Ability.MagmaTotemRank4;
	elseif IsSpellKnown(Ele_Ability.MagmaTotemRank3) then _MagmaTotem = Ele_Ability.MagmaTotemRank3;
	elseif IsSpellKnown(Ele_Ability.MagmaTotemRank2) then _MagmaTotem = Ele_Ability.MagmaTotemRank2; end

	if IsSpellKnown(Ele_Ability.PurgeRank2) then _Purge = Ele_Ability.PurgeRank2; end

	if IsSpellKnown(Ele_Ability.SearingTotemRank6) then _SearingTotem = Ele_Ability.SearingTotemRank6;
	elseif IsSpellKnown(Ele_Ability.SearingTotemRank5) then _SearingTotem = Ele_Ability.SearingTotemRank5;
	elseif IsSpellKnown(Ele_Ability.SearingTotemRank4) then _SearingTotem = Ele_Ability.SearingTotemRank4;
	elseif IsSpellKnown(Ele_Ability.SearingTotemRank3) then _SearingTotem = Ele_Ability.SearingTotemRank3;
	elseif IsSpellKnown(Ele_Ability.SearingTotemRank2) then _SearingTotem = Ele_Ability.SearingTotemRank2; end

	if IsSpellKnown(Ele_Ability.StoneclawTotemRank6) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank6;
	elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank5) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank5;
	elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank4) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank4;
	elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank3) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank3;
	elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank2) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank2; end

	if IsSpellKnown(Enh_Ability.FireResistanceTotemRank3) then _FireResistanceTotem = Enh_Ability.FireResistanceTotemRank3;
	elseif IsSpellKnown(Enh_Ability.FireResistanceTotemRank2) then _FireResistanceTotem = Enh_Ability.FireResistanceTotemRank2; end

	if IsSpellKnown(Enh_Ability.FlametongueTotemRank4) then _FlametongueTotem = Enh_Ability.FlametongueTotemRank4;
	elseif IsSpellKnown(Enh_Ability.FlametongueTotemRank3) then _FlametongueTotem = Enh_Ability.FlametongueTotemRank3;
	elseif IsSpellKnown(Enh_Ability.FlametongueTotemRank2) then _FlametongueTotem = Enh_Ability.FlametongueTotemRank2; end

	if IsSpellKnown(Enh_Ability.FlametongueWeaponRank6) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank6;
	elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank5) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank5;
	elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank4) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank4;
	elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank3) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank3;
	elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank2) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank2; end
	
	if IsSpellKnown(Enh_Ability.FrostResistanceTotemRank3) then _FrostResistanceTotem = Enh_Ability.FrostResistanceTotemRank3;
	elseif IsSpellKnown(Enh_Ability.FrostResistanceTotemRank2) then _FrostResistanceTotem = Enh_Ability.FrostResistanceTotemRank2; end	
	
	if IsSpellKnown(Enh_Ability.FrostbrandWeaponRank5) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank5;
	elseif IsSpellKnown(Enh_Ability.FrostbrandWeaponRank4) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank4;
	elseif IsSpellKnown(Enh_Ability.FrostbrandWeaponRank3) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank3;
	elseif IsSpellKnown(Enh_Ability.FrostbrandWeaponRank2) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank2; end

	if IsSpellKnown(Enh_Ability.GraceofAirTotemRank2) then _GraceofAirTotem = Enh_Ability.GraceofAirTotemRank2; end

	if IsSpellKnown(Enh_Ability.NatureResistanceTotemRank3) then _NatureResistanceTotem = Enh_Ability.NatureResistanceTotemRank3;
	elseif IsSpellKnown(Enh_Ability.NatureResistanceTotemRank2) then _NatureResistanceTotem = Enh_Ability.NatureResistanceTotemRank2; end

	if IsSpellKnown(Enh_Ability.RockbiterWeaponRank7) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank7;
	elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank6) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank6;
	elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank5) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank5;
	elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank4) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank4;
	elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank3) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank3;
	elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank2) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank2; end

	if IsSpellKnown(Enh_Ability.StoneskinTotemRank6) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank6;
	elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank5) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank5;
	elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank4) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank4;
	elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank3) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank3;
	elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank2) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank2; end

	if IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank4) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank4;
	elseif IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank3) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank3;
	elseif IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank2) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank2; end

	if IsSpellKnown(Enh_Ability.WindfuryTotemRank3) then _WindfuryTotem = Enh_Ability.WindfuryTotemRank3;
	elseif IsSpellKnown(Enh_Ability.WindfuryTotemRank2) then _WindfuryTotem = Enh_Ability.WindfuryTotemRank2; end
	
	if IsSpellKnown(Enh_Ability.WindfuryWeaponRank4) then _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank4;
	elseif IsSpellKnown(Enh_Ability.WindfuryWeaponRank3) then _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank3;
	elseif IsSpellKnown(Enh_Ability.WindfuryWeaponRank2) then _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank2; end
	
	if IsSpellKnown(Enh_Ability.WindwallTotemRank3) then _WindwallTotem = Enh_Ability.WindwallTotemRank3;
	elseif IsSpellKnown(Enh_Ability.WindwallTotemRank2) then _WindwallTotem = Enh_Ability.WindwallTotemRank2; end

	if IsSpellKnown(Resto_Ability.AncestralSpiritRank5) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank5;
	elseif IsSpellKnown(Resto_Ability.AncestralSpiritRank4) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank4;
	elseif IsSpellKnown(Resto_Ability.AncestralSpiritRank3) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank3;
	elseif IsSpellKnown(Resto_Ability.AncestralSpiritRank2) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank2; end

	if IsSpellKnown(Resto_Ability.ChainHealRank3) then _ChainHeal = Resto_Ability.ChainHealRank3;
	elseif IsSpellKnown(Resto_Ability.ChainHealRank2) then _ChainHeal = Resto_Ability.ChainHealRank2; end

	if IsSpellKnown(Resto_Ability.LesserHealingWaveRank6) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank6;
	elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank5) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank5;
	elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank4) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank4;
	elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank3) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank3;
	elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank2) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank2; end

	if IsSpellKnown(Resto_Ability.HealingStreamTotemRank5) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank5;
	elseif IsSpellKnown(Resto_Ability.HealingStreamTotemRank4) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank4;
	elseif IsSpellKnown(Resto_Ability.HealingStreamTotemRank3) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank3;
	elseif IsSpellKnown(Resto_Ability.HealingStreamTotemRank2) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank2; end

	if IsSpellKnown(Resto_Ability.HealingWaveRank9) then _HealingWave = Resto_Ability.HealingWaveRank9;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank8) then _HealingWave = Resto_Ability.HealingWaveRank8;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank7) then _HealingWave = Resto_Ability.HealingWaveRank7;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank6) then _HealingWave = Resto_Ability.HealingWaveRank6;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank5) then _HealingWave = Resto_Ability.HealingWaveRank5;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank4) then _HealingWave = Resto_Ability.HealingWaveRank4;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank3) then _HealingWave = Resto_Ability.HealingWaveRank3;
	elseif IsSpellKnown(Resto_Ability.HealingWaveRank2) then _HealingWave = Resto_Ability.HealingWaveRank2; end

	if IsSpellKnown(Resto_Ability.ManaSpringTotemRank4) then _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank4;
	elseif IsSpellKnown(Resto_Ability.ManaSpringTotemRank3) then _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank3;
	elseif IsSpellKnown(Resto_Ability.ManaSpringTotemRank2) then _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank2; end

	if IsSpellKnown(Resto_Ability.ManaTideTotemRank3) then _ManaTideTotem = Resto_Ability.ManaTideTotemRank3;
	elseif IsSpellKnown(Resto_Ability.ManaTideTotemRank2) then _ManaTideTotem = Resto_Ability.ManaTideTotemRank2; end

--Abilities	
	local lBoltRDY											= ConROC:AbilityReady(_LightningBolt, timeShift);
	local chainLRDY											= ConROC:AbilityReady(_ChainLightning, timeShift);
	local eShockRDY											= ConROC:AbilityReady(_EarthShock, timeShift);
		local eShockR1RDY										= ConROC:AbilityReady(Ele_Ability.EarthShockRank1, timeShift);	
	local fShockRDY											= ConROC:AbilityReady(_FlameShock, timeShift);
	local frShockRDY										= ConROC:AbilityReady(_FrostShock, timeShift);
	local eMastRDY											= ConROC:AbilityReady(Ele_Ability.ElementalMastery, timeShift);
	local purgeRDY											= ConROC:AbilityReady(_Purge, timeShift);
	local sStrikeRDY										= ConROC:AbilityReady(Enh_Ability.Stormstrike, timeShift);

	local ftWepRDY											= ConROC:AbilityReady(_FlametongueWeapon, timeShift);
	local fbWepRDY											= ConROC:AbilityReady(_FrostbrandWeapon, timeShift);
	local rbWepRDY											= ConROC:AbilityReady(_RockbiterWeapon, timeShift);
	local wfWepRDY											= ConROC:AbilityReady(_WindfuryWeapon, timeShift);
	
	local fnTotemRDY										= ConROC:AbilityReady(_FireNovaTotem, timeShift);
	local mTotemRDY											= ConROC:AbilityReady(_MagmaTotem, timeShift);	
	local searTotemRDY										= ConROC:AbilityReady(_SearingTotem, timeShift);
	local ftTotemRDY										= ConROC:AbilityReady(_FlametongueTotem, timeShift);
	local grTotemRDY										= ConROC:AbilityReady(Enh_Ability.GroundingTotem, timeShift);
	local senTotemRDY										= ConROC:AbilityReady(Enh_Ability.SentryTotem, timeShift);
	local sClawTotemRDY										= ConROC:AbilityReady(_StoneclawTotem, timeShift);
	local sSkinTotemRDY										= ConROC:AbilityReady(_StoneskinTotem, timeShift);
	local soeTotemRDY										= ConROC:AbilityReady(_StrengthofEarthTotem, timeShift);
	local goaTotemRDY										= ConROC:AbilityReady(_GraceofAirTotem, timeShift);
	local wfTotemRDY										= ConROC:AbilityReady(_WindfuryTotem, timeShift);
	local wwTotemRDY										= ConROC:AbilityReady(_WindwallTotem, timeShift);
	local fResistTotemRDY									= ConROC:AbilityReady(_FireResistanceTotem, timeShift);
	local frResistTotemRDY									= ConROC:AbilityReady(_FrostResistanceTotem, timeShift);
	local nResistTotemRDY									= ConROC:AbilityReady(_NatureResistanceTotem, timeShift);

		local cCastingBuff										= ConROC:Buff(Player_Buff.Clearcasting, timeShift);
		
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local inMelee											= CheckInteractDistance('target', 3);
	local targetPh 											= ConROC:PercentHealth('target');
	local moving 											= ConROC:PlayerSpeed();
	local hasMHEnch, _, mhCharges, mhEnchID, hasOHEnch, _, ohCharges, ohEnchId = GetWeaponEnchantInfo();
	
--Indicators	
	ConROC:AbilityRaidBuffs(_RockbiterWeapon, rbWepRDY and plvl < 30 and not hasMHEnch);	
	ConROC:AbilityRaidBuffs(_WindfuryWeapon, wfWepRDY and plvl >= 30 and not hasMHEnch);
	
--Warnings
	
--Rotations	
	if chainLRDY and cCastingBuff then
		return _ChainLightning;
	end

	if eShockRDY and ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob())) then
		return _EarthShock;
	end
	
	if lBoltRDY and not inMelee then
		return _LightningBolt;
	end
	
	if inMelee then
		if sStrikeRDY then
			return Enh_Ability.Stormstrike;
		end

		if eShockRDY and (cCastingBuff or ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob()))) then
			return _EarthShock;
		end
		
		if eShockR1RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
			return Ele_Ability.EarthShockRank1;
		end		
	end
	return nil;
end

function ConROC.Shaman.Defense(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	
--Ranks
	if IsSpellKnown(Enh_Ability.LightningShieldRank7) then _LightningShield = Enh_Ability.LightningShieldRank7;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank6) then _LightningShield = Enh_Ability.LightningShieldRank6;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank5) then _LightningShield = Enh_Ability.LightningShieldRank5;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank4) then _LightningShield = Enh_Ability.LightningShieldRank4;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank3) then _LightningShield = Enh_Ability.LightningShieldRank3;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank2) then _LightningShield = Enh_Ability.LightningShieldRank2; end

--Abilities	
	local lShieldRDY										= ConROC:AbilityReady(_LightningShield, timeShift);
		local lShieldBUFF										= ConROC:Buff(_LightningShield, timeShift);
	
--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local moving 											= ConROC:PlayerSpeed();

--Indicators	

--Warnings
	
--Rotations	
	if lShieldRDY and not lShieldBUFF then
		return _LightningShield;
	end
	
	return nil;
end
