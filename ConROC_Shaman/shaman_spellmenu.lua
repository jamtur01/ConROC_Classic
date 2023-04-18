local ConROC_Shaman, ids = ...;

local lastFrame = 0;
local lastArmor = 0;
local lastFiller = 0;
local lastAoE = 0;
local lastOption = 0;


local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Caster"] = true,

	["ConROC_Caster_Armor_Ice"] = true,
	["ConROC_Caster_Filler_Fireball"] = true,
	["ConROC_Caster_AoE_ArcaneExplosion"] = true,
	["ConROC_Caster_AoE_Flamestrike"] = true,
	["ConROC_Caster_AoE_Blizzard"] = true,
	["ConROC_Caster_Option_UseWand"] = true,
	["ConROC_Caster_Option_AoE"] = true,
}


ConROCShamanSpells = ConROCShamanSpells or defaults;

function ConROC:SpellmenuClass()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCSpellmenuClass", ConROCSpellmenuFrame2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 30)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCSpellmenuFrame_Title", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		
	--Caster
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Role_Caster", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(nil, "ARTWORK", "GameFontRedSmall");
			radio1:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -10);
			radio1:SetChecked(ConROCShamanSpells.ConROC_SM_Role_Caster);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Caster:SetChecked(true);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Healer:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCShamanSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile();
					ConROC:SpellMenuUpdate();
				end
			);
			radio1text:SetText("Caster");
			radio1text:SetPoint("BOTTOM", radio1, "TOP", 0, 3);

	--Melee
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Role_Melee", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontRedSmall");		
			radio2:SetPoint("LEFT", radio1, "RIGHT", 18, 0);
			radio2:SetChecked(ConROCShamanSpells.ConROC_SM_Role_Melee);
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Role_Caster:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(true);
					ConROC_SM_Role_Healer:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCShamanSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile();
					ConROC:SpellMenuUpdate();
				end
			);
			radio2text:SetText("Melee");
			radio2text:SetPoint("BOTTOM", radio2, "TOP", 0, 3);
		
	--Healer
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Role_Healer", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontRedSmall");
			radio3:SetPoint("LEFT", radio2, "RIGHT", 18, 0);
			radio3:SetChecked(ConROCShamanSpells.ConROC_SM_Role_Healer);
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Caster:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Healer:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCShamanSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile();
					ConROC:SpellMenuUpdate();
				end
			);
			radio3text:SetText("Heal");
			radio3text:SetPoint("BOTTOM", radio3, "TOP", 0, 3);
			
	--PvP
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Role_PvP", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(nil, "ARTWORK", "GameFontRedSmall");
			radio4:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -10);
			radio4:SetChecked(ConROCShamanSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Caster:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Healer:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCShamanSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCShamanSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile();
					ConROC:SpellMenuUpdate();
				end
			);
			radio4text:SetText("PvP");
			radio4text:SetPoint("BOTTOM", radio4, "TOP", 0, 3);
			

		frame:Hide()
		lastFrame = frame;
	
--	ConROC:RadioHeader1();
--	ConROC:RadioHeader2();
--	ConROC:CheckHeader1();
--	ConROC:CheckHeader2();
end



function ConROC:SpellMenuUpdate()

end