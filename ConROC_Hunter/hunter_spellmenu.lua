local ConROC_Hunter, ids = ...;

local lastFrame = 0;
local lastSting = 0;
local lastAbility = 0;
local lastStun = 0;

local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Ranged"] = true,

	["ConROC_Ranged_Sting_Serpent"] = true,
	["ConROC_Ranged_Ability_HuntersMark"] = true,
	["ConROC_Ranged_Ability_RapidFire"] = true,
	["ConROC_Ranged_Ability_BestialWrath"] = true,
}


ConROCHunterSpells = ConROCHunterSpells or defaults;

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
		
	--Ranged
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Role_Ranged", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontRedSmall");
			radio1:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -10);
			radio1:SetChecked(ConROCHunterSpells.ConROC_SM_Role_Ranged);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Ranged:SetChecked(true);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCHunterSpells.ConROC_SM_Role_Ranged = ConROC_SM_Role_Ranged:GetChecked();
					ConROCHunterSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCHunterSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio1text:SetText("Ranged");				
			radio1text:SetPoint("BOTTOM", radio1, "TOP", 0, 3);
		
	--Melee
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Role_Melee", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontRedSmall");		
			radio2:SetPoint("LEFT", radio1, "RIGHT", 25, 0);
			radio2:SetChecked(ConROCHunterSpells.ConROC_SM_Role_Melee);
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Role_Ranged:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCHunterSpells.ConROC_SM_Role_Ranged = ConROC_SM_Role_Ranged:GetChecked();
					ConROCHunterSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCHunterSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio2text:SetText("Melee");					
			radio2text:SetPoint("BOTTOM", radio2, "TOP", 0, 3);
		
	--PvP
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Role_PvP", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontRedSmall");
			radio4:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -10);
			radio4:SetChecked(ConROCHunterSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Ranged:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCHunterSpells.ConROC_SM_Role_Ranged = ConROC_SM_Role_Ranged:GetChecked();
					ConROCHunterSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCHunterSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio4text:SetText("PvP");					
			radio4text:SetPoint("BOTTOM", radio4, "TOP", 0, 3);
			

		frame:Hide()
		lastFrame = frame;
	
	ConROC:RadioHeader1();
	ConROC:CheckHeader1();
	ConROC:CheckHeader3();
	ConROC:CheckHeader2();	
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

		local fontStings = frame:CreateFontString("ConROC_Spellmenu_RadioHeader1", "ARTWORK", "GameFontGreenSmall");
			fontStings:SetText("Stings");
			fontStings:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame1_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontStings, "RIGHT", 0, 0)
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
				tbutton:SetPoint("LEFT", fontStings, "RIGHT", 0, 0)
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

		lastSting = frame;
		lastFrame = frame;
		
	--Serpent Sting
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Sting_Serpent", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.MM_Ability.SerpentStingRank1);
			radio1:SetPoint("TOP", ConROCRadioFrame1, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				radio1:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_Serpent);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_Serpent);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_Serpent);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Sting_Serpent:SetChecked(true);
					ConROC_SM_Sting_Scorpid:SetChecked(false);
					ConROC_SM_Sting_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_Ranged_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_Ranged_Sting_None = ConROC_SM_Sting_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_Melee_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_Melee_Sting_None = ConROC_SM_Sting_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_PvP_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_PvP_Sting_None = ConROC_SM_Sting_None:GetChecked();
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
		
		lastSting = radio1;
		lastFrame = radio1;
		
	--Scorpid Sting
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Sting_Scorpid", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.MM_Ability.ScorpidStingRank1);
			radio2:SetPoint("TOP", lastSting, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				radio2:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_Scorpid);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_Scorpid);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_Scorpid);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Sting_Serpent:SetChecked(false);
					ConROC_SM_Sting_Scorpid:SetChecked(true);
					ConROC_SM_Sting_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_Ranged_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_Ranged_Sting_None = ConROC_SM_Sting_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_Melee_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_Melee_Sting_None = ConROC_SM_Sting_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_PvP_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_PvP_Sting_None = ConROC_SM_Sting_None:GetChecked();
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

		lastSting = radio2;
		lastFrame = radio2;

	--None
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Sting_None", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontHighlightSmall");		
			radio4:SetPoint("TOP", lastSting, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				radio4:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_None);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_None);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				radio4:SetChecked(ConROCHunterSpells.ConROC_Healer_Sting_None);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_None);
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Sting_Serpent:SetChecked(false);
					ConROC_SM_Sting_Scorpid:SetChecked(false);
					ConROC_SM_Sting_None:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_Ranged_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_Ranged_Sting_None = ConROC_SM_Sting_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_Melee_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_Melee_Sting_None = ConROC_SM_Sting_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Sting_Serpent = ConROC_SM_Sting_Serpent:GetChecked();
						ConROCHunterSpells.ConROC_PvP_Sting_Scorpid = ConROC_SM_Sting_Scorpid:GetChecked();
						ConROCHunterSpells.ConROC_PvP_Sting_None = ConROC_SM_Sting_None:GetChecked();
					end
				end
			);
			radio4text:SetText("None");
			radio4text:SetPoint('LEFT', radio4, 'RIGHT', 20, 0);

		lastSting = radio4;		
		lastFrame = radio4;
		
	--Viper Sting
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Sting_Viper", frame, "UICheckButtonTemplate");
		local radio3text = frame:CreateFontString(radio3, "ARTWORK", "GameFontHighlightSmall");
		local r3spellName, _, r3tspell = GetSpellInfo(ids.MM_Ability.ViperStingRank1);
			radio3:SetPoint("TOP", lastSting, "BOTTOM", 0, 0);
			radio3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				radio3:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_Viper);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_Viper);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_Viper);
			end
			radio3:SetScript("OnClick", 
			  function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Sting_Viper = ConROC_SM_Sting_Viper:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Sting_Viper = ConROC_SM_Sting_Viper:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Sting_Viper = ConROC_SM_Sting_Viper:GetChecked();
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
			r3t:SetScale(0.4);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastSting = radio3;
		lastFrame = radio3;

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

		local fontStings = frame:CreateFontString("ConROC_Spellmenu_CheckHeader1", "ARTWORK", "GameFontGreenSmall");
			fontStings:SetText("Abilities");
			fontStings:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame1_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontStings, "RIGHT", 0, 0)
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
				tbutton:SetPoint("LEFT", fontStings, "RIGHT", 0, 0)
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

		lastAbility = frame;
		lastFrame = frame;
		
	--Hunters Mark
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.MM_Ability.HuntersMarkRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Ability_HuntersMark", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(check1, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check1:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_HuntersMark);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_HuntersMark);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_HuntersMark);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Ability_HuntersMark = ConROC_SM_Ability_HuntersMark:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Ability_HuntersMark = ConROC_SM_Ability_HuntersMark:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Ability_HuntersMark = ConROC_SM_Ability_HuntersMark:GetChecked();
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
			
		lastAbility = check1;
		lastFrame = check1;
		
	--Multi Shot
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.MM_Ability.MultiShotRank1); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Ability_MultiShot", frame, "UICheckButtonTemplate");
		local check2text = frame:CreateFontString(check2, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check2:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_MultiShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_MultiShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_MultiShot);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Ability_MultiShot = ConROC_SM_Ability_MultiShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Ability_MultiShot = ConROC_SM_Ability_MultiShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Ability_MultiShot = ConROC_SM_Ability_MultiShot:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);				
		local c2t = check2.texture;
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame1_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastAbility = check2;
		lastFrame = check2;
		
	--Aimed Shot
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.MM_Ability.AimedShotRank1); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Ability_AimedShot", frame, "UICheckButtonTemplate");
		local check3text = frame:CreateFontString(check3, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check3:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_AimedShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_AimedShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_AimedShot);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Ability_AimedShot = ConROC_SM_Ability_AimedShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Ability_AimedShot = ConROC_SM_Ability_AimedShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Ability_AimedShot = ConROC_SM_Ability_AimedShot:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);				
		local c3t = check3.texture;
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame1_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastAbility = check3;
		lastFrame = check3;
		
	--Rapid Fire
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.MM_Ability.RapidFire); 
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Ability_RapidFire", frame, "UICheckButtonTemplate");
		local check4text = frame:CreateFontString(check4, "ARTWORK", "GameFontHighlightSmall");		
			check4:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			check4:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check4:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_RapidFire);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check4:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_RapidFire);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check4:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_RapidFire);
			end
			check4:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Ability_RapidFire = ConROC_SM_Ability_RapidFire:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Ability_RapidFire = ConROC_SM_Ability_RapidFire:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Ability_RapidFire = ConROC_SM_Ability_RapidFire:GetChecked();
					end
				end);
			check4text:SetText(c4tspellName);				
		local c4t = check4.texture;
			if not c4t then
				c4t = check4:CreateTexture('CheckFrame1_check4_Texture', 'ARTWORK');
				c4t:SetTexture(c4tspell);
				c4t:SetBlendMode('BLEND');
				check4.texture = c4t;
			end			
			c4t:SetScale(0.4);
			c4t:SetPoint("LEFT", check4, "RIGHT", 8, 0);
			check4text:SetPoint('LEFT', c4t, 'RIGHT', 5, 0);
			
		lastAbility = check4;
		lastFrame = check4;

	--Bestial Wrath
		local c5tspellName, _, c5tspell = GetSpellInfo(ids.BM_Ability.BestialWrath); 
		local check5 = CreateFrame("CheckButton", "ConROC_SM_Ability_BestialWrath", frame, "UICheckButtonTemplate");
		local check5text = frame:CreateFontString(check5, "ARTWORK", "GameFontHighlightSmall");		
			check5:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			check5:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check5:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_BestialWrath);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check5:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_BestialWrath);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check5:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_BestialWrath);
			end
			check5:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Ability_BestialWrath = ConROC_SM_Ability_BestialWrath:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Ability_BestialWrath = ConROC_SM_Ability_BestialWrath:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Ability_BestialWrath = ConROC_SM_Ability_BestialWrath:GetChecked();
					end
				end);
			check5text:SetText(c5tspellName);				
		local c5t = check5.texture;
			if not c5t then
				c5t = check5:CreateTexture('CheckFrame1_check5_Texture', 'ARTWORK');
				c5t:SetTexture(c5tspell);
				c5t:SetBlendMode('BLEND');
				check5.texture = c5t;
			end			
			c5t:SetScale(0.4);
			c5t:SetPoint("LEFT", check5, "RIGHT", 8, 0);
			check5text:SetPoint('LEFT', c5t, 'RIGHT', 5, 0);
			
		lastAbility = check5;
		lastFrame = check5;
		
		frame:Show()
