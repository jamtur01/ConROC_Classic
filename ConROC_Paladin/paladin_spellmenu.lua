local ConROC_Paladin, ids = ...;

local lastFrame = 0;
local lastAura = 0;
local lastJudge = 0;
local lastSeal = 0;
local lastBless = 0;
local lastStun = 0;

local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Melee"] = true,
	
	["ConROC_SM_Aura_Devotion"] = true,
	["ConROC_SM_Judgement_Crusader"] = true,
	["ConROC_SM_Seal_Righteousness"] = true,
	["ConROC_SM_Bless_Might"] = true,
}


ConROCPaladinSpells = ConROCPaladinSpells or defaults;

function ConROC:SpellmenuClass()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCSpellmenuClass", ConROCSpellmenuFrame2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 30) --30 with Roles turned on. 1 when off.
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCSpellmenuFrame_Title", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		
	--Tank
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Role_Tank", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontRedSmall");
			radio1:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -10);
			radio1:SetChecked(ConROCPaladinSpells.ConROC_SM_Role_Tank);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Tank:SetChecked(true);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Healer:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCPaladinSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio1text:SetText("Tank");				
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('Spellmenu_radio1_Texture', 'ARTWORK');
				r1t:SetTexture('Interface\\AddOns\\ConROC\\images\\shield2');
				r1t:SetBlendMode('BLEND');
				local color = ConROC.db.profile.defenseOverlayColor;
				r1t:SetVertexColor(color.r, color.g, color.b);				
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("CENTER", radio1, "CENTER", 0, 0);
			radio1text:SetPoint("BOTTOM", radio1, "TOP", 0, 5);
		
	--Melee
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Role_Melee", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontRedSmall");		
			radio2:SetPoint("LEFT", radio1, "RIGHT", 18, 0);
			radio2:SetChecked(ConROCPaladinSpells.ConROC_SM_Role_Melee);
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Role_Tank:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(true);
					ConROC_SM_Role_Healer:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCPaladinSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio2text:SetText("Melee");					
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('Spellmenu_radio2_Texture', 'ARTWORK');
				r2t:SetTexture('Interface\\AddOns\\ConROC\\images\\bigskull');
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("CENTER", radio2, "CENTER", 0, 0);
			radio2text:SetPoint("BOTTOM", radio2, "TOP", 0, 5);
		
	--Healer
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Role_Healer", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontRedSmall");
			radio3:SetPoint("LEFT", radio2, "RIGHT", 18, 0);
			radio3:SetChecked(ConROCPaladinSpells.ConROC_SM_Role_Healer);
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Tank:SetChecked(false);
					ConROC_SM_Role_Healer:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCPaladinSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio3text:SetText("Heal");					
		local r3t = radio3.texture;

			if not r3t then
				r3t = radio3:CreateTexture('Spellmenu_radio3_Texture', 'ARTWORK');
				r3t:SetTexture('Interface\\AddOns\\ConROC\\images\\plus');
				r3t:SetBlendMode('BLEND');
				local color = ConROC.db.profile.raidbuffsOverlayColor;
				r3t:SetVertexColor(color.r, color.g, color.b);				
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("CENTER", radio3, "CENTER", 0, 0);
			radio3text:SetPoint("BOTTOM", radio3, "TOP", 0, 5);

	--PvP
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Role_PvP", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontRedSmall");
			radio4:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -10);
			radio4:SetChecked(ConROCPaladinSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Tank:SetChecked(false);
					ConROC_SM_Role_Healer:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCPaladinSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_Healer = ConROC_SM_Role_Healer:GetChecked();
					ConROCPaladinSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio4text:SetText("PvP");					
		local r4t = radio4.texture;

			if not r4t then
				r4t = radio4:CreateTexture('Spellmenu_radio4_Texture', 'ARTWORK');
				r4t:SetTexture('Interface\\AddOns\\ConROC\\images\\lightning-interrupt');
				r4t:SetBlendMode('BLEND');				
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);
			r4t:SetPoint("CENTER", radio4, "CENTER", 0, 0);
			radio4text:SetPoint("BOTTOM", radio4, "TOP", 0, 5);
			

		frame:Hide()
		lastFrame = frame;
	
	ConROC:RadioHeader1();
	ConROC:RadioHeader2();
	ConROC:RadioHeader3();
	ConROC:RadioHeader4();
	ConROC:CheckHeader1();
end

function ConROC:RadioHeader1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioHeader1", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_RadioHeader1", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Auras");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame1_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCRadioFrame1:Show();
					ConROC_RadioFrame1_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_RadioFrame1_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCRadioFrame1:Hide();
					ConROC_RadioFrame1_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:RadioFrame1();
end

