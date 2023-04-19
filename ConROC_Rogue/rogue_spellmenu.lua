local ConROC_Rogue, ids = ...;

local lastFrame = 0;
local lastPoison = 0;
local lastDebuff = 0;
local lastStun = 0;

-- Update for scrolling window -- Start
local firstFrame = 0;
local showOptions = false;
local fixOptionsWidth = false;
local frameWidth = ConROCSpellmenuFrame:GetWidth()*2;
local scrollContentWidth = 180;
local scrollHeight = 0;
local checkBoxScale = 0.5;
local defaultSH = 200;
-- end

local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Melee"] = true,

	["ConROC_Melee_PoisonMH_None"] = true,
	["ConROC_Melee_PoisonOH_None"] = true,
	["ConROC_Melee_Debuff_SliceandDice"] = true,	
	["ConROC_Melee_Debuff_Garrote"] = true,
	["ConROC_Melee_Debuff_Hemorrhage"] = true,
}

ConROCRogueSpells = ConROCRogueSpells or defaults;

function ConROC:SpellmenuClass()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCSpellmenuClass", ConROCSpellmenuFrame)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(frameWidth, 30)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCSpellmenuFrame_Title", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		
	--Melee
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Role_Melee", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(nil, "ARTWORK", "GameFontRedSmall");
			radio1:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -10);
			radio1:SetChecked(ConROCRogueSpells.ConROC_SM_Role_Melee);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Melee:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCRogueSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCRogueSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio1text:SetText("Melee");
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('Spellmenu_radio1_Texture', 'ARTWORK');
				r1t:SetTexture('Interface\\AddOns\\ConROC\\images\\bigskull');
				r1t:SetBlendMode('BLEND');
				local color = ConROC.db.profile.damageOverlayColor;
				r1t:SetVertexColor(color.r, color.g, color.b);				
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("CENTER", radio1, "CENTER", 0, 0);
			radio1text:SetPoint("BOTTOM", radio1, "TOP", 0, 5);
		
	--PvP
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Role_PvP", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(nil, "ARTWORK", "GameFontRedSmall");
			radio4:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -10);
			radio4:SetChecked(ConROCRogueSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCRogueSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCRogueSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
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
	-- Update for scrolling window -- Start
		ConROCSpellmenuHolder = CreateFrame("Frame", "ConROCSpellmenuHolder", ConROCSpellmenuClass);
		ConROCSpellmenuHolder:SetParent(ConROCSpellmenuClass);
		ConROCSpellmenuHolder:SetSize(frameWidth - 6, 230);
		ConROCSpellmenuHolder:SetPoint("TOP", ConROCSpellmenuClass, "CENTER", 0, -20);
		ConROCSpellmenuHolder.bg = ConROCSpellmenuHolder:CreateTexture(nil, "BACKGROUND");
		ConROCSpellmenuHolder.bg:SetAllPoints()

		ConROCSpellmenuScrollFrame = CreateFrame("ScrollFrame", "ConROCSpellmenuScrollFrame", ConROCSpellmenuHolder, "UIPanelScrollFrameTemplate");
		ConROCSpellmenuScrollFrame:SetPoint("TOPLEFT", ConROCSpellmenuHolder, "TOPLEFT", 4, -2);
		ConROCSpellmenuScrollFrame:SetPoint("BOTTOMRIGHT", ConROCSpellmenuHolder, "BOTTOMRIGHT", -3, 0);
		
		ConROCSpellmenuScrollFrame.bg = ConROCSpellmenuScrollFrame:CreateTexture(nil, "BACKGROUND");
		ConROCSpellmenuScrollFrame.bg:SetAllPoints()

		ConROCSpellmenuScrollFrame.ScrollBar:ClearAllPoints();
		ConROCSpellmenuScrollFrame.ScrollBar:SetPoint("TOPLEFT", ConROCSpellmenuScrollFrame, "TOPRIGHT", -12, -18);
		ConROCSpellmenuScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", ConROCSpellmenuScrollFrame, "BOTTOMRIGHT", -7, 18);
		ConROCSpellmenuScrollFrame:SetClipsChildren(true);

		local ConROCScrollChild = CreateFrame("Frame", "ConROCScrollChild", ConROCSpellmenuScrollFrame);
		ConROCScrollChild:SetWidth(ConROCSpellmenuScrollFrame:GetWidth()-20);
		ConROCScrollChild.bg = ConROCScrollChild:CreateTexture(nil, "BACKGROUND");

		ConROCSpellmenuScrollFrame:SetScrollChild(ConROCScrollChild);
--[[	
		ConROCSpellmenuScrollFrame.texture = ConROCSpellmenuScrollFrame:CreateTexture(nil,"BACKGROUND")
		ConROCSpellmenuScrollFrame.texture:SetAllPoints(ConROCSpellmenuScrollFrame)
		ConROCSpellmenuScrollFrame.texture:SetColorTexture(1.0,0,0,0.5);
		ConROCScrollChild.texture = ConROCScrollChild:CreateTexture(nil,"BACKGROUND")
		ConROCScrollChild.texture:SetAllPoints(ConROCScrollChild)
		ConROCScrollChild.texture:SetColorTexture(1.0,0,1.0,0.5);
--]]
		lastFrame = ConROCScrollChild;
		ConROCScrollChild:Hide();
	-- end
	ConROC:updateScrollArea();
	
	ConROC:RadioHeader1();
	ConROC:RadioHeader2();
	ConROC:CheckHeader1();
	ConROC:CheckHeader2();

	-- Update for scrolling window -- Start
	ConROCSpellmenuScrollFrame:UpdateScrollChildRect();
	ConROCSpellmenuHolder:Hide();
	showOptions = true;
	defaultSH = scrollHeight;
	ConROC:SpellMenuUpdate();
	fixOptionsWidth = true;	

	--end
end
-- Update for scrolling window -- Start
local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 10);
	
	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end
	
	self:SetVerticalScroll(newValue);