end

function ConROC:CheckHeader3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader3", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontStings = frame:CreateFontString("ConROC_Spellmenu_CheckHeader3", "ARTWORK", "GameFontGreenSmall");
			fontStings:SetText("Stuns and Slows");
			fontStings:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame3_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontStings, "RIGHT", 0, 0)
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
					ConROCCheckFrame3:Show();
					ConROC_CheckFrame3_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame3_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontStings, "RIGHT", 0, 0)
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
					ConROCCheckFrame3:Hide();
					ConROC_CheckFrame3_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame3();
end

function ConROC:CheckFrame3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame3", ConROCCheckHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader3", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastStun = frame;
		lastFrame = frame;
		
	--Concussive Shot
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.MM_Ability.ConcussiveShot); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Stun_ConcussiveShot", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(check1, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame3, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check1:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_ConcussiveShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_ConcussiveShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
				check1:SetChecked(ConROCHunterSpells.ConROC_Healer_Stun_ConcussiveShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_ConcussiveShot);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Stun_ConcussiveShot = ConROC_SM_Stun_ConcussiveShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Stun_ConcussiveShot = ConROC_SM_Stun_ConcussiveShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Healer) then
						ConROCHunterSpells.ConROC_Healer_Stun_ConcussiveShot = ConROC_SM_Stun_ConcussiveShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Stun_ConcussiveShot = ConROC_SM_Stun_ConcussiveShot:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);				
		local c1t = check1.texture;
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame3_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastStun = check1;
		lastFrame = check1;

	--Wing Clip
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Surv_Ability.WingClipRank1); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Stun_WingClip", frame, "UICheckButtonTemplate");
		local check2text = frame:CreateFontString(check2, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check2:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_WingClip);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_WingClip);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_WingClip);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Stun_WingClip = ConROC_SM_Stun_WingClip:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Stun_WingClip = ConROC_SM_Stun_WingClip:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Stun_WingClip = ConROC_SM_Stun_WingClip:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);				
		local c2t = check2.texture;
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame3_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastStun = check2;
		lastFrame = check2;

	--Intimidation
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.BM_Ability.Intimidation); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Stun_Intimidation", frame, "UICheckButtonTemplate");
		local check3text = frame:CreateFontString(check3, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check3:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_Intimidation);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_Intimidation);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_Intimidation);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Stun_Intimidation = ConROC_SM_Stun_Intimidation:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Stun_Intimidation = ConROC_SM_Stun_Intimidation:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Stun_Intimidation = ConROC_SM_Stun_Intimidation:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);				
		local c3t = check3.texture;
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame3_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastStun = check3;
		lastFrame = check3;

	--Scatter Shot
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.MM_Ability.ScatterShot); 
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Stun_ScatterShot", frame, "UICheckButtonTemplate");
		local check4text = frame:CreateFontString(check4, "ARTWORK", "GameFontHighlightSmall");		
			check4:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			check4:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check4:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_ScatterShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check4:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_ScatterShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check4:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_ScatterShot);
			end
			check4:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Stun_ScatterShot = ConROC_SM_Stun_ScatterShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Stun_ScatterShot = ConROC_SM_Stun_ScatterShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Stun_ScatterShot = ConROC_SM_Stun_ScatterShot:GetChecked();
					end
				end);
			check4text:SetText(c4tspellName);				
		local c4t = check4.texture;
			if not c4t then
				c4t = check4:CreateTexture('CheckFrame3_check4_Texture', 'ARTWORK');
				c4t:SetTexture(c4tspell);
				c4t:SetBlendMode('BLEND');
				check4.texture = c4t;
			end			
			c4t:SetScale(0.4);
			c4t:SetPoint("LEFT", check4, "RIGHT", 8, 0);
			check4text:SetPoint('LEFT', c4t, 'RIGHT', 5, 0);
			
		lastStun = check4;
		lastFrame = check4;
		
		frame:Show()