function ConROC:RadioFrame1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioFrame1", ConROCRadioHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCRadioHeader1", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastAura = frame;
		lastFrame = frame;
		
	--Devotion Aura
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Aura_Devotion", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.Prot_Ability.DevotionAuraRank1);
			radio1:SetPoint("TOP", ConROCRadioFrame1, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Devotion);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Devotion);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Devotion);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Devotion);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Aura_Devotion:SetChecked(true);
					ConROC_SM_Aura_Retribution:SetChecked(false);
					ConROC_SM_Aura_Concentration:SetChecked(false);
					ConROC_SM_Aura_Sanctity:SetChecked(false);
					ConROC_SM_Aura_ShadowResistance:SetChecked(false);
					ConROC_SM_Aura_FrostResistance:SetChecked(false);
					ConROC_SM_Aura_FireResistance:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio1text:SetText(r1spellName);				
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('RadioFrame1_radio1_Texture', 'ARTWORK');
				r1t:SetTexture(r1tspell);
				r1t:SetBlendMode('BLEND');
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("LEFT", radio1, "RIGHT", 8, 0);
			radio1text:SetPoint('LEFT', r1t, 'RIGHT', 5, 0);
		
		lastAura = radio1;
		lastFrame = radio1;
		
	--Retribution Aura
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Aura_Retribution", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.Ret_Ability.RetributionAuraRank1);
			radio2:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Retribution);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Retribution);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Retribution);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Retribution);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Aura_Devotion:SetChecked(false);
					ConROC_SM_Aura_Retribution:SetChecked(true);
					ConROC_SM_Aura_Concentration:SetChecked(false);
					ConROC_SM_Aura_Sanctity:SetChecked(false);
					ConROC_SM_Aura_ShadowResistance:SetChecked(false);
					ConROC_SM_Aura_FrostResistance:SetChecked(false);
					ConROC_SM_Aura_FireResistance:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio2text:SetText(r2spellName);					
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('RadioFrame1_radio2_Texture', 'ARTWORK');
				r2t:SetTexture(r2tspell);
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("LEFT", radio2, "RIGHT", 8, 0);
			radio2text:SetPoint('LEFT', r2t, 'RIGHT', 5, 0);

		lastAura = radio2;
		lastFrame = radio2;
		
	--Concentration Aura
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Aura_Concentration", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontHighlightSmall");
		local r3spellName, _, r3tspell = GetSpellInfo(ids.Prot_Ability.ConcentrationAura);
			radio3:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Concentration);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Concentration);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Concentration);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Concentration);
			end
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_Aura_Devotion:SetChecked(false);
					ConROC_SM_Aura_Retribution:SetChecked(false);
					ConROC_SM_Aura_Concentration:SetChecked(true);
					ConROC_SM_Aura_Sanctity:SetChecked(false);
					ConROC_SM_Aura_ShadowResistance:SetChecked(false);
					ConROC_SM_Aura_FrostResistance:SetChecked(false);
					ConROC_SM_Aura_FireResistance:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio3text:SetText(r3spellName);					
		local r3t = radio3.texture;

			if not r3t then
				r3t = radio3:CreateTexture('RadioFrame1_radio3_Texture', 'ARTWORK');
				r3t:SetTexture(r3tspell);
				r3t:SetBlendMode('BLEND');
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastAura = radio3;
		lastFrame = radio3;
		
	--Sanctity Aura
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Aura_Sanctity", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontHighlightSmall");		
		local r4spellName, _, r4tspell = GetSpellInfo(ids.Ret_Ability.SanctityAura);
			radio4:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity);
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Aura_Devotion:SetChecked(false);
					ConROC_SM_Aura_Retribution:SetChecked(false);
					ConROC_SM_Aura_Concentration:SetChecked(false);
					ConROC_SM_Aura_Sanctity:SetChecked(true);
					ConROC_SM_Aura_ShadowResistance:SetChecked(false);
					ConROC_SM_Aura_FrostResistance:SetChecked(false);
					ConROC_SM_Aura_FireResistance:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio4text:SetText(r4spellName);					
		local r4t = radio4.texture;
			if not r4t then
				r4t = radio4:CreateTexture('RadioFrame1_radio4_Texture', 'ARTWORK');
				r4t:SetTexture(r4tspell);
				r4t:SetBlendMode('BLEND');
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);
			r4t:SetPoint("LEFT", radio4, "RIGHT", 8, 0);
			radio4text:SetPoint('LEFT', r4t, 'RIGHT', 5, 0);

		lastAura = radio4;		
		lastFrame = radio4;
		
	--Shadow Resistance Aura
		local radio5 = CreateFrame("CheckButton", "ConROC_SM_Aura_ShadowResistance", frame, "UIRadioButtonTemplate");
		local radio5text = frame:CreateFontString(radio5, "ARTWORK", "GameFontHighlightSmall");	
		local r5spellName, _, r5tspell = GetSpellInfo(ids.Prot_Ability.ShadowResistanceAuraRank1); 		
			radio5:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance);	
			end
			radio5:SetScript("OnClick", 
			  function()
					ConROC_SM_Aura_Devotion:SetChecked(false);
					ConROC_SM_Aura_Retribution:SetChecked(false);
					ConROC_SM_Aura_Concentration:SetChecked(false);
					ConROC_SM_Aura_Sanctity:SetChecked(false);
					ConROC_SM_Aura_ShadowResistance:SetChecked(true);
					ConROC_SM_Aura_FrostResistance:SetChecked(false);
					ConROC_SM_Aura_FireResistance:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio5text:SetText(r5spellName);					
		local r5t = radio5.texture;
			if not r5t then
				r5t = radio5:CreateTexture('RadioFrame1_radio5_Texture', 'ARTWORK');
				r5t:SetTexture(r5tspell);
				r5t:SetBlendMode('BLEND');
				radio5.texture = r5t;
			end			
			r5t:SetScale(0.2);
			r5t:SetPoint("LEFT", radio5, "RIGHT", 8, 0);
			radio5text:SetPoint('LEFT', r5t, 'RIGHT', 5, 0);

		lastAura = radio5;		
		lastFrame = radio5;			
		
	--Frost Resistance Aura
		local radio6 = CreateFrame("CheckButton", "ConROC_SM_Aura_FrostResistance", frame, "UIRadioButtonTemplate");
		local radio6text = frame:CreateFontString(radio6, "ARTWORK", "GameFontHighlightSmall");	
		local r6spellName, _, r6tspell = GetSpellInfo(ids.Prot_Ability.FrostResistanceAuraRank1); 		
			radio6:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance);
			end
			radio6:SetScript("OnClick", 
			  function()
					ConROC_SM_Aura_Devotion:SetChecked(false);
					ConROC_SM_Aura_Retribution:SetChecked(false);
					ConROC_SM_Aura_Concentration:SetChecked(false);
					ConROC_SM_Aura_Sanctity:SetChecked(false);
					ConROC_SM_Aura_ShadowResistance:SetChecked(false);
					ConROC_SM_Aura_FrostResistance:SetChecked(true);
					ConROC_SM_Aura_FireResistance:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio6text:SetText(r6spellName);					
		local r6t = radio6.texture;
			if not r6t then
				r6t = radio6:CreateTexture('RadioFrame1_radio6_Texture', 'ARTWORK');
				r6t:SetTexture(r6tspell);
				r6t:SetBlendMode('BLEND');
				radio6.texture = r6t;
			end			
			r6t:SetScale(0.2);
			r6t:SetPoint("LEFT", radio6, "RIGHT", 8, 0);
			radio6text:SetPoint('LEFT', r6t, 'RIGHT', 5, 0);

		lastAura = radio6;		
		lastFrame = radio6;		
		
	--Fire Resistance Aura
		local radio7 = CreateFrame("CheckButton", "ConROC_SM_Aura_FireResistance", frame, "UIRadioButtonTemplate");
		local radio7text = frame:CreateFontString(radio7, "ARTWORK", "GameFontHighlightSmall");	
		local r7spellName, _, r7tspell = GetSpellInfo(ids.Prot_Ability.FireResistanceAuraRank1); 		
			radio7:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio7:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio7:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio7:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio7:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance);
			end
			radio7:SetScript("OnClick", 
			  function()
					ConROC_SM_Aura_Devotion:SetChecked(false);
					ConROC_SM_Aura_Retribution:SetChecked(false);
					ConROC_SM_Aura_Concentration:SetChecked(false);
					ConROC_SM_Aura_Sanctity:SetChecked(false);
					ConROC_SM_Aura_ShadowResistance:SetChecked(false);
					ConROC_SM_Aura_FrostResistance:SetChecked(false);
					ConROC_SM_Aura_FireResistance:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Aura_Devotion = ConROC_SM_Aura_Devotion:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Retribution = ConROC_SM_Aura_Retribution:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Concentration = ConROC_SM_Aura_Concentration:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity = ConROC_SM_Aura_Sanctity:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance = ConROC_SM_Aura_ShadowResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance = ConROC_SM_Aura_FrostResistance:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance = ConROC_SM_Aura_FireResistance:GetChecked();
					end
				end
			);
			radio7text:SetText(r7spellName);					
		local r7t = radio7.texture;
			if not r7t then
				r7t = radio7:CreateTexture('RadioFrame1_radio7_Texture', 'ARTWORK');
				r7t:SetTexture(r7tspell);
				r7t:SetBlendMode('BLEND');
				radio7.texture = r7t;
			end			
			r7t:SetScale(0.2);
			r7t:SetPoint("LEFT", radio7, "RIGHT", 8, 0);
			radio7text:SetPoint('LEFT', r7t, 'RIGHT', 5, 0);

		lastAura = radio7;		
		lastFrame = radio7;
		
		frame:Show()