end

function ConROC:SpellMenuScroll(_show)
		if _show then
			ConROCSpellmenuHolder:Show()
			ConROCScrollChild:Show();
		else 
			ConROCSpellmenuHolder:Hide()
			ConROCScrollChild:Hide();
		end

end
-- end

function ConROC:RadioHeader1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioHeader1", ConROCScrollChild)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)

		local fontTitle = frame:CreateFontString("ConROC_Spellmenu_RadioHeader1", "ARTWORK", "GameFontGreenSmall");
			fontTitle:SetText("Poisons MH");
			fontTitle:SetPoint('TOP', frame, 'TOP');

		frame:Show();
		firstFrame = frame;
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight() +5;
		
	ConROC:RadioFrame1();
end

function ConROC:RadioFrame1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioFrame1", ConROCRadioHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", "ConROCRadioHeader1", "BOTTOMLEFT", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		lastPoison = frame;
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Instant Poison
		local r1name, _, _, _, _, _, _, _, _, r1texture = GetItemInfo(ids.Poisons.InstantPoisonRank1);
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_Instant", frame, "UIRadioButtonTemplate");
		local radio1text = radio1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio1:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_PoisonMH_Instant:SetChecked(true);
					ConROC_SM_PoisonMH_Crippling:SetChecked(false);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonMH_Deadly:SetChecked(false);
					ConROC_SM_PoisonMH_Wound:SetChecked(false);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonMH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio1text:SetText(r1name);
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('RadioFrame1_radio1_Texture', 'ARTWORK');
				r1t:SetTexture(r1texture);
				r1t:SetBlendMode('BLEND');
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("LEFT", radio1, "RIGHT", 8, 0);
			radio1text:SetPoint('LEFT', r1t, 'RIGHT', 5, 0);
		
		lastPoison = radio1;
		lastFrame = radio1;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Crippling Poison
		local r2name, _, _, _, _, _, _, _, _, r2texture = GetItemInfo(ids.Poisons.CripplingPoisonRank1);
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_Crippling", frame, "UIRadioButtonTemplate");
		local radio2text = radio2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			radio2:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_PoisonMH_Instant:SetChecked(false);
					ConROC_SM_PoisonMH_Crippling:SetChecked(true);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonMH_Deadly:SetChecked(false);
					ConROC_SM_PoisonMH_Wound:SetChecked(false);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonMH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio2text:SetText(r2name);					
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('RadioFrame1_radio2_Texture', 'ARTWORK');
				r2t:SetTexture(r2texture);
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("LEFT", radio2, "RIGHT", 8, 0);
			radio2text:SetPoint('LEFT', r2t, 'RIGHT', 5, 0);

		lastPoison = radio2;
		lastFrame = radio2;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Mindnumbing Poison
		local r3name, _, _, _, _, _, _, _, _, r3texture = GetItemInfo(ids.Poisons.MindnumbingPoisonRank1);
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_Mindnumbing", frame, "UIRadioButtonTemplate");
		local radio3text = radio3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio3:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing);
			end
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonMH_Instant:SetChecked(false);
					ConROC_SM_PoisonMH_Crippling:SetChecked(false);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(true);
					ConROC_SM_PoisonMH_Deadly:SetChecked(false);
					ConROC_SM_PoisonMH_Wound:SetChecked(false);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonMH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio3text:SetText(r3name);					
		local r3t = radio3.texture;

			if not r3t then
				r3t = radio3:CreateTexture('RadioFrame1_radio3_Texture', 'ARTWORK');
				r3t:SetTexture(r3texture);
				r3t:SetBlendMode('BLEND');
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastPoison = radio3;
		lastFrame = radio3;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Deadly Poison
		local r4name, _, _, _, _, _, _, _, _, r4texture = GetItemInfo(ids.Poisons.DeadlyPoisonRank1);	
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_Deadly", frame, "UIRadioButtonTemplate");
		local radio4text = radio4:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
			radio4:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly);
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonMH_Instant:SetChecked(false);
					ConROC_SM_PoisonMH_Crippling:SetChecked(false);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonMH_Deadly:SetChecked(true);
					ConROC_SM_PoisonMH_Wound:SetChecked(false);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonMH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio4text:SetText(r4name);
		local r4t = radio4.texture;

			if not r4t then
				r4t = radio4:CreateTexture('RadioFrame1_radio4_Texture', 'ARTWORK');
				r4t:SetTexture(r4texture);
				r4t:SetBlendMode('BLEND');
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);			
			r4t:SetPoint("LEFT", radio4, "RIGHT", 8, 0);
			radio4text:SetPoint('LEFT', r4t, 'RIGHT', 5, 0);

		lastPoison = radio4;		
		lastFrame = radio4;
		scrollHeight = scrollHeight + lastFrame:GetHeight();

	--Wound Poison
		local r5name, _, _, _, _, _, _, _, _, r5texture = GetItemInfo(ids.Poisons.WoundPoisonRank1);	
		local radio5 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_Wound", frame, "UIRadioButtonTemplate");
		local radio5text = radio5:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio5:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio5:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio5:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound);
			end
			radio5:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonMH_Instant:SetChecked(false);
					ConROC_SM_PoisonMH_Crippling:SetChecked(false);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonMH_Deadly:SetChecked(false);
					ConROC_SM_PoisonMH_Wound:SetChecked(true);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonMH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio5text:SetText(r5name);
		local r5t = radio5.texture;

			if not r5t then
				r5t = radio5:CreateTexture('RadioFrame1_radio5_Texture', 'ARTWORK');
				r5t:SetTexture(r5texture);
				r5t:SetBlendMode('BLEND');
				radio5.texture = r5t;
			end			
			r5t:SetScale(0.2);			
			r5t:SetPoint("LEFT", radio5, "RIGHT", 8, 0);
			radio5text:SetPoint('LEFT', r5t, 'RIGHT', 5, 0);

		lastPoison = radio5;		
		lastFrame = radio5;
		scrollHeight = scrollHeight + lastFrame:GetHeight();

	--Anestehetic Poison AnestheticPoisonRank1
		local r6name, _, _, _, _, _, _, _, _, r6texture = GetItemInfo(ids.Poisons.AnestheticPoisonRank1);
		local radio6 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_Anesthetic", frame, "UIRadioButtonTemplate");
		local radio6text = radio6:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio6:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio6:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio6:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic);	
			end
			radio6:SetScript("OnClick",
				function()
					ConROC_SM_PoisonMH_Instant:SetChecked(false);
					ConROC_SM_PoisonMH_Crippling:SetChecked(false);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonMH_Deadly:SetChecked(false);
					ConROC_SM_PoisonMH_Wound:SetChecked(false);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(true);
					ConROC_SM_PoisonMH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio6text:SetText(r6name);
		local r6t = radio6.texture;
			if not r6t then
				r6t = radio6:CreateTexture('RadioFrame1_radio6_Texture', 'ARTWORK');
				r6t:SetTexture(r6texture);
				r6t:SetBlendMode('BLEND');
				radio6.texture = r6t;
			end			
			r6t:SetScale(0.2);
			r6t:SetPoint("LEFT", radio6, "RIGHT", 8, 0);
			radio6text:SetPoint('LEFT', r6t, 'RIGHT', 5, 0);
		
		lastPoison = radio6;
		lastFrame = radio6;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		

	--None
		local radio7 = CreateFrame("CheckButton", "ConROC_SM_PoisonMH_None", frame, "UIRadioButtonTemplate");
		local radio7text = radio7:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			radio7:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio7:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_None);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio7:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_None);
			end
			radio7:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonMH_Instant:SetChecked(false);
					ConROC_SM_PoisonMH_Crippling:SetChecked(false);
					ConROC_SM_PoisonMH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonMH_Deadly:SetChecked(false);
					ConROC_SM_PoisonMH_Wound:SetChecked(false);
					ConROC_SM_PoisonMH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonMH_None:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant = ConROC_SM_PoisonMH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling = ConROC_SM_PoisonMH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing = ConROC_SM_PoisonMH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly = ConROC_SM_PoisonMH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound = ConROC_SM_PoisonMH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_Anesthetic = ConROC_SM_PoisonMH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonMH_None = ConROC_SM_PoisonMH_None:GetChecked();
					end
				end
			);
			radio7text:SetText("None");
			radio7text:SetPoint('LEFT', radio7, 'RIGHT', 20, 0);

		lastPoison = radio7;		
		lastFrame = radio7;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
		frame:Show()