end

function ConROC:CheckHeader2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader2", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_CheckHeader2", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Options");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame2_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
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
					ConROCCheckFrame2:Show();
					ConROC_CheckFrame2_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame2_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontDemons, "RIGHT", 0, 0)
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
					ConROCCheckFrame2:Hide();
					ConROC_CheckFrame2_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame2();
end

function ConROC:CheckFrame2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame2", ConROCCheckHeader2)
		
	frame:SetFrameStrata('MEDIUM');
	frame:SetFrameLevel('5')
	frame:SetSize(180, 5)
	frame:SetAlpha(1)
	
	frame:SetPoint("TOP", "ConROCCheckHeader2", "BOTTOM", 0, 0)
	frame:SetMovable(false)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(true)

	lastOption = frame;
	lastFrame = frame;

	--AoE Toggle Button
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Option_AoE", frame, "UICheckButtonTemplate");
		local check2text = check2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", ConROCCheckFrame2, "BOTTOM", -150, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
				check2:SetChecked(ConROCHunterSpells.ConROC_Ranged_Option_AoE);
				if ConROC:CheckBox(ConROC_SM_Option_AoE) then
					ConROCButtonFrame:Show();
					if ConROC.db.profile.unlockWindow then
						ConROCToggleMover:Show();					
					else
						ConROCToggleMover:Hide();					
					end
				else
					ConROCButtonFrame:Hide();
					ConROCToggleMover:Hide();
				end
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCHunterSpells.ConROC_Melee_Option_AoE);
				if ConROC:CheckBox(ConROC_SM_Option_AoE) then
					ConROCButtonFrame:Show();
					if ConROC.db.profile.unlockWindow then
						ConROCToggleMover:Show();					
					else
						ConROCToggleMover:Hide();					
					end					
				else
					ConROCButtonFrame:Hide();
					ConROCToggleMover:Hide();
				end
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCHunterSpells.ConROC_PvP_Option_AoE);
				if ConROC:CheckBox(ConROC_SM_Option_AoE) then
					ConROCButtonFrame:Show();
					if ConROC.db.profile.unlockWindow then
						ConROCToggleMover:Show();					
					else
						ConROCToggleMover:Hide();					
					end					
				else
					ConROCButtonFrame:Hide();
					ConROCToggleMover:Hide();
				end
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
						ConROCHunterSpells.ConROC_Ranged_Option_AoE = ConROC_SM_Option_AoE:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCHunterSpells.ConROC_Melee_Option_AoE = ConROC_SM_Option_AoE:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCHunterSpells.ConROC_PvP_Option_AoE = ConROC_SM_Option_AoE:GetChecked();
					end
					if ConROC:CheckBox(ConROC_SM_Option_AoE) then
						ConROCButtonFrame:Show();
						if ConROC.db.profile.unlockWindow then
							ConROCToggleMover:Show();					
						else
							ConROCToggleMover:Hide();					
						end					
					else
						ConROCButtonFrame:Hide();
						ConROCToggleMover:Hide();
					end
				end);
			check2text:SetText("AoE Toggle Button");
			check2text:SetScale(2);			
			check2text:SetPoint("LEFT", check2, "RIGHT", 20, 0);
			
		lastOption = check2;
		lastFrame = check2;
		
		frame:Show()