end

function ConROC:RadioHeader2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioHeader2", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_RadioHeader2", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Judgements");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame2_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCRadioFrame2:Show();
					ConROC_RadioFrame2_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_RadioFrame2_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCRadioFrame2:Hide();
					ConROC_RadioFrame2_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:RadioFrame2();
end

function ConROC:RadioFrame2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioFrame2", ConROCRadioHeader2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCRadioHeader2", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastAura = frame;
		lastFrame = frame;
		
	--Judgement of the Crusader
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Judgement_Crusader", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.Ret_Ability.SealoftheCrusaderRank1);
			radio1:SetPoint("TOP", ConROCRadioFrame2, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Crusader);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Crusader);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Crusader);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Crusader);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Judgement_Crusader:SetChecked(true);
					ConROC_SM_Judgement_Justice:SetChecked(false);
					ConROC_SM_Judgement_Light:SetChecked(false);
					ConROC_SM_Judgement_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					end
				end
			);
			radio1text:SetText(r1spellName);				
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('RadioFrame2_radio1_Texture', 'ARTWORK');
				r1t:SetTexture(r1tspell);
				r1t:SetBlendMode('BLEND');
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("LEFT", radio1, "RIGHT", 8, 0);
			radio1text:SetPoint('LEFT', r1t, 'RIGHT', 5, 0);
		
		lastAura = radio1;
		lastFrame = radio1;
		
	--Judgement of Justice
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Judgement_Justice", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.Prot_Ability.SealofJustice);
			radio2:SetPoint("TOP", lastJudge, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Justice);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Justice);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Justice);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Justice);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Judgement_Crusader:SetChecked(false);
					ConROC_SM_Judgement_Justice:SetChecked(true);
					ConROC_SM_Judgement_Light:SetChecked(false);
					ConROC_SM_Judgement_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					end
				end
			);
			radio2text:SetText(r2spellName);
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('RadioFrame2_radio2_Texture', 'ARTWORK');
				r2t:SetTexture(r2tspell);
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("LEFT", radio2, "RIGHT", 8, 0);
			radio2text:SetPoint('LEFT', r2t, 'RIGHT', 5, 0);

		lastJudge = radio2;
		lastFrame = radio2;
		
	--Judgement of Light
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Judgement_Light", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontHighlightSmall");
		local r3spellName, _, r3tspell = GetSpellInfo(ids.Holy_Ability.SealofLightRank1);
			radio3:SetPoint("TOP", lastJudge, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Light);
			end
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_Judgement_Crusader:SetChecked(false);
					ConROC_SM_Judgement_Justice:SetChecked(false);
					ConROC_SM_Judgement_Light:SetChecked(true);
					ConROC_SM_Judgement_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					end
				end
			);
			radio3text:SetText(r3spellName);					
		local r3t = radio3.texture;

			if not r3t then
				r3t = radio3:CreateTexture('RadioFrame2_radio3_Texture', 'ARTWORK');
				r3t:SetTexture(r3tspell);
				r3t:SetBlendMode('BLEND');
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastJudge = radio3;
		lastFrame = radio3;
		
	--Judgement of Wisdom
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Judgement_Wisdom", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontHighlightSmall");		
		local r4spellName, _, r4tspell = GetSpellInfo(ids.Holy_Ability.SealofWisdomRank1);
			radio4:SetPoint("TOP", lastJudge, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Wisdom);	
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Judgement_Crusader:SetChecked(false);
					ConROC_SM_Judgement_Justice:SetChecked(false);
					ConROC_SM_Judgement_Light:SetChecked(false);
					ConROC_SM_Judgement_Wisdom:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Judgement_Crusader = ConROC_SM_Judgement_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Justice = ConROC_SM_Judgement_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Light = ConROC_SM_Judgement_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Judgement_Wisdom = ConROC_SM_Judgement_Wisdom:GetChecked();
					end
				end
			);
			radio4text:SetText(r4spellName);					
		local r4t = radio4.texture;
			if not r4t then
				r4t = radio4:CreateTexture('RadioFrame2_radio4_Texture', 'ARTWORK');
				r4t:SetTexture(r4tspell);
				r4t:SetBlendMode('BLEND');
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);
			r4t:SetPoint("LEFT", radio4, "RIGHT", 8, 0);
			radio4text:SetPoint('LEFT', r4t, 'RIGHT', 5, 0);

		lastJudge = radio4;		
		lastFrame = radio4;
		
		frame:Show()
end

function ConROC:RadioHeader3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioHeader3", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_RadioHeader3", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Seals");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame3_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCRadioFrame3:Show();
					ConROC_RadioFrame3_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_RadioFrame3_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCRadioFrame3:Hide();
					ConROC_RadioFrame3_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:RadioFrame3();
end