end

function ConROC:RadioHeader2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioHeader2", ConROCScrollChild)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 1)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		local fontTitle = frame:CreateFontString("ConROC_Spellmenu_RadioHeader2", "ARTWORK", "GameFontGreenSmall");
			fontTitle:SetText("Poisons OH");
			fontTitle:SetPoint('TOP', frame, 'TOP');

		frame:Show();
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight() + 5;
		
	ConROC:RadioFrame2();
end

function ConROC:RadioFrame2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCRadioFrame2", ConROCRadioHeader2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCRadioHeader2", "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		lastPoisonOH = frame;
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Instant Poison
		local r1name, _, _, _, _, _, _, _, _, r1texture = GetItemInfo(ids.Poisons.InstantPoisonRank1);
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_Instant", frame, "UIRadioButtonTemplate");
		local radio1text = radio1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio1:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio1:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_PoisonOH_Instant:SetChecked(true);
					ConROC_SM_PoisonOH_Crippling:SetChecked(false);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonOH_Deadly:SetChecked(false);
					ConROC_SM_PoisonOH_Wound:SetChecked(false);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonOH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio1text:SetText(r1name);
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('RadioFrame2_radio1_Texture', 'ARTWORK');
				r1t:SetTexture(r1texture);
				r1t:SetBlendMode('BLEND');
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("LEFT", radio1, "RIGHT", 8, 0);
			radio1text:SetPoint('LEFT', r1t, 'RIGHT', 5, 0);
		
		lastPoisonOH = radio1;
		lastFrame = radio1;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Crippling Poison
		local r2name, _, _, _, _, _, _, _, _, r2texture = GetItemInfo(ids.Poisons.CripplingPoisonRank1);
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_Crippling", frame, "UIRadioButtonTemplate");
		local radio2text = radio2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			radio2:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio2:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_PoisonOH_Instant:SetChecked(false);
					ConROC_SM_PoisonOH_Crippling:SetChecked(true);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonOH_Deadly:SetChecked(false);
					ConROC_SM_PoisonOH_Wound:SetChecked(false);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonOH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio2text:SetText(r2name);					
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('RadioFrame2_radio2_Texture', 'ARTWORK');
				r2t:SetTexture(r2texture);
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("LEFT", radio2, "RIGHT", 8, 0);
			radio2text:SetPoint('LEFT', r2t, 'RIGHT', 5, 0);

		lastPoisonOH = radio2;
		lastFrame = radio2;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Mindnumbing Poison
		local r3name, _, _, _, _, _, _, _, _, r3texture = GetItemInfo(ids.Poisons.MindnumbingPoisonRank1);
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_Mindnumbing", frame, "UIRadioButtonTemplate");
		local radio3text = radio3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio3:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio3:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing);
			end
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonOH_Instant:SetChecked(false);
					ConROC_SM_PoisonOH_Crippling:SetChecked(false);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(true);
					ConROC_SM_PoisonOH_Deadly:SetChecked(false);
					ConROC_SM_PoisonOH_Wound:SetChecked(false);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonOH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio3text:SetText(r3name);					
		local r3t = radio3.texture;

			if not r3t then
				r3t = radio3:CreateTexture('RadioFrame2_radio3_Texture', 'ARTWORK');
				r3t:SetTexture(r3texture);
				r3t:SetBlendMode('BLEND');
				radio3.texture = r3t;
			end			
			r3t:SetScale(0.2);
			r3t:SetPoint("LEFT", radio3, "RIGHT", 8, 0);
			radio3text:SetPoint('LEFT', r3t, 'RIGHT', 5, 0);

		lastPoisonOH = radio3;
		lastFrame = radio3;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Deadly Poison
		local r4name, _, _, _, _, _, _, _, _, r4texture = GetItemInfo(ids.Poisons.DeadlyPoisonRank1);	
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_Deadly", frame, "UIRadioButtonTemplate");
		local radio4text = radio4:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
			radio4:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio4:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly);
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonOH_Instant:SetChecked(false);
					ConROC_SM_PoisonOH_Crippling:SetChecked(false);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonOH_Deadly:SetChecked(true);
					ConROC_SM_PoisonOH_Wound:SetChecked(false);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonOH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio4text:SetText(r4name);
		local r4t = radio4.texture;

			if not r4t then
				r4t = radio4:CreateTexture('RadioFrame2_radio4_Texture', 'ARTWORK');
				r4t:SetTexture(r4texture);
				r4t:SetBlendMode('BLEND');
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);			
			r4t:SetPoint("LEFT", radio4, "RIGHT", 8, 0);
			radio4text:SetPoint('LEFT', r4t, 'RIGHT', 5, 0);

		lastPoisonOH = radio4;		
		lastFrame = radio4;
		scrollHeight = scrollHeight + lastFrame:GetHeight();

	--Wound Poison
		local r5name, _, _, _, _, _, _, _, _, r5texture = GetItemInfo(ids.Poisons.WoundPoisonRank1);	
		local radio5 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_Wound", frame, "UIRadioButtonTemplate");
		local radio5text = radio5:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio5:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio5:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio5:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound);
			end
			radio5:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonOH_Instant:SetChecked(false);
					ConROC_SM_PoisonOH_Crippling:SetChecked(false);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonOH_Deadly:SetChecked(false);
					ConROC_SM_PoisonOH_Wound:SetChecked(true);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonOH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio5text:SetText(r5name);
		local r5t = radio5.texture;

			if not r5t then
				r5t = radio5:CreateTexture('RadioFrame2_radio5_Texture', 'ARTWORK');
				r5t:SetTexture(r5texture);
				r5t:SetBlendMode('BLEND');
				radio5.texture = r5t;
			end			
			r5t:SetScale(0.2);			
			r5t:SetPoint("LEFT", radio5, "RIGHT", 8, 0);
			radio5text:SetPoint('LEFT', r5t, 'RIGHT', 5, 0);

		lastPoisonOH = radio5;		
		lastFrame = radio5;
		scrollHeight = scrollHeight + lastFrame:GetHeight();

	--Anesthetic Poison
		local r6name, _, _, _, _, _, _, _, _, r6texture = GetItemInfo(ids.Poisons.AnestheticPoisonRank1);	
		local radio6 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_Anesthetic", frame, "UIRadioButtonTemplate");
		local radio6text = radio6:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			radio6:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio6:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio6:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic);
			end
			radio6:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonOH_Instant:SetChecked(false);
					ConROC_SM_PoisonOH_Crippling:SetChecked(false);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonOH_Deadly:SetChecked(false);
					ConROC_SM_PoisonOH_Wound:SetChecked(false);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(true);
					ConROC_SM_PoisonOH_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio6text:SetText(r6name);
		local r6t = radio6.texture;

			if not r6t then
				r6t = radio6:CreateTexture('RadioFrame2_radio6_Texture', 'ARTWORK');
				r6t:SetTexture(r6texture);
				r6t:SetBlendMode('BLEND');
				radio6.texture = r6t;
			end			
			r6t:SetScale(0.2);			
			r6t:SetPoint("LEFT", radio6, "RIGHT", 8, 0);
			radio6text:SetPoint('LEFT', r6t, 'RIGHT', 5, 0);

		lastPoisonOH = radio6;		
		lastFrame = radio6;
		scrollHeight = scrollHeight + lastFrame:GetHeight();

	--None
		local radio7 = CreateFrame("CheckButton", "ConROC_SM_PoisonOH_None", frame, "UIRadioButtonTemplate");
		local radio7text = radio7:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			radio7:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				radio7:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_None);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio7:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_None);
			end
			radio7:SetScript("OnClick", 
			  function()
					ConROC_SM_PoisonOH_Instant:SetChecked(false);
					ConROC_SM_PoisonOH_Crippling:SetChecked(false);
					ConROC_SM_PoisonOH_Mindnumbing:SetChecked(false);
					ConROC_SM_PoisonOH_Deadly:SetChecked(false);
					ConROC_SM_PoisonOH_Wound:SetChecked(false);
					ConROC_SM_PoisonOH_Anesthetic:SetChecked(false);
					ConROC_SM_PoisonOH_None:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_Melee_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant = ConROC_SM_PoisonOH_Instant:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling = ConROC_SM_PoisonOH_Crippling:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing = ConROC_SM_PoisonOH_Mindnumbing:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly = ConROC_SM_PoisonOH_Deadly:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound = ConROC_SM_PoisonOH_Wound:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic = ConROC_SM_PoisonOH_Anesthetic:GetChecked();
						ConROCRogueSpells.ConROC_PvP_PoisonOH_None = ConROC_SM_PoisonOH_None:GetChecked();
					end
				end
			);
			radio7text:SetText("None");
			radio7text:SetPoint('LEFT', radio7, 'RIGHT', 20, 0);

		lastPoisonOH = radio7;		
		lastFrame = radio7;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
		frame:Show()