end
		
function ConROC:SpellMenuUpdate()
	lastFrame = ConROCSpellmenuClass;
	
	if ConROCRadioHeader1 ~= nil then
		lastSting = ConROCRadioFrame1;
		
	--Stings
		if plvl >= 4 and IsSpellKnown(ids.MM_Ability.SerpentStingRank1) then 
			ConROC_SM_Sting_Serpent:Show();
			lastSting = ConROC_SM_Sting_Serpent;
		else
			ConROC_SM_Sting_Serpent:Hide();
		end

		if plvl >= 22 and IsSpellKnown(ids.MM_Ability.ScorpidStingRank1) then 
			ConROC_SM_Sting_Scorpid:Show(); 
			ConROC_SM_Sting_Scorpid:SetPoint("TOP", lastSting, "BOTTOM", 0, 0);
			lastSting = ConROC_SM_Sting_Scorpid;
		else
			ConROC_SM_Sting_Scorpid:Hide();
		end

		if plvl >= 4 and IsSpellKnown(ids.MM_Ability.SerpentStingRank1) then
			ConROC_SM_Sting_None:Show(); 
			ConROC_SM_Sting_None:SetPoint("TOP", lastSting, "BOTTOM", 0, 0);
			lastSting = ConROC_SM_Sting_None;
		else
			ConROC_SM_Sting_None:Hide();
		end
		
		if plvl >= 36 and IsSpellKnown(ids.MM_Ability.ViperStingRank1) then 
			ConROC_SM_Sting_Viper:Show(); 
			ConROC_SM_Sting_Viper:SetPoint("TOP", lastSting, "BOTTOM", 0, 5);
			lastSting = ConROC_SM_Sting_Viper;
		else
			ConROC_SM_Sting_Viper:Hide();
		end

		if lastSting == ConROCRadioFrame1 then
			ConROCRadioHeader1:Hide();
			ConROCRadioFrame1:Hide();
		end
		
		if ConROCRadioFrame1:IsVisible() then
			lastFrame = lastSting;
		else
			lastFrame = ConROCRadioHeader1;
		end
	end
		
	if ConROCCheckFrame1 ~= nil then
		if lastFrame == lastSting then
			ConROCCheckHeader1:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader1:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastAbility = ConROCCheckFrame1;
		
	--Ability
		if plvl >= 6 then 
			ConROC_SM_Ability_HuntersMark:Show();
			lastAbility = ConROC_SM_Ability_HuntersMark;
		else
			ConROC_SM_Ability_HuntersMark:Hide();
		end

		if plvl >= 18 and IsSpellKnown(ids.MM_Ability.MultiShotRank1) then 
			ConROC_SM_Ability_MultiShot:Show(); 
			ConROC_SM_Ability_MultiShot:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			lastAbility = ConROC_SM_Ability_MultiShot;
		else
			ConROC_SM_Ability_MultiShot:Hide();
		end		
		
		if plvl >= 20 and IsSpellKnown(ids.MM_Ability.AimedShotRank1) then 
			ConROC_SM_Ability_AimedShot:Show(); 
			ConROC_SM_Ability_AimedShot:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			lastAbility = ConROC_SM_Ability_AimedShot;
		else
			ConROC_SM_Ability_AimedShot:Hide();
		end		
		
		if plvl >= 26 and IsSpellKnown(ids.MM_Ability.RapidFire) then 
			ConROC_SM_Ability_RapidFire:Show(); 
			ConROC_SM_Ability_RapidFire:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			lastAbility = ConROC_SM_Ability_RapidFire;
		else
			ConROC_SM_Ability_RapidFire:Hide();
		end

		if plvl >= 40 and IsSpellKnown(ids.BM_Ability.BestialWrath) then 
			ConROC_SM_Ability_BestialWrath:Show(); 
			ConROC_SM_Ability_BestialWrath:SetPoint("TOP", lastAbility, "BOTTOM", 0, 0);
			lastAbility = ConROC_SM_Ability_BestialWrath;
		else
			ConROC_SM_Ability_BestialWrath:Hide();
		end

		if lastAbility == ConROCCheckFrame1 then
			ConROCCheckHeader1:Hide();
			ConROCCheckFrame1:Hide();
		end
		
		if ConROCCheckFrame1:IsVisible() then
			lastFrame = lastAbility;
		else
			lastFrame = ConROCCheckHeader1;
		end		
	end
	
	if ConROCCheckFrame3 ~= nil then
		if lastFrame == lastSting or lastFrame == lastAbility then
			ConROCCheckHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastStun = ConROCCheckFrame3;
		
	--Stuns
		if plvl >= 8 and IsSpellKnown(ids.MM_Ability.ConcussiveShot) then 
			ConROC_SM_Stun_ConcussiveShot:Show();
			lastStun = ConROC_SM_Stun_ConcussiveShot;
		else
			ConROC_SM_Stun_ConcussiveShot:Hide();
		end	

		if plvl >= 12 then 
			ConROC_SM_Stun_WingClip:Show(); 
			ConROC_SM_Stun_WingClip:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			lastStun = ConROC_SM_Stun_WingClip;
		else
			ConROC_SM_Stun_WingClip:Hide();
		end

		if plvl >= 30 and IsSpellKnown(ids.BM_Ability.Intimidation) then 
			ConROC_SM_Stun_Intimidation:Show(); 
			ConROC_SM_Stun_Intimidation:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			lastStun = ConROC_SM_Stun_Intimidation;
		else
			ConROC_SM_Stun_Intimidation:Hide();
		end

		if plvl >= 30 and IsSpellKnown(ids.MM_Ability.ScatterShot) then 
			ConROC_SM_Stun_ScatterShot:Show(); 
			ConROC_SM_Stun_ScatterShot:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			lastStun = ConROC_SM_Stun_ScatterShot;
		else
			ConROC_SM_Stun_ScatterShot:Hide();
		end

		if lastStun == ConROCCheckFrame3 then
			ConROCCheckHeader3:Hide();
			ConROCCheckFrame3:Hide();
		end
		
		if ConROCCheckFrame3:IsVisible() then
			lastFrame = lastStun;
		else
			lastFrame = ConROCCheckHeader3;
		end		
	end	
	
	if ConROCCheckFrame2 ~= nil then
		if lastFrame == lastSting or lastFrame == lastAbility or lastFrame == lastStun then
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastOption = ConROCCheckFrame2;
		
	--Options
		if plvl >= 18 then 
			ConROC_SM_Option_AoE:Show(); 
			lastOption = ConROC_SM_Option_AoE;
		else
			ConROC_SM_Option_AoE:Hide();
		end

		if lastOption == ConROCCheckFrame2 then
			ConROCCheckHeader2:Hide();
			ConROCCheckFrame2:Hide();
		end
		
		if ConROCCheckFrame2:IsVisible() then
			lastFrame = lastOption;
		else
			lastFrame = ConROCCheckHeader2;
		end		
	end	