function ConROC:RadioFrame3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioFrame3", ConROCRadioHeader3)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCRadioHeader3", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastSeal = frame;
		lastFrame = frame;
		
	--Seal of Righteousness
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Seal_Righteousness", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.Holy_Ability.SealofRighteousnessRank1);
			radio1:SetPoint("TOP", ConROCRadioFrame3, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness);
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Seal_Righteousness:SetChecked(true);
					ConROC_SM_Seal_Crusader:SetChecked(false);
					ConROC_SM_Seal_Command:SetChecked(false);
					ConROC_SM_Seal_Justice:SetChecked(false);
					ConROC_SM_Seal_Light:SetChecked(false);
					ConROC_SM_Seal_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					end
				end
			);
			radio1text:SetText(r1spellName);				
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('RadioFrame3_radio1_Texture', 'ARTWORK');
				r1t:SetTexture(r1tspell);
				r1t:SetBlendMode('BLEND');
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("LEFT", radio1, "RIGHT", 8, 0);
			radio1text:SetPoint('LEFT', r1t, 'RIGHT', 5, 0);
		
		lastSeal = radio1;
		lastFrame = radio1;
		
	--Seal of the Crusader
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Seal_Crusader", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.Ret_Ability.SealoftheCrusaderRank1);
			radio2:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Crusader);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Crusader);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Crusader);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Crusader);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Seal_Righteousness:SetChecked(false);
					ConROC_SM_Seal_Crusader:SetChecked(true);
					ConROC_SM_Seal_Command:SetChecked(false);
					ConROC_SM_Seal_Justice:SetChecked(false);
					ConROC_SM_Seal_Light:SetChecked(false);
					ConROC_SM_Seal_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					end
				end
			);
			radio2text:SetText(r2spellName);
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('RadioFrame3_radio2_Texture', 'ARTWORK');
				r2t:SetTexture(r2tspell);
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("LEFT", radio2, "RIGHT", 8, 0);
			radio2text:SetPoint('LEFT', r2t, 'RIGHT', 5, 0);

		lastSeal = radio2;
		lastFrame = radio2;		

	--Seal of Command
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Seal_Command", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontHighlightSmall");		
		local r3spellName, _, r3tspell = GetSpellInfo(ids.Ret_Ability.SealofCommandRank1);
			radio3:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Command);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Command);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Command);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Command);
			end
			radio3:SetScript("OnClick", 
				function()
					ConROC_SM_Seal_Righteousness:SetChecked(false);
					ConROC_SM_Seal_Crusader:SetChecked(false);
					ConROC_SM_Seal_Command:SetChecked(true);
					ConROC_SM_Seal_Justice:SetChecked(false);
					ConROC_SM_Seal_Light:SetChecked(false);
					ConROC_SM_Seal_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					end
				end
			);
			radio3text:SetText(r3spellName);
		local r3t = radio3.texture; 
			if not r3t then
				r3t = radio3:CreateTexture('RadioFrame3_radio3_Texture', 'ARTWORK');
				r3t:SetTexture(r3tspell);
				r3t:SetBlendMode('BLEND');
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastSeal = radio3;
		lastFrame = radio3;
		
	--Seal of Justice
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Seal_Justice", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontHighlightSmall");		
		local r4spellName, _, r4tspell = GetSpellInfo(ids.Prot_Ability.SealofJustice);
			radio4:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Justice);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Justice);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Justice);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Justice);
			end
			radio4:SetScript("OnClick", 
				function()
					ConROC_SM_Seal_Righteousness:SetChecked(false);
					ConROC_SM_Seal_Crusader:SetChecked(false);
					ConROC_SM_Seal_Command:SetChecked(false);
					ConROC_SM_Seal_Justice:SetChecked(true);
					ConROC_SM_Seal_Light:SetChecked(false);
					ConROC_SM_Seal_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					end
				end
			);
			radio4text:SetText(r4spellName);
		local r4t = radio4.texture; 
			if not r4t then
				r4t = radio4:CreateTexture('RadioFrame3_radio4_Texture', 'ARTWORK');
				r4t:SetTexture(r4tspell);
				r4t:SetBlendMode('BLEND');
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);
			r4t:SetPoint("LEFT", radio4, "RIGHT", 8, 0);
			radio4text:SetPoint('LEFT', r4t, 'RIGHT', 5, 0);

		lastSeal = radio4;
		lastFrame = radio4;
		
	--Seal of Light
		local radio5 = CreateFrame("CheckButton", "ConROC_SM_Seal_Light", frame, "UIRadioButtonTemplate");
		local radio5text = frame:CreateFontString(radio5, "ARTWORK", "GameFontHighlightSmall");
		local r5spellName, _, r5tspell = GetSpellInfo(ids.Holy_Ability.SealofLightRank1);
			radio5:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Light);
			end
			radio5:SetScript("OnClick", 
			  function()
					ConROC_SM_Seal_Righteousness:SetChecked(false);
					ConROC_SM_Seal_Crusader:SetChecked(false);
					ConROC_SM_Seal_Command:SetChecked(false);
					ConROC_SM_Seal_Justice:SetChecked(false);
					ConROC_SM_Seal_Light:SetChecked(true);
					ConROC_SM_Seal_Wisdom:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					end
				end
			);
			radio5text:SetText(r5spellName);					
		local r5t = radio5.texture;

			if not r5t then
				r5t = radio5:CreateTexture('RadioFrame3_radio5_Texture', 'ARTWORK');
				r5t:SetTexture(r5tspell);
				r5t:SetBlendMode('BLEND');
				radio5.texture = r5t;
			end			
			r5t:SetScale(0.2);
			r5t:SetPoint("LEFT", radio5, "RIGHT", 8, 0);
			radio5text:SetPoint('LEFT', r5t, 'RIGHT', 5, 0);

		lastSeal = radio5;
		lastFrame = radio5;
		
	--Seal of Wisdom
		local radio6 = CreateFrame("CheckButton", "ConROC_SM_Seal_Wisdom", frame, "UIRadioButtonTemplate");
		local radio6text = frame:CreateFontString(radio6, "ARTWORK", "GameFontHighlightSmall");		
		local r6spellName, _, r6tspell = GetSpellInfo(ids.Holy_Ability.SealofWisdomRank1);
			radio6:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom);
			end
			radio6:SetScript("OnClick", 
			  function()
					ConROC_SM_Seal_Righteousness:SetChecked(false);
					ConROC_SM_Seal_Crusader:SetChecked(false);
					ConROC_SM_Seal_Command:SetChecked(false);
					ConROC_SM_Seal_Justice:SetChecked(false);
					ConROC_SM_Seal_Light:SetChecked(false);
					ConROC_SM_Seal_Wisdom:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness = ConROC_SM_Seal_Righteousness:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Crusader = ConROC_SM_Seal_Crusader:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Command = ConROC_SM_Seal_Command:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Justice = ConROC_SM_Seal_Justice:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Light = ConROC_SM_Seal_Light:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom = ConROC_SM_Seal_Wisdom:GetChecked();
					end
				end
			);
			radio6text:SetText(r6spellName);					
		local r6t = radio6.texture;
			if not r6t then
				r6t = radio6:CreateTexture('RadioFrame3_radio6_Texture', 'ARTWORK');
				r6t:SetTexture(r6tspell);
				r6t:SetBlendMode('BLEND');
				radio6.texture = r6t;
			end			
			r6t:SetScale(0.2);
			r6t:SetPoint("LEFT", radio6, "RIGHT", 8, 0);
			radio6text:SetPoint('LEFT', r6t, 'RIGHT', 5, 0);

		lastSeal = radio6;		
		lastFrame = radio6;
		
		frame:Show()
end

function ConROC:RadioHeader4()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioHeader4", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_RadioHeader4", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Blessings");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame4_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCRadioFrame4:Show();
					ConROC_RadioFrame4_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_RadioFrame4_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCRadioFrame4:Hide();
					ConROC_RadioFrame4_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:RadioFrame4();