end

function ConROC:CheckHeader1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader1", ConROCScrollChild)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 1)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_CheckHeader1", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Debuffs");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
		frame:Show();
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight() + 5;
		
	ConROC:CheckFrame1();
end

function ConROC:CheckFrame1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame1", ConROCCheckHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", "ConROCCheckHeader1", "BOTTOMLEFT", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		lastDebuff = frame;
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight();

	--SliceandDice
		local c0tspellName, _, c0tspell = GetSpellInfo(ids.Ass_Ability.SliceandDiceRank1); 
		local check0 = CreateFrame("CheckButton", "ConROC_SM_Debuff_SliceandDice", frame, "UICheckButtonTemplate");
		local check0text = check0:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check0:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			check0:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check0:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_SliceandDice);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check0:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_SliceandDice);
			end
			check0:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Debuff_SliceandDice = ConROC_SM_Debuff_SliceandDice:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Debuff_SliceandDice = ConROC_SM_Debuff_SliceandDice:GetChecked();
					end
				end);
			check0text:SetText(c0tspellName);
			check0text:SetScale(2);
		local c0t = check0.texture;
			if not c0t then
				c0t = check0:CreateTexture('CheckFrame1_check0_Texture', 'ARTWORK');
				c0t:SetTexture(c0tspell);
				c0t:SetBlendMode('BLEND');
				check0.texture = c0t;
			end			
			c0t:SetScale(0.4);
			c0t:SetPoint("LEFT", check0, "RIGHT", 8, 0);
			check0text:SetPoint('LEFT', c0t, 'RIGHT', 5, 0);
			
		lastDebuff = check0;
		lastFrame = check0;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);
		
	--Garrote
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Ass_Ability.GarroteRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Debuff_Garrote", frame, "UICheckButtonTemplate");
		local check1text = check1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_Garrote);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_Garrote);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Debuff_Garrote = ConROC_SM_Debuff_Garrote:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Debuff_Garrote = ConROC_SM_Debuff_Garrote:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);
			check1text:SetScale(2);
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
			
		lastDebuff = check1;
		lastFrame = check1;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);

	--Expose Armor
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Ass_Ability.ExposeArmorRank1); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Debuff_ExposeArmor", frame, "UICheckButtonTemplate");
		local check2text = check2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_ExposeArmor);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_ExposeArmor);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Debuff_ExposeArmor = ConROC_SM_Debuff_ExposeArmor:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Debuff_ExposeArmor = ConROC_SM_Debuff_ExposeArmor:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);	
			check2text:SetScale(2);
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
			
		lastDebuff = check2;
		lastFrame = check2;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);

	--Rupture
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Ass_Ability.RuptureRank1); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Debuff_Rupture", frame, "UICheckButtonTemplate");
		local check3text = check3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_Rupture);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_Rupture);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Debuff_Rupture = ConROC_SM_Debuff_Rupture:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Debuff_Rupture = ConROC_SM_Debuff_Rupture:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);
			check3text:SetScale(2);
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
			
		lastDebuff = check3;
		lastFrame = check3;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);
		
	--Hemorrhage
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.Sub_Ability.HemorrhageRank1); 
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Debuff_Hemorrhage", frame, "UICheckButtonTemplate");
		local check4text = check4:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check4:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			check4:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check4:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_Hemorrhage);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check4:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_Hemorrhage);
			end
			check4:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Debuff_Hemorrhage = ConROC_SM_Debuff_Hemorrhage:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Debuff_Hemorrhage = ConROC_SM_Debuff_Hemorrhage:GetChecked();
					end
				end);
			check4text:SetText(c4tspellName);
			check4text:SetScale(2);
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
			
		lastDebuff = check4;
		lastFrame = check4;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);
		
		frame:Show()