end

function ConROC:RoleProfile()
	if ConROC:CheckBox(ConROC_SM_Role_Ranged) then
		ConROC_SM_Sting_Serpent:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_Serpent);
		ConROC_SM_Sting_Scorpid:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_Scorpid);
		ConROC_SM_Sting_Viper:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_Viper);
		ConROC_SM_Sting_None:SetChecked(ConROCHunterSpells.ConROC_Ranged_Sting_None);
		
		ConROC_SM_Ability_HuntersMark:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_HuntersMark);
		ConROC_SM_Ability_MultiShot:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_MultiShot);
		ConROC_SM_Ability_AimedShot:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_AimedShot);
		ConROC_SM_Ability_RapidFire:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_RapidFire);
		ConROC_SM_Ability_BestialWrath:SetChecked(ConROCHunterSpells.ConROC_Ranged_Ability_BestialWrath);

		ConROC_SM_Stun_ConcussiveShot:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_ConcussiveShot);
		ConROC_SM_Stun_WingClip:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_WingClip);
		ConROC_SM_Stun_Intimidation:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_Intimidation);
		ConROC_SM_Stun_ScatterShot:SetChecked(ConROCHunterSpells.ConROC_Ranged_Stun_ScatterShot);

		ConROC_SM_Option_AoE:SetChecked(ConROCHunterSpells.ConROC_Ranged_Option_AoE);

		if ConROC:CheckBox(ConROC_SM_Option_AoE) then
			ConROCButtonFrame:Show();
			if ConROC.db.profile.unlockWindow then
				ConROCToggleMover:Show();
			else
				ConROCToggleMover:Hide();
			end					
		else
			ConROCButtonFrame:Hide();
			ConROCToggleMover:Hide();
		end
		
	elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
		ConROC_SM_Sting_Serpent:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_Serpent);
		ConROC_SM_Sting_Scorpid:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_Scorpid);
		ConROC_SM_Sting_Viper:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_Viper);
		ConROC_SM_Sting_None:SetChecked(ConROCHunterSpells.ConROC_Melee_Sting_None);
		
		ConROC_SM_Ability_HuntersMark:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_HuntersMark);
		ConROC_SM_Ability_MultiShot:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_MultiShot);
		ConROC_SM_Ability_AimedShot:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_AimedShot);
		ConROC_SM_Ability_RapidFire:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_RapidFire);
		ConROC_SM_Ability_BestialWrath:SetChecked(ConROCHunterSpells.ConROC_Melee_Ability_BestialWrath);

		ConROC_SM_Stun_ConcussiveShot:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_ConcussiveShot);
		ConROC_SM_Stun_WingClip:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_WingClip);
		ConROC_SM_Stun_Intimidation:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_Intimidation);
		ConROC_SM_Stun_ScatterShot:SetChecked(ConROCHunterSpells.ConROC_Melee_Stun_ScatterShot);

		ConROC_SM_Option_AoE:SetChecked(ConROCHunterSpells.ConROC_Melee_Option_AoE);

		if ConROC:CheckBox(ConROC_SM_Option_AoE) then
			ConROCButtonFrame:Show();
			if ConROC.db.profile.unlockWindow then
				ConROCToggleMover:Show();
			else
				ConROCToggleMover:Hide();
			end					
		else
			ConROCButtonFrame:Hide();
			ConROCToggleMover:Hide();
		end
		
	elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
		ConROC_SM_Sting_Serpent:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_Serpent);
		ConROC_SM_Sting_Scorpid:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_Scorpid);
		ConROC_SM_Sting_Viper:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_Viper);
		ConROC_SM_Sting_None:SetChecked(ConROCHunterSpells.ConROC_PvP_Sting_None);

		ConROC_SM_Ability_HuntersMark:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_HuntersMark);
		ConROC_SM_Ability_MultiShot:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_MultiShot);
		ConROC_SM_Ability_AimedShot:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_AimedShot);
		ConROC_SM_Ability_RapidFire:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_RapidFire);
		ConROC_SM_Ability_BestialWrath:SetChecked(ConROCHunterSpells.ConROC_PvP_Ability_BestialWrath);		

		ConROC_SM_Stun_ConcussiveShot:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_ConcussiveShot);
		ConROC_SM_Stun_WingClip:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_WingClip);
		ConROC_SM_Stun_Intimidation:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_Intimidation);
		ConROC_SM_Stun_ScatterShot:SetChecked(ConROCHunterSpells.ConROC_PvP_Stun_ScatterShot);
		
		ConROC_SM_Option_AoE:SetChecked(ConROCHunterSpells.ConROC_PvP_Option_AoE);

		if ConROC:CheckBox(ConROC_SM_Option_AoE) then
			ConROCButtonFrame:Show();
			if ConROC.db.profile.unlockWindow then
				ConROCToggleMover:Show();
			else
				ConROCToggleMover:Hide();
			end					
		else
			ConROCButtonFrame:Hide();
			ConROCToggleMover:Hide();
		end		
	end
end