end

function ConROC:RadioFrame4()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioFrame4", ConROCRadioHeader4)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCRadioHeader4", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastBless = frame;
		lastFrame = frame;
		
	--Blessing of Might
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Bless_Might", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.Ret_Ability.BlessingofMightRank1);
			radio1:SetPoint("TOP", ConROCRadioFrame4, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Might);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Might);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Might);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Might);
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Bless_Might:SetChecked(true);
					ConROC_SM_Bless_Wisdom:SetChecked(false);
					ConROC_SM_Bless_Kings:SetChecked(false);
					ConROC_SM_Bless_Salvation:SetChecked(false);
					ConROC_SM_Bless_Sanctuary:SetChecked(false);
					ConROC_SM_Bless_Light:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					end
				end
			);
			radio1text:SetText(r1spellName);				
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('RadioFrame4_radio1_Texture', 'ARTWORK');
				r1t:SetTexture(r1tspell);
				r1t:SetBlendMode('BLEND');
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("LEFT", radio1, "RIGHT", 8, 0);
			radio1text:SetPoint('LEFT', r1t, 'RIGHT', 5, 0);
		
		lastBless = radio1;
		lastFrame = radio1;
		
	--Blessing of Wisdom
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Bless_Wisdom", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.Holy_Ability.BlessingofWisdomRank1);
			radio2:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Bless_Might:SetChecked(false);
					ConROC_SM_Bless_Wisdom:SetChecked(true);
					ConROC_SM_Bless_Kings:SetChecked(false);
					ConROC_SM_Bless_Salvation:SetChecked(false);
					ConROC_SM_Bless_Sanctuary:SetChecked(false);
					ConROC_SM_Bless_Light:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					end
				end
			);
			radio2text:SetText(r2spellName);
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('RadioFrame4_radio2_Texture', 'ARTWORK');
				r2t:SetTexture(r2tspell);
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("LEFT", radio2, "RIGHT", 8, 0);
			radio2text:SetPoint('LEFT', r2t, 'RIGHT', 5, 0);

		lastBless = radio2;
		lastFrame = radio2;		

	--Blessing of Kings
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Bless_Kings", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontHighlightSmall");		
		local r3spellName, _, r3tspell = GetSpellInfo(ids.Prot_Ability.BlessingofKings);
			radio3:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Kings);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Kings);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Kings);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Kings);
			end
			radio3:SetScript("OnClick", 
				function()
					ConROC_SM_Bless_Might:SetChecked(false);
					ConROC_SM_Bless_Wisdom:SetChecked(false);
					ConROC_SM_Bless_Kings:SetChecked(true);
					ConROC_SM_Bless_Salvation:SetChecked(false);
					ConROC_SM_Bless_Sanctuary:SetChecked(false);
					ConROC_SM_Bless_Light:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					end
				end
			);
			radio3text:SetText(r3spellName);
		local r3t = radio3.texture; 
			if not r3t then
				r3t = radio3:CreateTexture('RadioFrame4_radio3_Texture', 'ARTWORK');
				r3t:SetTexture(r3tspell);
				r3t:SetBlendMode('BLEND');
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastBless = radio3;
		lastFrame = radio3;
		
	--Blessing of Justice
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Bless_Salvation", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontHighlightSmall");		
		local r4spellName, _, r4tspell = GetSpellInfo(ids.Prot_Ability.BlessingofSalvation);
			radio4:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Salvation);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Salvation);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Salvation);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Salvation);
			end
			radio4:SetScript("OnClick", 
				function()
					ConROC_SM_Bless_Might:SetChecked(false);
					ConROC_SM_Bless_Wisdom:SetChecked(false);
					ConROC_SM_Bless_Kings:SetChecked(false);
					ConROC_SM_Bless_Salvation:SetChecked(true);
					ConROC_SM_Bless_Sanctuary:SetChecked(false);
					ConROC_SM_Bless_Light:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					end
				end
			);
			radio4text:SetText(r4spellName);
		local r4t = radio4.texture; 
			if not r4t then
				r4t = radio4:CreateTexture('RadioFrame4_radio4_Texture', 'ARTWORK');
				r4t:SetTexture(r4tspell);
				r4t:SetBlendMode('BLEND');
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);
			r4t:SetPoint("LEFT", radio4, "RIGHT", 8, 0);
			radio4text:SetPoint('LEFT', r4t, 'RIGHT', 5, 0);

		lastBless = radio4;
		lastFrame = radio4;
		
	--Blessing of Sanctuary
		local radio5 = CreateFrame("CheckButton", "ConROC_SM_Bless_Sanctuary", frame, "UIRadioButtonTemplate");
		local radio5text = frame:CreateFontString(radio5, "ARTWORK", "GameFontHighlightSmall");
		local r5spellName, _, r5tspell = GetSpellInfo(ids.Prot_Ability.BlessingofSanctuaryRank1);
			radio5:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio5:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary);
			end
			radio5:SetScript("OnClick", 
			  function()
					ConROC_SM_Bless_Might:SetChecked(false);
					ConROC_SM_Bless_Wisdom:SetChecked(false);
					ConROC_SM_Bless_Kings:SetChecked(false);
					ConROC_SM_Bless_Salvation:SetChecked(false);
					ConROC_SM_Bless_Sanctuary:SetChecked(true);
					ConROC_SM_Bless_Light:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					end
				end
			);
			radio5text:SetText(r5spellName);					
		local r5t = radio5.texture;

			if not r5t then
				r5t = radio5:CreateTexture('RadioFrame4_radio5_Texture', 'ARTWORK');
				r5t:SetTexture(r5tspell);
				r5t:SetBlendMode('BLEND');
				radio5.texture = r5t;
			end			
			r5t:SetScale(0.2);
			r5t:SetPoint("LEFT", radio5, "RIGHT", 8, 0);
			radio5text:SetPoint('LEFT', r5t, 'RIGHT', 5, 0);

		lastBless = radio5;
		lastFrame = radio5;
		
	--Blessing of Light
		local radio6 = CreateFrame("CheckButton", "ConROC_SM_Bless_Light", frame, "UIRadioButtonTemplate");
		local radio6text = frame:CreateFontString(radio6, "ARTWORK", "GameFontHighlightSmall");		
		local r6spellName, _, r6tspell = GetSpellInfo(ids.Holy_Ability.BlessingofLightRank1);
			radio6:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Light);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio6:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Light);
			end
			radio6:SetScript("OnClick", 
			  function()
					ConROC_SM_Bless_Might:SetChecked(false);
					ConROC_SM_Bless_Light:SetChecked(false);
					ConROC_SM_Bless_Kings:SetChecked(false);
					ConROC_SM_Bless_Salvation:SetChecked(false);
					ConROC_SM_Bless_Sanctuary:SetChecked(false);
					ConROC_SM_Bless_Light:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Tank_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Melee_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_Healer_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Bless_Might = ConROC_SM_Bless_Might:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom = ConROC_SM_Bless_Wisdom:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Kings = ConROC_SM_Bless_Kings:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Salvation = ConROC_SM_Bless_Salvation:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary = ConROC_SM_Bless_Sanctuary:GetChecked();
						ConROCPaladinSpells.ConROC_PvP_Bless_Light = ConROC_SM_Bless_Light:GetChecked();
					end
				end
			);
			radio6text:SetText(r6spellName);					
		local r6t = radio6.texture;
			if not r6t then
				r6t = radio6:CreateTexture('RadioFrame4_radio6_Texture', 'ARTWORK');
				r6t:SetTexture(r6tspell);
				r6t:SetBlendMode('BLEND');
				radio6.texture = r6t;
			end			
			r6t:SetScale(0.2);
			r6t:SetPoint("LEFT", radio6, "RIGHT", 8, 0);
			radio6text:SetPoint('LEFT', r6t, 'RIGHT', 5, 0);

		lastBless = radio6;		
		lastFrame = radio6;
		
		frame:Show()