end

function ConROC:CheckHeader2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader2", ConROCScrollChild)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		local fontStuns = frame:CreateFontString("ConROC_Spellmenu_CheckHeader2", "ARTWORK", "GameFontGreenSmall");
			fontStuns:SetText("Stuns");
			fontStuns:SetPoint('TOP', frame, 'TOP');
		
		frame:Show();
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight() + 5;
		
	ConROC:CheckFrame2();
end

function ConROC:CheckFrame2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame2", ConROCCheckHeader2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(scrollContentWidth, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOPLEFT", "ConROCCheckHeader2", "BOTTOMLEFT", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(false)

		lastStun = frame;
		lastFrame = frame;
		scrollHeight = scrollHeight + lastFrame:GetHeight();
		
	--Gouge
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Com_Ability.GougeRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Stun_Gouge", frame, "UICheckButtonTemplate");
		local check1text = check1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_Gouge);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_Gouge);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Stun_Gouge = ConROC_SM_Stun_Gouge:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Stun_Gouge = ConROC_SM_Stun_Gouge:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);
			check1text:SetScale(2);
		local c1t = check1.texture;
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame2_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastStun = check1;
		lastFrame = check1;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);

	--Cheap Shot
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Ass_Ability.CheapShot); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Stun_CheapShot", frame, "UICheckButtonTemplate");
		local check2text = check2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_CheapShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_CheapShot);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Stun_CheapShot = ConROC_SM_Stun_CheapShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Stun_CheapShot = ConROC_SM_Stun_CheapShot:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);
			check2text:SetScale(2);
		local c2t = check2.texture;
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame2_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastStun = check2;
		lastFrame = check2;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);

	--Kidney Shot
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Ass_Ability.KidneyShotRank1); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Stun_KidneyShot", frame, "UICheckButtonTemplate");
		local check3text = check3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_KidneyShot);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_KidneyShot);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Stun_KidneyShot = ConROC_SM_Stun_KidneyShot:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Stun_KidneyShot = ConROC_SM_Stun_KidneyShot:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);
			check3text:SetScale(2);
		local c3t = check3.texture;
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame2_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastStun = check3;
		lastFrame = check3;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);

	--Blind
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.Sub_Ability.Blind); 
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Stun_Blind", frame, "UICheckButtonTemplate");
		local check4text = check4:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check4:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			check4:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check4:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_Blind);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check4:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_Blind);
			end
			check4:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCRogueSpells.ConROC_Melee_Stun_Blind = ConROC_SM_Stun_Blind:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCRogueSpells.ConROC_PvP_Stun_Blind = ConROC_SM_Stun_Blind:GetChecked();
					end
				end);
			check4text:SetText(c4tspellName);
			check4text:SetScale(2);
		local c4t = check4.texture;
			if not c4t then
				c4t = check4:CreateTexture('CheckFrame2_check4_Texture', 'ARTWORK');
				c4t:SetTexture(c4tspell);
				c4t:SetBlendMode('BLEND');
				check4.texture = c4t;
			end			
			c4t:SetScale(0.4);
			c4t:SetPoint("LEFT", check4, "RIGHT", 8, 0);
			check4text:SetPoint('LEFT', c4t, 'RIGHT', 5, 0);
			
		lastStun = check4;
		lastFrame = check4;
		scrollHeight = scrollHeight + (lastFrame:GetHeight() * checkBoxScale);
		
		frame:Show()
