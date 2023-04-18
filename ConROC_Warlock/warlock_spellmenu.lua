local ConROC_Warlock, ids = ...;

local lastFrame = 0;
local lastDemon = 0;
local lastCurse = 0;
local lastDebuff = 0;
local lastSpell = 0;
local lastOption = 0;

local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Caster"] = true,

	["ConROC_Caster_Demon_Imp"] = true,
	["ConROC_Caster_Curse_Weakness"] = true,
	["ConROC_Caster_Debuff_Immolate"] = true,
	["ConROC_Caster_Debuff_Corruption"] = true,
	["ConROC_Caster_Debuff_SiphonLife"] = true,
	["ConROC_Caster_Spell_ShadowBolt"] = true,
	["ConROC_Caster_Option_SoulShard"] = 5,
	["ConROC_PvP_Option_SoulShard"] = 5,
	["ConROC_Caster_Option_UseWand"] = true,
}


ConROCWarlockSpells = ConROCWarlockSpells or defaults;

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
			radio1:SetChecked(ConROCWarlockSpells.ConROC_SM_Role_Caster);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Caster:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCWarlockSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCWarlockSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio1text:SetText("Caster");
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('Spellmenu_radio1_Texture', 'ARTWORK');
				r1t:SetTexture('Interface\\AddOns\\ConROC\\images\\magiccircle');
				r1t:SetBlendMode('BLEND');
				local color = ConROC.db.profile.purgeOverlayColor;
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
			radio4:SetChecked(ConROCWarlockSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Caster:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCWarlockSpells.ConROC_SM_Role_Caster = ConROC_SM_Role_Caster:GetChecked();
					ConROCWarlockSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
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
	ConROC:CheckHeader1();
	ConROC:RadioHeader3();
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

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_RadioHeader1", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Demons");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame1_OpenButton', frame)
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
					ConROCRadioFrame1:Show();
					ConROC_RadioFrame1_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_RadioFrame1_CloseButton', frame)
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

		lastDemon = frame;
		lastFrame = frame;
		
	--Imp
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Demon_Imp", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.Demo_Ability.SummonImp);
			radio1:SetPoint("TOP", ConROCRadioFrame1, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio1:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Imp);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Imp);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Demon_Imp:SetChecked(true);
					ConROC_SM_Demon_Voidwalker:SetChecked(false);
					ConROC_SM_Demon_Succubus:SetChecked(false);
					ConROC_SM_Demon_Felhunter:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
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
		
		lastDemon = radio1;
		lastFrame = radio1;
		
	--Voidwalker
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Demon_Voidwalker", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.Demo_Ability.SummonVoidwalker);
			radio2:SetPoint("TOP", lastDemon, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio2:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Voidwalker);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Voidwalker);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Demon_Imp:SetChecked(false);
					ConROC_SM_Demon_Voidwalker:SetChecked(true);
					ConROC_SM_Demon_Succubus:SetChecked(false);
					ConROC_SM_Demon_Felhunter:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
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

		lastDemon = radio2;
		lastFrame = radio2;
		
	--Succubus
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Demon_Succubus", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		local r3spellName, _, r3tspell = GetSpellInfo(ids.Demo_Ability.SummonSuccubus);
			radio3:SetPoint("TOP", lastDemon, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio3:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Succubus);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Succubus);
			end
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_Demon_Imp:SetChecked(false);
					ConROC_SM_Demon_Voidwalker:SetChecked(false);
					ConROC_SM_Demon_Succubus:SetChecked(true);
					ConROC_SM_Demon_Felhunter:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
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

		lastDemon = radio3;
		lastFrame = radio3;
		
	--Felhunter
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Demon_Felhunter", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
		local r4spellName, _, r4tspell = GetSpellInfo(ids.Demo_Ability.SummonFelhunter);
			radio4:SetPoint("TOP", lastDemon, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio4:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Felhunter);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Felhunter);
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Demon_Imp:SetChecked(false);
					ConROC_SM_Demon_Voidwalker:SetChecked(false);
					ConROC_SM_Demon_Succubus:SetChecked(false);
					ConROC_SM_Demon_Felhunter:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Demon_Imp = ConROC_SM_Demon_Imp:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Voidwalker = ConROC_SM_Demon_Voidwalker:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Succubus = ConROC_SM_Demon_Succubus:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Demon_Felhunter = ConROC_SM_Demon_Felhunter:GetChecked();
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

		lastDemon = radio4;		
		lastFrame = radio4;

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

		local fontCurses = frame:CreateFontString("ConROC_Spellmenu_RadioHeader2", "ARTWORK", "GameFontGreenSmall");
			fontCurses:SetText("Curses");
			fontCurses:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame2_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontCurses, "RIGHT", 0, 0)
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
				tbutton:SetPoint("LEFT", fontCurses, "RIGHT", 0, 0)
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

		lastCurse = frame;
		lastFrame = frame;
		
	--Curse of Weakness
		local radio0 = CreateFrame("CheckButton", "ConROC_SM_Curse_Weakness", frame, "UIRadioButtonTemplate");
		local radio0text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		local r0tspellName, _, r0tspell = GetSpellInfo(ids.Aff_Ability.CurseofWeaknessRank1);
			radio0:SetPoint("TOP", ConROCRadioFrame2, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio0:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Weakness);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio0:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Weakness);	
			end
			radio0:SetScript("OnClick",
				function()
					ConROC_SM_Curse_Weakness:SetChecked(true);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio0text:SetText(r0tspellName);				
		local r0t = radio0.texture;
			if not r0t then
				r0t = radio0:CreateTexture('RadioFrame2_radio0_Texture', 'ARTWORK');
				r0t:SetTexture(r0tspell);
				r0t:SetBlendMode('BLEND');
				radio0.texture = r0t;
			end			
			r0t:SetScale(0.2);
			r0t:SetPoint("LEFT", radio0, "RIGHT", 8, 0);
			radio0text:SetPoint('LEFT', r0t, 'RIGHT', 5, 0);
		
		lastCurse = radio0;
		lastFrame = radio0;
		
	--Curse of Agony
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Curse_Agony", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		local r1tspellName, _, r1tspell = GetSpellInfo(ids.Aff_Ability.CurseofAgonyRank1);
			radio1:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio1:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Agony);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Agony);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(true);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio1text:SetText(r1tspellName);				
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
		
		lastCurse = radio1;
		lastFrame = radio1;
		
	--Curse of Recklessness
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Curse_Recklessness", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
		local r2tspellName, _, r2tspell = GetSpellInfo(ids.Aff_Ability.CurseofRecklessnessRank1);
			radio2:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio2:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(true);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio2text:SetText(r2tspellName);					
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

		lastCurse = radio2;
		lastFrame = radio2;
		
	--Curse of Tongues
		local radio3 = CreateFrame("CheckButton", "ConROC_SM_Curse_Tongues", frame, "UIRadioButtonTemplate");
		local radio3text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		local r3tspellName, _, r3tspell = GetSpellInfo(ids.Aff_Ability.CurseofTonguesRank1);
			radio3:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio3:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Tongues);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio3:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Tongues);
			end
			radio3:SetScript("OnClick", 
			  function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(true);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio3text:SetText(r3tspellName);					
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

		lastCurse = radio3;
		lastFrame = radio3;
		
	--Curse of Exhaustion
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Curse_Exhaustion", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
		local r4tspellName, _, r4tspell = GetSpellInfo(ids.Aff_Ability.CurseofExhaustion);
			radio4:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio4:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio4:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion);
			end
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(true);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio4text:SetText(r4tspellName);
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

		lastCurse = radio4;		
		lastFrame = radio4;

	--Curse of the Elements
		local radio5 = CreateFrame("CheckButton", "ConROC_SM_Curse_Elements", frame, "UIRadioButtonTemplate");
		local radio5text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
		local r5tspellName, _, r5tspell = GetSpellInfo(ids.Aff_Ability.CurseoftheElementsRank1);
			radio5:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio5:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Elements);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio5:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Elements);
			end
			radio5:SetScript("OnClick", 
			  function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(true);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio5text:SetText(r5tspellName);
		local r5t = radio5.texture;

			if not r5t then
				r5t = radio5:CreateTexture('RadioFrame2_radio5_Texture', 'ARTWORK');
				r5t:SetTexture(r5tspell);
				r5t:SetBlendMode('BLEND');
				radio5.texture = r5t;
			end			
			r5t:SetScale(0.2);			
			r5t:SetPoint("LEFT", radio5, "RIGHT", 8, 0);
			radio5text:SetPoint('LEFT', r5t, 'RIGHT', 5, 0);

		lastCurse = radio5;		
		lastFrame = radio5;

	--Curse of Shadow
		local radio6 = CreateFrame("CheckButton", "ConROC_SM_Curse_Shadow", frame, "UIRadioButtonTemplate");
		local radio6text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
		local r6tspellName, _, r6tspell = GetSpellInfo(ids.Aff_Ability.CurseofShadowRank1);
			radio6:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio6:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Shadow);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio6:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Shadow);
			end
			radio6:SetScript("OnClick", 
			  function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(true);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio6text:SetText(r6tspellName);
		local r6t = radio6.texture;

			if not r6t then
				r6t = radio6:CreateTexture('RadioFrame2_radio6_Texture', 'ARTWORK');
				r6t:SetTexture(r6tspell);
				r6t:SetBlendMode('BLEND');
				radio6.texture = r6t;
			end			
			r6t:SetScale(0.2);			
			r6t:SetPoint("LEFT", radio6, "RIGHT", 8, 0);
			radio6text:SetPoint('LEFT', r6t, 'RIGHT', 5, 0);

		lastCurse = radio6;		
		lastFrame = radio6;

	--Curse of Doom
		local radio7 = CreateFrame("CheckButton", "ConROC_SM_Curse_Doom", frame, "UIRadioButtonTemplate");
		local radio7text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
		local r7tspellName, _, r7tspell = GetSpellInfo(ids.Aff_Ability.CurseofDoom);
			radio7:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio7:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Doom);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio7:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Doom);
			end
			radio7:SetScript("OnClick", 
			  function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(true);
					ConROC_SM_Curse_None:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio7text:SetText(r7tspellName);
		local r7t = radio7.texture;

			if not r7t then
				r7t = radio7:CreateTexture('RadioFrame2_radio7_Texture', 'ARTWORK');
				r7t:SetTexture(r7tspell);
				r7t:SetBlendMode('BLEND');
				radio7.texture = r7t;
			end			
			r7t:SetScale(0.2);			
			r7t:SetPoint("LEFT", radio7, "RIGHT", 8, 0);
			radio7text:SetPoint('LEFT', r7t, 'RIGHT', 5, 0);

		lastCurse = radio7;		
		lastFrame = radio7;

	--None
		local radio8 = CreateFrame("CheckButton", "ConROC_SM_Curse_None", frame, "UIRadioButtonTemplate");
		local radio8text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			radio8:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio8:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_None);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio8:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_None);
			end
			radio8:SetScript("OnClick", 
			  function()
					ConROC_SM_Curse_Weakness:SetChecked(false);
					ConROC_SM_Curse_Agony:SetChecked(false);
					ConROC_SM_Curse_Recklessness:SetChecked(false);
					ConROC_SM_Curse_Tongues:SetChecked(false);
					ConROC_SM_Curse_Exhaustion:SetChecked(false);
					ConROC_SM_Curse_Elements:SetChecked(false);
					ConROC_SM_Curse_Shadow:SetChecked(false);
					ConROC_SM_Curse_Doom:SetChecked(false);
					ConROC_SM_Curse_None:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Curse_None = ConROC_SM_Curse_None:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Curse_Weakness = ConROC_SM_Curse_Weakness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Agony = ConROC_SM_Curse_Agony:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness = ConROC_SM_Curse_Recklessness:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Tongues = ConROC_SM_Curse_Tongues:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion = ConROC_SM_Curse_Exhaustion:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_theElements = ConROC_SM_Curse_Elements:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Shadow = ConROC_SM_Curse_Shadow:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_Doom = ConROC_SM_Curse_Doom:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Curse_None = ConROC_SM_Curse_None:GetChecked();
					end
				end
			);
			radio8text:SetText("None");
			radio8text:SetPoint('LEFT', radio8, 'RIGHT', 20, 0);

		lastSting = radio8;		
		lastFrame = radio8;
		
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

		local fontDemons = frame:CreateFontString("ConROC_Spellmenu_CheckHeader1", "ARTWORK", "GameFontGreenSmall");
			fontDemons:SetText("Dots");
			fontDemons:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame1_OpenButton', frame)
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
					ConROCCheckFrame1:Show();
					ConROC_CheckFrame1_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame1_CloseButton', frame)
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

		lastDebuff = frame;
		lastFrame = frame;
		
	--Immolate
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Dest_Ability.ImmolateRank1); 
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Debuff_Immolate", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check1:SetChecked(ConROCWarlockSpells.ConROC_Caster_Debuff_Immolate);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCWarlockSpells.ConROC_PvP_Debuff_Immolate);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Debuff_Immolate = ConROC_SM_Debuff_Immolate:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Debuff_Immolate = ConROC_SM_Debuff_Immolate:GetChecked();
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
			
		lastDebuff = check1;
		lastFrame = check1;

	--Corruption
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Aff_Ability.CorruptionRank1); 
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Debuff_Corruption", frame, "UICheckButtonTemplate");
		local check2text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check2:SetChecked(ConROCWarlockSpells.ConROC_Caster_Debuff_Corruption);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCWarlockSpells.ConROC_PvP_Debuff_Corruption);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Debuff_Corruption = ConROC_SM_Debuff_Corruption:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Debuff_Corruption = ConROC_SM_Debuff_Corruption:GetChecked();
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
			
		lastDebuff = check2;
		lastFrame = check2;

	--Siphon Life
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Aff_Ability.SiphonLifeRank1); 
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Debuff_SiphonLife", frame, "UICheckButtonTemplate");
		local check3text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check3:SetChecked(ConROCWarlockSpells.ConROC_Caster_Debuff_SiphonLife);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCWarlockSpells.ConROC_PvP_Debuff_SiphonLife);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Debuff_SiphonLife = ConROC_SM_Debuff_SiphonLife:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Debuff_SiphonLife = ConROC_SM_Debuff_SiphonLife:GetChecked();
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
			
		lastDebuff = check3;
		lastFrame = check3;
		
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

		local fontSpells = frame:CreateFontString("ConROC_Spellmenu_RadioHeader3", "ARTWORK", "GameFontGreenSmall");
			fontSpells:SetText("Fillers");
			fontSpells:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_RadioFrame3_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontSpells, "RIGHT", 0, 0)
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
				tbutton:SetPoint("LEFT", fontSpells, "RIGHT", 0, 0)
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

		lastSpell = frame;
		lastFrame = frame;
		
	--Shadow Bolt
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Spell_ShadowBolt", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		local r1spellName, _, r1tspell = GetSpellInfo(ids.Dest_Ability.ShadowBoltRank1);
			radio1:SetPoint("TOP", ConROCRadioFrame3, "BOTTOM", -75, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio1:SetChecked(ConROCWarlockSpells.ConROC_Caster_Spell_ShadowBolt);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio1:SetChecked(ConROCWarlockSpells.ConROC_PvP_Spell_ShadowBolt);	
			end
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Spell_ShadowBolt:SetChecked(true);
					ConROC_SM_Spell_SearingPain:SetChecked(false);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Spell_ShadowBolt = ConROC_SM_Spell_ShadowBolt:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Spell_SearingPain = ConROC_SM_Spell_SearingPain:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Spell_ShadowBolt = ConROC_SM_Spell_ShadowBolt:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Spell_SearingPain = ConROC_SM_Spell_SearingPain:GetChecked();
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
		
		lastSpell = radio1;
		lastFrame = radio1;
		
	--Searing Pain
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Spell_SearingPain", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
		local r2spellName, _, r2tspell = GetSpellInfo(ids.Dest_Ability.SearingPainRank1);
			radio2:SetPoint("TOP", lastSpell, "BOTTOM", 0, 0);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				radio2:SetChecked(ConROCWarlockSpells.ConROC_Caster_Spell_SearingPain);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				radio2:SetChecked(ConROCWarlockSpells.ConROC_PvP_Spell_SearingPain);
			end
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Spell_ShadowBolt:SetChecked(false);
					ConROC_SM_Spell_SearingPain:SetChecked(true);
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Spell_ShadowBolt = ConROC_SM_Spell_ShadowBolt:GetChecked();
						ConROCWarlockSpells.ConROC_Caster_Spell_SearingPain = ConROC_SM_Spell_SearingPain:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Spell_ShadowBolt = ConROC_SM_Spell_ShadowBolt:GetChecked();
						ConROCWarlockSpells.ConROC_PvP_Spell_SearingPain = ConROC_SM_Spell_SearingPain:GetChecked();
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

		lastSpell = radio2;
		lastFrame = radio2;
		
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


	--Soul Shard Count
		local e1titemName = GetSpellInfo(23464); 
		local _, _, e1titem = GetSpellInfo(23015);
		local edit1 = CreateFrame("Frame", "ConROC_SM_Option_SoulShard_Frame", frame);
		edit1:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},});
		edit1:SetBackdropColor(0, 0, 0);
		edit1:SetPoint("TOP", ConROCCheckFrame2, "BOTTOM", -75, 0);
		edit1:SetSize(15, 15);
		
		local box1 = CreateFrame("EditBox", "ConROC_SM_Option_SoulShard", edit1);	
		box1:SetPoint("TOP", 0, 0);
		box1:SetPoint("BOTTOM", 0, 0);
		box1:SetMultiLine(false);
		box1:SetFontObject(GameFontNormalSmall);
		box1:SetNumeric(true);
		box1:SetAutoFocus(false);
		box1:SetMaxLetters("2");
		box1:SetWidth(20);
		box1:SetTextInsets(3, 0, 0, 0);
		if ConROC:CheckBox(ConROC_SM_Role_Caster) then
			box1:SetNumber(ConROCWarlockSpells.ConROC_Caster_Option_SoulShard);
		elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
			box1:SetNumber(ConROCWarlockSpells.ConROC_PvP_Option_SoulShard);
		end
		box1:SetScript("OnEditFocusLost", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Caster) then
					ConROCWarlockSpells.ConROC_Caster_Option_SoulShard = ConROC_SM_Option_SoulShard:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarlockSpells.ConROC_PvP_Option_SoulShard = ConROC_SM_Option_SoulShard:GetNumber();
				end
				box1:ClearFocus()
			end);
		box1:SetScript("OnEnterPressed", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Caster) then
					ConROCWarlockSpells.ConROC_Caster_Option_SoulShard = ConROC_SM_Option_SoulShard:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarlockSpells.ConROC_PvP_Option_SoulShard = ConROC_SM_Option_SoulShard:GetNumber();
				end
				box1:ClearFocus()
			end);
		box1:SetScript("OnEscapePressed", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Caster) then
					ConROCWarlockSpells.ConROC_Caster_Option_SoulShard = ConROC_SM_Option_SoulShard:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarlockSpells.ConROC_PvP_Option_SoulShard = ConROC_SM_Option_SoulShard:GetNumber();
				end
				box1:ClearFocus()
			end);				

		local e1t = edit1:CreateTexture('CheckFrame2_edit1_Texture', 'ARTWORK');
		e1t:SetTexture(e1titem);
		e1t:SetBlendMode('BLEND');
		e1t:SetScale(0.2);
		e1t:SetPoint("LEFT", edit1, "RIGHT", 20, 0);
		
		local edit1text = edit1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");	
		edit1text:SetText(e1titemName);	
		edit1text:SetPoint('LEFT', e1t, 'RIGHT', 5, 0);
			
		lastOption = edit1;
		lastFrame = edit1;
		
	--Use Wand
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Option_UseWand", frame, "UICheckButtonTemplate");
		local check1text = check1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", lastOption, "BOTTOM", 0, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check1:SetChecked(ConROCWarlockSpells.ConROC_Caster_Option_UseWand);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCWarlockSpells.ConROC_PvP_Option_UseWand);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Option_UseWand = ConROC_SM_Option_UseWand:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Option_UseWand = ConROC_SM_Option_UseWand:GetChecked();
					end
				end);
			check1text:SetText("Use Wand");
			check1text:SetScale(2);
			check1text:SetPoint("LEFT", check1, "RIGHT", 20, 0);
			
		lastOption = check1;
		lastFrame = check1;

	--AoE Toggle Button
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Option_AoE", frame, "UICheckButtonTemplate");
		local check2text = check2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", lastOption, "BOTTOM", 0, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Caster) then
				check2:SetChecked(ConROCWarlockSpells.ConROC_Caster_Option_AoE);
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
				check2:SetChecked(ConROCWarlockSpells.ConROC_PvP_Option_AoE);
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
					if ConROC:CheckBox(ConROC_SM_Role_Caster) then
						ConROCWarlockSpells.ConROC_Caster_Option_AoE = ConROC_SM_Option_AoE:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarlockSpells.ConROC_PvP_Option_AoE = ConROC_SM_Option_AoE:GetChecked();
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
		lastDemon = ConROCRadioFrame1;
		
	--Demons
		if plvl >= 2 and IsSpellKnown(ids.Demo_Ability.SummonImp) then 
			ConROC_SM_Demon_Imp:Show();
			lastDemon = ConROC_SM_Demon_Imp;
		else
			ConROC_SM_Demon_Imp:Hide();
		end

		if plvl >= 10 and IsSpellKnown(ids.Demo_Ability.SummonVoidwalker) then 
			ConROC_SM_Demon_Voidwalker:Show(); 
			ConROC_SM_Demon_Voidwalker:SetPoint("TOP", lastDemon, "BOTTOM", 0, 0);
			lastDemon = ConROC_SM_Demon_Voidwalker;
		else
			ConROC_SM_Demon_Voidwalker:Hide();
		end
		
		if plvl >= 20 and IsSpellKnown(ids.Demo_Ability.SummonSuccubus) then 
			ConROC_SM_Demon_Succubus:Show(); 
			ConROC_SM_Demon_Succubus:SetPoint("TOP", lastDemon, "BOTTOM", 0, 0);
			lastDemon = ConROC_SM_Demon_Succubus;
		else
			ConROC_SM_Demon_Succubus:Hide();
		end		
		
		if plvl >= 30 and IsSpellKnown(ids.Demo_Ability.SummonFelhunter) then
			ConROC_SM_Demon_Felhunter:Show(); 
			ConROC_SM_Demon_Felhunter:SetPoint("TOP", lastDemon, "BOTTOM", 0, 0);
			lastDemon = ConROC_SM_Demon_Felhunter;
		else
			ConROC_SM_Demon_Felhunter:Hide();
		end

		if lastDemon == ConROCRadioFrame1 then
			ConROCRadioHeader1:Hide();
			ConROCRadioFrame1:Hide();
		end
		
		if ConROCRadioFrame1:IsVisible() then
			lastFrame = lastDemon;
		else
			lastFrame = ConROCRadioHeader1;
		end
	end

	if ConROCRadioHeader2 ~= nil then
		if lastFrame == lastDemon then
			ConROCRadioHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCRadioHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastCurse = ConROCRadioFrame2;
		
	--Curses
		if plvl >= 4 and IsSpellKnown(ids.Aff_Ability.CurseofWeaknessRank1) then 
			ConROC_SM_Curse_Weakness:Show();
			lastCurse = ConROC_SM_Curse_Weakness;
		else
			ConROC_SM_Curse_Weakness:Hide();
		end

		if plvl >= 8 and IsSpellKnown(ids.Aff_Ability.CurseofAgonyRank1) then 
			ConROC_SM_Curse_Agony:Show(); 
			ConROC_SM_Curse_Agony:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Agony;
		else
			ConROC_SM_Curse_Agony:Hide();
		end
		
		if plvl >= 14 and IsSpellKnown(ids.Aff_Ability.CurseofRecklessnessRank1) then 
			ConROC_SM_Curse_Recklessness:Show(); 
			ConROC_SM_Curse_Recklessness:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Recklessness;
		else
			ConROC_SM_Curse_Recklessness:Hide();
		end
		
		if plvl >= 26 and IsSpellKnown(ids.Aff_Ability.CurseofTonguesRank1) then 
			ConROC_SM_Curse_Tongues:Show(); 
			ConROC_SM_Curse_Tongues:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Tongues;
		else
			ConROC_SM_Curse_Tongues:Hide();
		end		
		
		if plvl >= 30 and IsSpellKnown(ids.Aff_Ability.CurseofExhaustion) then
			ConROC_SM_Curse_Exhaustion:Show(); 
			ConROC_SM_Curse_Exhaustion:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Exhaustion;
		else
			ConROC_SM_Curse_Exhaustion:Hide();
		end
		
		if plvl >= 32 and IsSpellKnown(ids.Aff_Ability.CurseoftheElementsRank1) then 
			ConROC_SM_Curse_Elements:Show(); 
			ConROC_SM_Curse_Elements:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Elements;
		else
			ConROC_SM_Curse_Elements:Hide();
		end
		
		if plvl >= 44 and IsSpellKnown(ids.Aff_Ability.CurseofShadowRank1) then 
			ConROC_SM_Curse_Shadow:Show(); 
			ConROC_SM_Curse_Shadow:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Shadow;
		else
			ConROC_SM_Curse_Shadow:Hide();
		end		
		
		if plvl >= 60 and IsSpellKnown(ids.Aff_Ability.CurseofDoom) then
			ConROC_SM_Curse_Doom:Show(); 
			ConROC_SM_Curse_Doom:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_Doom;
		else
			ConROC_SM_Curse_Doom:Hide();
		end		
		
		if plvl >= 4 and IsSpellKnown(ids.Aff_Ability.CurseofWeaknessRank1) then
			ConROC_SM_Curse_None:Show(); 
			ConROC_SM_Curse_None:SetPoint("TOP", lastCurse, "BOTTOM", 0, 0);
			lastCurse = ConROC_SM_Curse_None;
		else
			ConROC_SM_Curse_None:Hide();
		end

		if lastCurse == ConROCRadioFrame2 then
			ConROCRadioHeader2:Hide();
			ConROCRadioFrame2:Hide();
		end
		
		if ConROCRadioFrame2:IsVisible() then
			lastFrame = lastCurse;
		else
			lastFrame = ConROCRadioHeader2;
		end
	end
	
	if ConROCCheckFrame1 ~= nil then
		if lastFrame == lastDemon or lastFrame == lastCurse then
			ConROCCheckHeader1:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader1:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastDebuff = ConROCCheckFrame1;
		
	--Debuff
		if plvl >= 1 and IsSpellKnown(ids.Dest_Ability.ImmolateRank1) then 
			ConROC_SM_Debuff_Immolate:Show();
			lastDebuff = ConROC_SM_Debuff_Immolate;
		else
			ConROC_SM_Debuff_Immolate:Hide();
		end
		
		if plvl >= 4 and IsSpellKnown(ids.Aff_Ability.CorruptionRank1) then 
			ConROC_SM_Debuff_Corruption:Show();
			ConROC_SM_Debuff_Corruption:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);			
			lastDebuff = ConROC_SM_Debuff_Corruption;
		else
			ConROC_SM_Debuff_Corruption:Hide();
		end

		if plvl >= 30 and IsSpellKnown(ids.Aff_Ability.SiphonLifeRank1) then 
			ConROC_SM_Debuff_SiphonLife:Show(); 
			ConROC_SM_Debuff_SiphonLife:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_SiphonLife;
		else
			ConROC_SM_Debuff_SiphonLife:Hide();
		end

		if lastDebuff == ConROCCheckFrame1 then
			ConROCCheckHeader1:Hide();
			ConROCCheckFrame1:Hide();
		end
		
		if ConROCCheckFrame1:IsVisible() then
			lastFrame = lastDebuff;
		else
			lastFrame = ConROCCheckHeader1;
		end		
	end
	
	if ConROCRadioHeader3 ~= nil then
		if lastFrame == lastDemon or lastFrame == lastCurse or lastFrame == lastDebuff then
			ConROCRadioHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCRadioHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	
		
		lastSpell = ConROCRadioFrame3;
		
	--Spells
		if plvl >= 1 and IsSpellKnown(ids.Dest_Ability.ShadowBoltRank1) then 
			ConROC_SM_Spell_ShadowBolt:Show();
			lastSpell = ConROC_SM_Spell_ShadowBolt;
		else
			ConROC_SM_Spell_ShadowBolt:Hide();
		end

		if plvl >= 18 and IsSpellKnown(ids.Dest_Ability.SearingPainRank1) then 
			ConROC_SM_Spell_SearingPain:Show(); 
			ConROC_SM_Spell_SearingPain:SetPoint("TOP", lastSpell, "BOTTOM", 0, 0);
			lastSpell = ConROC_SM_Spell_SearingPain;
		else
			ConROC_SM_Spell_SearingPain:Hide();
		end	
		
		if lastSpell == ConROCRadioFrame3 then
			ConROCRadioHeader3:Hide();
			ConROCRadioFrame3:Hide();
		end
		
		if ConROCRadioFrame3:IsVisible() then
			lastFrame = lastSpell;
		else
			lastFrame = ConROCRadioHeader3;
		end		
	end
	
	if ConROCCheckFrame2 ~= nil then
		if lastFrame == lastDemon or lastFrame == lastCurse or lastFrame == lastDebuff or lastFrame == lastSpell then
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastOption = ConROCCheckFrame2;
		
	--Options
		if plvl >= 1 then 
			ConROC_SM_Option_SoulShard_Frame:Show();
			lastOption = ConROC_SM_Option_SoulShard_Frame;
		else
			ConROC_SM_Option_SoulShard_Frame:Hide();
		end

		if plvl >= 1 and HasWandEquipped() then
			ConROC_SM_Option_UseWand:Show();
			ConROC_SM_Option_UseWand:SetPoint("TOP", lastOption, "BOTTOM", 0, -10);
			lastOption = ConROC_SM_Option_UseWand;
		else
			ConROC_SM_Option_UseWand:Hide();
		end	
		
		if plvl >= 20 then 
			ConROC_SM_Option_AoE:Show(); 
			ConROC_SM_Option_AoE:SetPoint("TOP", lastOption, "BOTTOM", 0, 0);
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
	if ConROC:CheckBox(ConROC_SM_Role_Caster) then
		ConROC_SM_Demon_Imp:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Imp);
		ConROC_SM_Demon_Voidwalker:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Voidwalker);
		ConROC_SM_Demon_Succubus:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Succubus);
		ConROC_SM_Demon_Felhunter:SetChecked(ConROCWarlockSpells.ConROC_Caster_Demon_Felhunter);
		
		ConROC_SM_Curse_Weakness:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Weakness);
		ConROC_SM_Curse_Agony:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Agony);
		ConROC_SM_Curse_Recklessness:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Recklessness);
		ConROC_SM_Curse_Tongues:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Tongues);
		ConROC_SM_Curse_Exhaustion:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Exhaustion);
		ConROC_SM_Curse_Elements:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Elements);
		ConROC_SM_Curse_Shadow:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Shadow);
		ConROC_SM_Curse_Doom:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_Doom);
		ConROC_SM_Curse_None:SetChecked(ConROCWarlockSpells.ConROC_Caster_Curse_None);		
		
		ConROC_SM_Debuff_Immolate:SetChecked(ConROCWarlockSpells.ConROC_Caster_Debuff_Immolate);
		ConROC_SM_Debuff_Corruption:SetChecked(ConROCWarlockSpells.ConROC_Caster_Debuff_Corruption);
		ConROC_SM_Debuff_SiphonLife:SetChecked(ConROCWarlockSpells.ConROC_Caster_Debuff_SiphonLife);

		ConROC_SM_Option_SoulShard:SetNumber(ConROCWarlockSpells.ConROC_Caster_Option_SoulShard);
		ConROC_SM_Option_UseWand:SetChecked(ConROCWarlockSpells.ConROC_Caster_Option_UseWand);
		ConROC_SM_Option_AoE:SetChecked(ConROCWarlockSpells.ConROC_Caster_Option_AoE);

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
		ConROC_SM_Demon_Imp:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Imp);
		ConROC_SM_Demon_Voidwalker:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Voidwalker);
		ConROC_SM_Demon_Succubus:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Succubus);
		ConROC_SM_Demon_Felhunter:SetChecked(ConROCWarlockSpells.ConROC_PvP_Demon_Felhunter);

		ConROC_SM_Curse_Weakness:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Weakness);
		ConROC_SM_Curse_Agony:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Agony);
		ConROC_SM_Curse_Recklessness:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Recklessness);
		ConROC_SM_Curse_Tongues:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Tongues);
		ConROC_SM_Curse_Exhaustion:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Exhaustion);
		ConROC_SM_Curse_Elements:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Elements);
		ConROC_SM_Curse_Shadow:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Shadow);
		ConROC_SM_Curse_Doom:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_Doom);
		ConROC_SM_Curse_None:SetChecked(ConROCWarlockSpells.ConROC_PvP_Curse_None);	

		ConROC_SM_Debuff_Immolate:SetChecked(ConROCWarlockSpells.ConROC_PvP_Debuff_Immolate);
		ConROC_SM_Debuff_Corruption:SetChecked(ConROCWarlockSpells.ConROC_PvP_Debuff_Corruption);
		ConROC_SM_Debuff_SiphonLife:SetChecked(ConROCWarlockSpells.ConROC_PvP_Debuff_SiphonLife);
		
		ConROC_SM_Option_SoulShard:SetNumber(ConROCWarlockSpells.ConROC_PvP_Option_SoulShard);
		ConROC_SM_Option_UseWand:SetChecked(ConROCWarlockSpells.ConROC_PvP_Option_UseWand);
		ConROC_SM_Option_AoE:SetChecked(ConROCWarlockSpells.ConROC_PvP_Option_AoE);	
		
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