end

function ConROC:CheckHeader1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader1", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_CheckHeader1", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Stuns");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame1_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame1:Show();
					ConROC_CheckFrame1_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame1_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame1:Hide();
					ConROC_CheckFrame1_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame1();
end

function ConROC:CheckFrame1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame1", ConROCCheckHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader1", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastStun = frame;
		lastFrame = frame;
		
	--Hammer of Justice
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Prot_Ability.HammerofJusticeRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Stun_HammerofJustice", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(check1, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check1:SetChecked(ConROCPaladinSpells.ConROC_Tank_Stun_HammerofJustice);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCPaladinSpells.ConROC_Melee_Stun_HammerofJustice);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				check1:SetChecked(ConROCPaladinSpells.ConROC_Healer_Stun_HammerofJustice);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCPaladinSpells.ConROC_PvP_Stun_HammerofJustice);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCPaladinSpells.ConROC_Tank_Stun_HammerofJustice = ConROC_SM_Stun_HammerofJustice:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCPaladinSpells.ConROC_Melee_Stun_HammerofJustice = ConROC_SM_Stun_HammerofJustice:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCPaladinSpells.ConROC_Healer_Stun_HammerofJustice = ConROC_SM_Stun_HammerofJustice:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCPaladinSpells.ConROC_PvP_Stun_HammerofJustice = ConROC_SM_Stun_HammerofJustice:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);				
		local c1t = check1.texture;
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame1_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastStun = check1;
		lastFrame = check1;

		frame:Show()
end
		