end

function ConROC:SpellMenuUpdate()
	scrollHeight = defaultSH;
	lastFrame = ConROCSpellmenuClass;
	
	if ConROCRadioHeader1 ~= nil then
		lastPoison = ConROCRadioFrame1;
		
	--Poisons MH
		if plvl >= 20 then 
			ConROC_SM_PoisonMH_Instant:Show();
			lastPoison = ConROC_SM_PoisonMH_Instant;
		else
			ConROC_SM_PoisonMH_Instant:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_Instant:GetHeight();
		end

		if plvl >= 20 then 
			ConROC_SM_PoisonMH_Crippling:Show();
			ConROC_SM_PoisonMH_Crippling:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			lastPoison = ConROC_SM_PoisonMH_Crippling;
		else
			ConROC_SM_PoisonMH_Crippling:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_Crippling:GetHeight();
		end
		
		if plvl >= 24 then 
			ConROC_SM_PoisonMH_Mindnumbing:Show(); 
			ConROC_SM_PoisonMH_Mindnumbing:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			lastPoison = ConROC_SM_PoisonMH_Mindnumbing;
		else
			ConROC_SM_PoisonMH_Mindnumbing:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_Mindnumbing:GetHeight();
		end		
		
		if plvl >= 30 then
			ConROC_SM_PoisonMH_Deadly:Show(); 
			ConROC_SM_PoisonMH_Deadly:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			lastPoison = ConROC_SM_PoisonMH_Deadly;
		else
			ConROC_SM_PoisonMH_Deadly:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_Deadly:GetHeight();
		end

		if plvl >= 32 then 
			ConROC_SM_PoisonMH_Wound:Show(); 
			ConROC_SM_PoisonMH_Wound:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			lastPoison = ConROC_SM_PoisonMH_Wound;
		else
			ConROC_SM_PoisonMH_Wound:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_Wound:GetHeight();
		end	

		if plvl >= 68 then 
			ConROC_SM_PoisonMH_Anesthetic:Show(); 
			ConROC_SM_PoisonMH_Anesthetic:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			lastPoison = ConROC_SM_PoisonMH_Anesthetic;
		else
			ConROC_SM_PoisonMH_Anesthetic:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_Anesthetic:GetHeight();
		end		
		
		if plvl >= 20 then
			ConROC_SM_PoisonMH_None:Show(); 
			ConROC_SM_PoisonMH_None:SetPoint("TOPLEFT", lastPoison, "BOTTOMLEFT", 0, 0);
			lastPoison = ConROC_SM_PoisonMH_None;
		else
			ConROC_SM_PoisonMH_None:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonMH_None:GetHeight();
		end
		
		if lastPoison == ConROCRadioFrame1 then
			ConROCRadioHeader1:Hide();
			ConROCRadioFrame1:Hide();
			scrollHeight = scrollHeight - ConROCRadioHeader1:GetHeight() - ConROCRadioFrame1:GetHeight();
		end
		
		if ConROCRadioFrame1:IsVisible() then
			lastFrame = lastPoison;
		else
			lastFrame = ConROCRadioHeader1;
		end
	end

	if ConROCRadioHeader2 ~= nil then
		if lastFrame == lastPoison then
			ConROCRadioHeader2:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5);
		else 
			ConROCRadioHeader2:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5);
		end	

		lastPoisonOH = ConROCRadioFrame2;
		
	--Poisons OH
		if plvl >= 20 then 
			ConROC_SM_PoisonOH_Instant:Show();
			lastPoisonOH = ConROC_SM_PoisonOH_Instant;
		else
			ConROC_SM_PoisonOH_Instant:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_Instant:GetHeight();
		end

		if plvl >= 20 then 
			ConROC_SM_PoisonOH_Crippling:Show(); 
			ConROC_SM_PoisonOH_Crippling:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			lastPoisonOH = ConROC_SM_PoisonOH_Crippling;
		else
			ConROC_SM_PoisonOH_Crippling:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_Crippling:GetHeight();
		end
		
		if plvl >= 24 then 
			ConROC_SM_PoisonOH_Mindnumbing:Show(); 
			ConROC_SM_PoisonOH_Mindnumbing:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			lastPoisonOH = ConROC_SM_PoisonOH_Mindnumbing;
		else
			ConROC_SM_PoisonOH_Mindnumbing:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_Mindnumbing:GetHeight();
		end		
		
		if plvl >= 30 then
			ConROC_SM_PoisonOH_Deadly:Show(); 
			ConROC_SM_PoisonOH_Deadly:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			lastPoisonOH = ConROC_SM_PoisonOH_Deadly;
		else
			ConROC_SM_PoisonOH_Deadly:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_Deadly:GetHeight();
		end

		if plvl >= 32 then 
			ConROC_SM_PoisonOH_Wound:Show(); 
			ConROC_SM_PoisonOH_Wound:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			lastPoisonOH = ConROC_SM_PoisonOH_Wound;
		else
			ConROC_SM_PoisonOH_Wound:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_Wound:GetHeight();
		end	

		if plvl >= 68 then 
			ConROC_SM_PoisonOH_Anesthetic:Show(); 
			ConROC_SM_PoisonOH_Anesthetic:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			lastPoisonOH = ConROC_SM_PoisonOH_Anesthetic;
		else
			ConROC_SM_PoisonOH_Anesthetic:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_Anesthetic:GetHeight();
		end		
		
		if plvl >= 20 then
			ConROC_SM_PoisonOH_None:Show(); 
			ConROC_SM_PoisonOH_None:SetPoint("TOPLEFT", lastPoisonOH, "BOTTOMLEFT", 0, 0);
			lastPoisonOH = ConROC_SM_PoisonOH_None;
		else
			ConROC_SM_PoisonOH_None:Hide();
			scrollHeight = scrollHeight - ConROC_SM_PoisonOH_None:GetHeight();
		end

		if lastPoisonOH == ConROCRadioFrame2 then
			ConROCRadioHeader2:Hide();
			ConROCRadioFrame2:Hide();
			scrollHeight = scrollHeight - ConROCRadioHeader2:GetHeight() - ConROCRadioFrame2:GetHeight();
		end
		
		if ConROCRadioFrame2:IsVisible() then
			lastFrame = lastPoisonOH;
		else
			lastFrame = ConROCRadioHeader2;
		end
	end
	
	if ConROCCheckHeader1 ~= nil then
		if lastFrame == lastPoison or lastFrame == lastPoisonOH then
			ConROCCheckHeader1:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5);
		else 
			ConROCCheckHeader1:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5);
		end	

		lastDebuff = ConROCCheckFrame1;
		
	--Debuffs
		if plvl >= 10 then 
			ConROC_SM_Debuff_SliceandDice:Show();
			lastDebuff = ConROC_SM_Debuff_SliceandDice;
		else
			ConROC_SM_Debuff_SliceandDice:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Debuff_SliceandDice:GetHeight() * checkBoxScale);
		end		
		
		if plvl >= 14 then 
			ConROC_SM_Debuff_Garrote:Show();
			ConROC_SM_Debuff_Garrote:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			lastDebuff = ConROC_SM_Debuff_Garrote;
		else
			ConROC_SM_Debuff_Garrote:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Debuff_Garrote:GetHeight() * checkBoxScale);
		end

		if plvl >= 14 then 
			ConROC_SM_Debuff_ExposeArmor:Show(); 
			ConROC_SM_Debuff_ExposeArmor:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			lastDebuff = ConROC_SM_Debuff_ExposeArmor;
		else
			ConROC_SM_Debuff_ExposeArmor:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Debuff_ExposeArmor:GetHeight() * checkBoxScale);
		end
		
		if plvl >= 20 then 
			ConROC_SM_Debuff_Rupture:Show(); 
			ConROC_SM_Debuff_Rupture:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			lastDebuff = ConROC_SM_Debuff_Rupture;
		else
			ConROC_SM_Debuff_Rupture:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Debuff_Rupture:GetHeight() * checkBoxScale);
		end		
		
		if plvl >= 30 then
			ConROC_SM_Debuff_Hemorrhage:Show(); 
			ConROC_SM_Debuff_Hemorrhage:SetPoint("TOPLEFT", lastDebuff, "BOTTOMLEFT", 0, 0);
			lastDebuff = ConROC_SM_Debuff_Hemorrhage;
		else
			ConROC_SM_Debuff_Hemorrhage:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Debuff_Hemorrhage:GetHeight() * checkBoxScale);
		end

		if lastDebuff == ConROCCheckFrame1 then
			ConROCCheckHeader1:Hide();
			ConROCCheckFrame1:Hide();
			scrollHeight = scrollHeight - ConROCCheckHeader1:GetHeight() - ConROCCheckFrame1:GetHeight();
		end
		
		if ConROCCheckFrame1:IsVisible() then
			lastFrame = lastDebuff;
		else
			lastFrame = ConROCCheckHeader1;
		end
	end

	if ConROCCheckHeader2 ~= nil then
		if lastFrame == lastPoison or lastFrame == lastPoisonOH or lastFrame == lastDebuff then
			ConROCCheckHeader2:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5);
		else 
			ConROCCheckHeader2:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5);
		end	

		lastStun = ConROCCheckFrame2;
		
	--Stuns
		if plvl >= 6 then 
			ConROC_SM_Stun_Gouge:Show();
			lastStun = ConROC_SM_Stun_Gouge;
		else
			ConROC_SM_Stun_Gouge:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Stun_Gouge:GetHeight() * checkBoxScale);
		end

		if plvl >= 26 and IsSpellKnown(ids.Ass_Ability.CheapShot) then 
			ConROC_SM_Stun_CheapShot:Show(); 
			ConROC_SM_Stun_CheapShot:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			lastStun = ConROC_SM_Stun_CheapShot;
		else
			ConROC_SM_Stun_CheapShot:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Stun_CheapShot:GetHeight() * checkBoxScale);
		end
		
		if plvl >= 30 then 
			ConROC_SM_Stun_KidneyShot:Show(); 
			ConROC_SM_Stun_KidneyShot:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			lastStun = ConROC_SM_Stun_KidneyShot;
		else
			ConROC_SM_Stun_KidneyShot:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Stun_KidneyShot:GetHeight() * checkBoxScale);
		end		
		
		if plvl >= 34 and IsSpellKnown(ids.Sub_Ability.Blind) then
			ConROC_SM_Stun_Blind:Show(); 
			ConROC_SM_Stun_Blind:SetPoint("TOPLEFT", lastStun, "BOTTOMLEFT", 0, 0);
			lastStun = ConROC_SM_Stun_Blind;
		else
			ConROC_SM_Stun_Blind:Hide();
			scrollHeight = scrollHeight - (ConROC_SM_Stun_Blind:GetHeight() * checkBoxScale);
		end
		
		if lastStun == ConROCCheckFrame2 then
			ConROCCheckHeader2:Hide();
			ConROCCheckFrame2:Hide();
			scrollHeight = scrollHeight - ConROCCheckHeader2:GetHeight() - ConROCCheckFrame2:GetHeight();
		end
		
		if ConROCCheckFrame2:IsVisible() then
			lastFrame = lastStun;
		else
			lastFrame = ConROCCheckHeader2;
		end
	end	
	-- Update for scrolling window -- Start
	if showOptions then
		ConROCSpellmenuHolder:Show()
		ConROCScrollChild:Show();
	end
	if fixOptionsWidth then
		ConROCSpellmenuFrame:SetWidth(frameWidth);
		ConROC:updateScrollArea()
	end
	-- end