function ConROC:SpellMenuUpdate()
	lastFrame = ConROCSpellmenuClass;
	
	if ConROCRadioHeader1 ~= nil then
		lastAura = ConROCRadioFrame1;
		
	--Auras
		if plvl >= 1 then 
			ConROC_SM_Aura_Devotion:Show();
			lastAura = ConROC_SM_Aura_Devotion;
		else
			ConROC_SM_Aura_Devotion:Hide();
		end

		if plvl >= 16 then 
			ConROC_SM_Aura_Retribution:Show(); 
			ConROC_SM_Aura_Retribution:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			lastAura = ConROC_SM_Aura_Retribution;
		else
			ConROC_SM_Aura_Retribution:Hide();
		end
		
		if plvl >= 22 and IsSpellKnown(ids.Prot_Ability.ConcentrationAura) then 
			ConROC_SM_Aura_Concentration:Show(); 
			ConROC_SM_Aura_Concentration:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			lastAura = ConROC_SM_Aura_Concentration;
		else
			ConROC_SM_Aura_Concentration:Hide();
		end		
		
		if ConROC:TalentChosen(ids.Spec.Retribution, ids.Ret_Talent.SanctityAura) then
			ConROC_SM_Aura_Sanctity:Show(); 
			ConROC_SM_Aura_Sanctity:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			lastAura = ConROC_SM_Aura_Sanctity;
		else
			ConROC_SM_Aura_Sanctity:Hide();
		end

		if plvl >= 28 then 
			ConROC_SM_Aura_ShadowResistance:Show(); 
			ConROC_SM_Aura_ShadowResistance:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			lastAura = ConROC_SM_Aura_ShadowResistance;
		else
			ConROC_SM_Aura_ShadowResistance:Hide();
		end

		if plvl >= 32 then 
			ConROC_SM_Aura_FrostResistance:Show(); 
			ConROC_SM_Aura_FrostResistance:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			lastAura = ConROC_SM_Aura_FrostResistance;
		else
			ConROC_SM_Aura_FrostResistance:Hide();
		end
		
		if plvl >= 36 then 
			ConROC_SM_Aura_FireResistance:Show(); 
			ConROC_SM_Aura_FireResistance:SetPoint("TOP", lastAura, "BOTTOM", 0, 0);
			lastAura = ConROC_SM_Aura_FireResistance;
		else
			ConROC_SM_Aura_FireResistance:Hide();
		end		
		
		if ConROCRadioFrame1:IsVisible() then
			lastFrame = lastAura;
		else
			lastFrame = ConROCRadioHeader1;
		end
	end

	if ConROCRadioHeader2 ~= nil then
		if lastFrame == lastAura then
			ConROCRadioHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCRadioHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end

		lastJudge = ConROCRadioFrame2;
		
	--Judgements
		if plvl >= 6 and IsSpellKnown(ids.Ret_Ability.SealoftheCrusaderRank1) then 
			ConROC_SM_Judgement_Crusader:Show();
			lastJudge = ConROC_SM_Judgement_Crusader;
		else
			ConROC_SM_Judgement_Crusader:Hide();
		end

		if plvl >= 22 and IsSpellKnown(ids.Prot_Ability.SealofJustice) then 
			ConROC_SM_Judgement_Justice:Show(); 
			ConROC_SM_Judgement_Justice:SetPoint("TOP", lastJudge, "BOTTOM", 0, 0);
			lastJudge = ConROC_SM_Judgement_Justice;
		else
			ConROC_SM_Judgement_Justice:Hide();
		end
		
		if plvl >= 30 and IsSpellKnown(ids.Holy_Ability.SealofLightRank1) then 
			ConROC_SM_Judgement_Light:Show(); 
			ConROC_SM_Judgement_Light:SetPoint("TOP", lastJudge, "BOTTOM", 0, 0);
			lastJudge = ConROC_SM_Judgement_Light;
		else
			ConROC_SM_Judgement_Light:Hide();
		end		
		
		if plvl >= 38 and IsSpellKnown(ids.Holy_Ability.SealofWisdomRank1) then
			ConROC_SM_Judgement_Wisdom:Show(); 
			ConROC_SM_Judgement_Wisdom:SetPoint("TOP", lastJudge, "BOTTOM", 0, 0);
			lastJudge = ConROC_SM_Judgement_Wisdom;
		else
			ConROC_SM_Judgement_Wisdom:Hide();
		end
		
		if ConROCRadioFrame2:IsVisible() then
			lastFrame = lastJudge;
		else
			lastFrame = ConROCRadioHeader2;
		end
	end
	
	if ConROCRadioHeader3 ~= nil then
		if lastFrame == lastJudge or lastFrame == lastAura then
			ConROCRadioHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCRadioHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end
	
		lastSeal = ConROCRadioFrame3;
		
	--Seals
		if plvl >= 1 then 
			ConROC_SM_Seal_Righteousness:Show();
			lastSeal = ConROC_SM_Seal_Righteousness;
		else
			ConROC_SM_Seal_Righteousness:Hide();
		end	
	
		if plvl >= 6 and IsSpellKnown(ids.Ret_Ability.SealoftheCrusaderRank1) then 
			ConROC_SM_Seal_Crusader:Show();
			ConROC_SM_Seal_Crusader:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			lastSeal = ConROC_SM_Seal_Crusader;
		else
			ConROC_SM_Seal_Crusader:Hide();
		end
		
		if plvl >= 20 and IsSpellKnown(ids.Ret_Ability.SealofCommandRank1) then 
			ConROC_SM_Seal_Command:Show();
			ConROC_SM_Seal_Command:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			lastSeal = ConROC_SM_Seal_Command;
		else
			ConROC_SM_Seal_Command:Hide();
		end		

		if plvl >= 22 and IsSpellKnown(ids.Prot_Ability.SealofJustice) then 
			ConROC_SM_Seal_Justice:Show(); 
			ConROC_SM_Seal_Justice:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			lastSeal = ConROC_SM_Seal_Justice;
		else
			ConROC_SM_Seal_Justice:Hide();
		end
		
		if plvl >= 30 and IsSpellKnown(ids.Holy_Ability.SealofLightRank1) then 
			ConROC_SM_Seal_Light:Show(); 
			ConROC_SM_Seal_Light:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			lastSeal = ConROC_SM_Seal_Light;
		else
			ConROC_SM_Seal_Light:Hide();
		end		
		
		if plvl >= 38 and IsSpellKnown(ids.Holy_Ability.SealofWisdomRank1) then
			ConROC_SM_Seal_Wisdom:Show(); 
			ConROC_SM_Seal_Wisdom:SetPoint("TOP", lastSeal, "BOTTOM", 0, 0);
			lastSeal = ConROC_SM_Seal_Wisdom;
		else
			ConROC_SM_Seal_Wisdom:Hide();
		end
		
		if ConROCRadioFrame3:IsVisible() then
			lastFrame = lastSeal;
		else
			lastFrame = ConROCRadioHeader3;
		end
	end
	
	if ConROCRadioHeader4 ~= nil then
		if lastFrame == lastSeal or lastFrame == lastJudge or lastFrame == lastAura then
			ConROCRadioHeader4:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCRadioHeader4:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end
	
		lastBless = ConROCRadioFrame4;
		
	--Blessings
		if plvl >= 4 and IsSpellKnown(ids.Ret_Ability.BlessingofMightRank1) then 
			ConROC_SM_Bless_Might:Show();
			lastBless = ConROC_SM_Bless_Might;
		else
			ConROC_SM_Bless_Might:Hide();
		end	
	
		if plvl >= 14 and IsSpellKnown(ids.Holy_Ability.BlessingofWisdomRank1) then 
			ConROC_SM_Bless_Wisdom:Show();
			ConROC_SM_Bless_Wisdom:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			lastBless = ConROC_SM_Bless_Wisdom;
		else
			ConROC_SM_Bless_Wisdom:Hide();
		end
		
		if plvl >= 20 and IsSpellKnown(ids.Prot_Ability.BlessingofKings) then 
			ConROC_SM_Bless_Kings:Show();
			ConROC_SM_Bless_Kings:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			lastBless = ConROC_SM_Bless_Kings;
		else
			ConROC_SM_Bless_Kings:Hide();
		end		

		if plvl >= 26 and IsSpellKnown(ids.Prot_Ability.BlessingofSalvation) then 
			ConROC_SM_Bless_Salvation:Show(); 
			ConROC_SM_Bless_Salvation:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			lastBless = ConROC_SM_Bless_Salvation;
		else
			ConROC_SM_Bless_Salvation:Hide();
		end
		
		if plvl >= 30 and IsSpellKnown(ids.Prot_Ability.BlessingofSanctuaryRank1) then 
			ConROC_SM_Bless_Sanctuary:Show(); 
			ConROC_SM_Bless_Sanctuary:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			lastBless = ConROC_SM_Bless_Sanctuary;
		else
			ConROC_SM_Bless_Sanctuary:Hide();
		end		
		
		if plvl >= 40 and IsSpellKnown(ids.Holy_Ability.BlessingofLightRank1) then
			ConROC_SM_Bless_Light:Show(); 
			ConROC_SM_Bless_Light:SetPoint("TOP", lastBless, "BOTTOM", 0, 0);
			lastBless = ConROC_SM_Bless_Light;
		else
			ConROC_SM_Bless_Light:Hide();
		end
		
		if ConROCRadioFrame4:IsVisible() then
			lastFrame = lastBless;
		else
			lastFrame = ConROCRadioHeader4;
		end
	end
	
	if ConROCCheckFrame1 ~= nil then
		if lastFrame == lastBless or lastFrame == lastSeal or lastFrame == lastJudge or lastFrame == lastAura then
			ConROCCheckHeader1:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader1:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastStun = ConROCCheckFrame1;
		
	--Stuns
		if plvl >= 8 then 
			ConROC_SM_Stun_HammerofJustice:Show();
			lastStun = ConROC_SM_Stun_HammerofJustice;
		else
			ConROC_SM_Stun_HammerofJustice:Hide();
		end	

		if ConROCCheckFrame1:IsVisible() then
			lastFrame = lastStun;
		else
			lastFrame = ConROCCheckHeader1;
		end		
	end
end

function ConROC:RoleProfile()
	if ConROC:CheckBox(ConROC_SM_Role_Tank) then
		ConROC_SM_Aura_Devotion:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Devotion);
		ConROC_SM_Aura_Retribution:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Retribution);
		ConROC_SM_Aura_Concentration:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Concentration);
		ConROC_SM_Aura_Sanctity:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_Sanctity);
		ConROC_SM_Aura_ShadowResistance:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_ShadowResistance);
		ConROC_SM_Aura_FrostResistance:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_FrostResistance);
		ConROC_SM_Aura_FireResistance:SetChecked(ConROCPaladinSpells.ConROC_Tank_Aura_FireResistance);
		
		ConROC_SM_Judgement_Crusader:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Crusader);
		ConROC_SM_Judgement_Justice:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Justice);
		ConROC_SM_Judgement_Light:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Light);
		ConROC_SM_Judgement_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Tank_Judgement_Wisdom);
						
		ConROC_SM_Seal_Righteousness:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Righteousness);
		ConROC_SM_Seal_Crusader:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Crusader);
		ConROC_SM_Seal_Command:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Command);
		ConROC_SM_Seal_Justice:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Justice);
		ConROC_SM_Seal_Light:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Light);
		ConROC_SM_Seal_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Tank_Seal_Wisdom);
						
		ConROC_SM_Bless_Might:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Might);
		ConROC_SM_Bless_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Wisdom);
		ConROC_SM_Bless_Kings:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Kings);
		ConROC_SM_Bless_Salvation:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Salvation);
		ConROC_SM_Bless_Sanctuary:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Sanctuary);
		ConROC_SM_Bless_Light:SetChecked(ConROCPaladinSpells.ConROC_Tank_Bless_Light);
						
		ConROC_SM_Stun_HammerofJustice:SetChecked(ConROCPaladinSpells.ConROC_Tank_Stun_HammerofJustice);

	elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
		ConROC_SM_Aura_Devotion:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Devotion);
		ConROC_SM_Aura_Retribution:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Retribution);
		ConROC_SM_Aura_Concentration:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Concentration);
		ConROC_SM_Aura_Sanctity:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_Sanctity);
		ConROC_SM_Aura_ShadowResistance:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_ShadowResistance);
		ConROC_SM_Aura_FrostResistance:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_FrostResistance);
		ConROC_SM_Aura_FireResistance:SetChecked(ConROCPaladinSpells.ConROC_Melee_Aura_FireResistance);
		
		ConROC_SM_Judgement_Crusader:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Crusader);
		ConROC_SM_Judgement_Justice:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Justice);
		ConROC_SM_Judgement_Light:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Light);
		ConROC_SM_Judgement_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Melee_Judgement_Wisdom);
		
		ConROC_SM_Seal_Righteousness:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Righteousness);
		ConROC_SM_Seal_Crusader:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Crusader);
		ConROC_SM_Seal_Command:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Command);
		ConROC_SM_Seal_Justice:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Justice);
		ConROC_SM_Seal_Light:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Light);
		ConROC_SM_Seal_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Melee_Seal_Wisdom);
		
		ConROC_SM_Bless_Might:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Might);
		ConROC_SM_Bless_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Wisdom);
		ConROC_SM_Bless_Kings:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Kings);
		ConROC_SM_Bless_Salvation:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Salvation);
		ConROC_SM_Bless_Sanctuary:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Sanctuary);
		ConROC_SM_Bless_Light:SetChecked(ConROCPaladinSpells.ConROC_Melee_Bless_Light);
		
		ConROC_SM_Stun_HammerofJustice:SetChecked(ConROCPaladinSpells.ConROC_Melee_Stun_HammerofJustice);
		
	elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
		ConROC_SM_Aura_Devotion:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Devotion);
		ConROC_SM_Aura_Retribution:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Retribution);
		ConROC_SM_Aura_Concentration:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Concentration);
		ConROC_SM_Aura_Sanctity:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_Sanctity);
		ConROC_SM_Aura_ShadowResistance:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_ShadowResistance);
		ConROC_SM_Aura_FrostResistance:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_FrostResistance);
		ConROC_SM_Aura_FireResistance:SetChecked(ConROCPaladinSpells.ConROC_Healer_Aura_FireResistance);
		
		ConROC_SM_Judgement_Crusader:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Crusader);
		ConROC_SM_Judgement_Justice:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Justice);
		ConROC_SM_Judgement_Light:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Light);
		ConROC_SM_Judgement_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Healer_Judgement_Wisdom);
		
		ConROC_SM_Seal_Righteousness:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Righteousness);
		ConROC_SM_Seal_Crusader:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Crusader);
		ConROC_SM_Seal_Command:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Command);
		ConROC_SM_Seal_Justice:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Justice);
		ConROC_SM_Seal_Light:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Light);
		ConROC_SM_Seal_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Healer_Seal_Wisdom);
		
		ConROC_SM_Bless_Might:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Might);
		ConROC_SM_Bless_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Wisdom);
		ConROC_SM_Bless_Kings:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Kings);
		ConROC_SM_Bless_Salvation:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Salvation);
		ConROC_SM_Bless_Sanctuary:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Sanctuary);
		ConROC_SM_Bless_Light:SetChecked(ConROCPaladinSpells.ConROC_Healer_Bless_Light);
		
		ConROC_SM_Stun_HammerofJustice:SetChecked(ConROCPaladinSpells.ConROC_Healer_Stun_HammerofJustice);
		
	elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
		ConROC_SM_Aura_Devotion:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Devotion);
		ConROC_SM_Aura_Retribution:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Retribution);
		ConROC_SM_Aura_Concentration:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Concentration);
		ConROC_SM_Aura_Sanctity:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_Sanctity);
		ConROC_SM_Aura_ShadowResistance:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_ShadowResistance);
		ConROC_SM_Aura_FrostResistance:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_FrostResistance);
		ConROC_SM_Aura_FireResistance:SetChecked(ConROCPaladinSpells.ConROC_PvP_Aura_FireResistance);
		
		ConROC_SM_Judgement_Crusader:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Crusader);
		ConROC_SM_Judgement_Justice:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Justice);
		ConROC_SM_Judgement_Light:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Light);
		ConROC_SM_Judgement_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_PvP_Judgement_Wisdom);
		
		ConROC_SM_Seal_Righteousness:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Righteousness);
		ConROC_SM_Seal_Crusader:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Crusader);
		ConROC_SM_Seal_Command:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Command);
		ConROC_SM_Seal_Justice:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Justice);
		ConROC_SM_Seal_Light:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Light);
		ConROC_SM_Seal_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_PvP_Seal_Wisdom);
		
		ConROC_SM_Bless_Might:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Might);
		ConROC_SM_Bless_Wisdom:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Wisdom);
		ConROC_SM_Bless_Kings:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Kings);
		ConROC_SM_Bless_Salvation:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Salvation);
		ConROC_SM_Bless_Sanctuary:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Sanctuary);
		ConROC_SM_Bless_Light:SetChecked(ConROCPaladinSpells.ConROC_PvP_Bless_Light);
		
		ConROC_SM_Stun_HammerofJustice:SetChecked(ConROCPaladinSpells.ConROC_PvP_Stun_HammerofJustice);
		
	end
end