end
function ConROC:updateScrollArea()

	ConROCScrollChild:SetHeight(math.ceil(scrollHeight +10));
	--print("scrollHeight",math.ceil(scrollHeight))
	--print("ConROCScrollChild:GetHeight()",math.ceil(ConROCScrollChild:GetHeight()))
	--print("ConROCSpellmenuScrollFrame:GetHeight()",math.ceil(ConROCSpellmenuScrollFrame:GetHeight()))

	if scrollHeight or ConROCScrollChild:GetHeight() > ConROCSpellmenuScrollFrame:GetHeight() then
		ConROCSpellmenuScrollFrame.ScrollBar:Show();
		ConROCScrollChild:SetWidth(ConROCSpellmenuScrollFrame:GetWidth()-20);
		scrollContentWidth = ConROCScrollChild:GetWidth()-10;
		--print("SCROLL ! scrollContentWidth",math.ceil(scrollContentWidth));
	else
		ConROCSpellmenuScrollFrame.ScrollBar:Hide();
		ConROCScrollChild:SetWidth(ConROCSpellmenuScrollFrame:GetWidth());
		scrollContentWidth = ConROCScrollChild:GetWidth();
		--print("scrollContentWidth",math.ceil(scrollContentWidth));
	end

end

function ConROC:RoleProfile()
	if ConROC:CheckBox(ConROC_SM_Role_Melee) then
		ConROC_SM_PoisonMH_Instant:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Instant);
		ConROC_SM_PoisonMH_Crippling:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Crippling);
		ConROC_SM_PoisonMH_Mindnumbing:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Mindnumbing);
		ConROC_SM_PoisonMH_Deadly:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Deadly);
		ConROC_SM_PoisonMH_Wound:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Wound);
		ConROC_SM_PoisonMH_Anesthetic:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_Anesthetic);
		ConROC_SM_PoisonMH_None:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonMH_None);

		ConROC_SM_PoisonOH_Instant:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Instant);
		ConROC_SM_PoisonOH_Crippling:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Crippling);
		ConROC_SM_PoisonOH_Mindnumbing:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Mindnumbing);
		ConROC_SM_PoisonOH_Deadly:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Deadly);
		ConROC_SM_PoisonOH_Wound:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Wound);
		ConROC_SM_PoisonOH_Anesthetic:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic);
		ConROC_SM_PoisonOH_None:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_None);

		ConROC_SM_Debuff_SliceandDice:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_SliceandDice);		
		ConROC_SM_Debuff_Garrote:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_Garrote);
		ConROC_SM_Debuff_ExposeArmor:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_ExposeArmor);
		ConROC_SM_Debuff_Rupture:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_Rupture);
		ConROC_SM_Debuff_Hemorrhage:SetChecked(ConROCRogueSpells.ConROC_Melee_Debuff_Hemorrhage);

		ConROC_SM_Stun_Gouge:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_Gouge);
		ConROC_SM_Stun_CheapShot:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_CheapShot);
		ConROC_SM_Stun_KidneyShot:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_KidneyShot);
		ConROC_SM_Stun_Blind:SetChecked(ConROCRogueSpells.ConROC_Melee_Stun_Blind);
		
	elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
		ConROC_SM_PoisonMH_Instant:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Instant);
		ConROC_SM_PoisonMH_Crippling:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Crippling);
		ConROC_SM_PoisonMH_Mindnumbing:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Mindnumbing);
		ConROC_SM_PoisonMH_Deadly:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Deadly);
		ConROC_SM_PoisonMH_Wound:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_Wound);
		ConROC_SM_PoisonMH_Anesthetic:SetChecked(ConROCRogueSpells.ConROC_Melee_PoisonOH_Anesthetic);
		ConROC_SM_PoisonMH_None:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonMH_None);	

		ConROC_SM_PoisonOH_Instant:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Instant);
		ConROC_SM_PoisonOH_Crippling:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Crippling);
		ConROC_SM_PoisonOH_Mindnumbing:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Mindnumbing);
		ConROC_SM_PoisonOH_Deadly:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Deadly);
		ConROC_SM_PoisonOH_Wound:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Wound);
		ConROC_SM_PoisonOH_Anesthetic:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_Anesthetic);
		ConROC_SM_PoisonOH_None:SetChecked(ConROCRogueSpells.ConROC_PvP_PoisonOH_None);	

		ConROC_SM_Debuff_SliceandDice:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_SliceandDice);		
		ConROC_SM_Debuff_Garrote:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_Garrote);
		ConROC_SM_Debuff_ExposeArmor:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_ExposeArmor);
		ConROC_SM_Debuff_Rupture:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_Rupture);
		ConROC_SM_Debuff_Hemorrhage:SetChecked(ConROCRogueSpells.ConROC_PvP_Debuff_Hemorrhage);

		ConROC_SM_Stun_Gouge:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_Gouge);
		ConROC_SM_Stun_CheapShot:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_CheapShot);
		ConROC_SM_Stun_KidneyShot:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_KidneyShot);
		ConROC_SM_Stun_Blind:SetChecked(ConROCRogueSpells.ConROC_PvP_Stun_Blind);	
	end
end