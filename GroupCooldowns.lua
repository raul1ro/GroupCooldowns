local _, Addon = ...;

Addon.CurrentInstance = nil;
Addon.Modules = {};

-- listener for events
Addon.Anchors = {};
local listener = CreateFrame("FRAME");
listener:RegisterEvent("ADDON_LOADED");
listener:SetScript("OnEvent", function(_, event, source, subEvent, _, _, sourceName, _, _, _, targetName, _, _, spellId, spellName) -- the last param, after spellId, is spellName. JICase

	-- initialize when addon loads
    if (event == "ADDON_LOADED" and source == "GroupCooldowns") then

		-- create the anchors
		-- controls
		local controlsAnchor = CreateFrame("Frame", nil, UIParent);
		controlsAnchor:SetSize(152, 7);
		controlsAnchor.texture = controlsAnchor:CreateTexture(nil, "BACKGROUND");
		controlsAnchor.texture:SetAllPoints();
		controlsAnchor.texture:SetColorTexture(1, 1, 1);
		controlsAnchor:SetMovable(true);
		controlsAnchor:EnableMouse(true);
		controlsAnchor:RegisterForDrag("LeftButton");
		controlsAnchor:SetScript("OnDragStart", function(self) self:StartMoving() end)
		controlsAnchor:SetScript("OnDragStop", function(self) 
			self:StopMovingOrSizing();
			GCControlsAnchorPosition = {controlsAnchor:GetPoint(0)};
		end)
		controlsAnchor.nextBar = nil;
		local controlsLabel = controlsAnchor:CreateFontString()
		controlsLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE");
		controlsLabel:SetJustifyH("CENTER");
		controlsLabel:SetJustifyV("MIDDLE");
		controlsLabel:SetPoint("CENTER");
		controlsLabel:SetText("CONTROLS");
		
		Addon.Anchors["control"] = controlsAnchor;
		
		-- cleanses
		local cleansesAnchor = CreateFrame("Frame", nil, UIParent);
		cleansesAnchor:SetSize(152, 7);
		cleansesAnchor.texture = cleansesAnchor:CreateTexture(nil, "BACKGROUND");
		cleansesAnchor.texture:SetAllPoints();
		cleansesAnchor.texture:SetColorTexture(1, 1, 1);
		cleansesAnchor:SetMovable(true);
		cleansesAnchor:EnableMouse(true);
		cleansesAnchor:RegisterForDrag("LeftButton");
		cleansesAnchor:SetScript("OnDragStart", function(self) self:StartMoving() end)
		cleansesAnchor:SetScript("OnDragStop", function(self) 
			self:StopMovingOrSizing();
			GCCleansesAnchorPosition = {cleansesAnchor:GetPoint(0)};
		end)
		cleansesAnchor.nextBar = nil;
		local cleansesLabel = cleansesAnchor:CreateFontString()
		cleansesLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE");
		cleansesLabel:SetJustifyH("CENTER");
		cleansesLabel:SetJustifyV("MIDDLE");
		cleansesLabel:SetPoint("CENTER");
		cleansesLabel:SetText("CLEANSES");
		
		Addon.Anchors["cleanse"] = cleansesAnchor;

		-- quaking
		local quakingAnchor = CreateFrame("Frame", nil, UIParent);
		quakingAnchor:SetSize(152, 7);
		quakingAnchor.texture = quakingAnchor:CreateTexture(nil, "BACKGROUND");
		quakingAnchor.texture:SetAllPoints();
		quakingAnchor.texture:SetColorTexture(1, 1, 1);
		quakingAnchor:SetMovable(true);
		quakingAnchor:EnableMouse(true);
		quakingAnchor:RegisterForDrag("LeftButton");
		quakingAnchor:SetScript("OnDragStart", function(self) self:StartMoving() end)
		quakingAnchor:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing();
			GCQuakingAnchorPosition = {quakingAnchor:GetPoint(0)};
		end)
		quakingAnchor.nextBar = nil;
		local quakingAnchorLabel = quakingAnchor:CreateFontString()
		quakingAnchorLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE");
		quakingAnchorLabel:SetJustifyH("CENTER");
		quakingAnchorLabel:SetJustifyV("MIDDLE");
		quakingAnchorLabel:SetPoint("CENTER");
		quakingAnchorLabel:SetText("QUAKING");

		Addon.Anchors["quaking"] = quakingAnchor;

		-- position anchors
		if(GCControlsAnchorPosition == nil) then GCControlsAnchorPosition = {"CENTER", nil, "CENTER", 0, 0} end
		if(GCCleansesAnchorPosition == nil) then GCCleansesAnchorPosition = {"CENTER", nil, "CENTER", 0, 0} end
		if(GCQuakingAnchorPosition == nill) then GCQuakingAnchorPosition = {"CENTER", nil, "CENTER", 0, 0} end
		controlsAnchor:SetPoint(unpack(GCControlsAnchorPosition));
		cleansesAnchor:SetPoint(unpack(GCCleansesAnchorPosition));
		quakingAnchor:SetPoint(unpack(GCQuakingAnchorPosition));

		controlsAnchor:Hide();
		cleansesAnchor:Hide();
		quakingAnchor:Hide();

		-- init GCControlsDungeon, GCControlsRaid, GCControlsEverywhere,
		if(GCControlsDungeon == nil) then GCControlsDungeon = true; end
		if(GCControlsRaid == nil) then GCControlsRaid = true; end
		if(GCControlsEverywhere == nil) then GCControlsEverywhere = false; end
		-- GCCleansesDungeon, GCCleansesRaid, GCCleansesEverywhere
		if(GCCleansesDungeon == nil) then GCCleansesDungeon = true; end
		if(GCCleansesRaid == nil) then GCCleansesRaid = true; end
		if(GCCleansesEverywhere == nil) then GCCleansesEverywhere = false; end
		-- Quaking
		if(GCQuaking == nil) then GCQuaking = true; end

		-- create interface options
		Addon.CreateInterfaceOptions();
		
		-- stop addon loeaded
		listener:UnregisterEvent("ADDON_LOADED");
		
		-- listen enter world
		listener:RegisterEvent("PLAYER_ENTERING_WORLD")

	elseif(event == "PLAYER_ENTERING_WORLD") then

		_, Addon.CurrentInstance = IsInInstance();

		-- if all of them are disabled
		-- stop combat events
		if((GCControlsDungeon or GCControlsRaid or GCControlsEverywhere or GCCleansesDungeon or GCCleansesRaid or GCCleansesEverywhere or GCQuaking) == false) then
			listener:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			return; 
		end
		
		-- if is enable everywhere
		-- listen combat events
		if(GCControlsEverywhere or GCCleansesEverywhere) then
			listener:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			return;
		end

		-- based on instance type
		-- party & (GCControlsDungeon | GCCleansesDungeon | GCQuaking)
		-- or
		-- raid & (GCControlsRaid | GCCleansesRaid)
		-- listen combat events
		if((Addon.CurrentInstance == "party" and (GCControlsDungeon or GCCleansesDungeon or GCQuaking)) or (Addon.CurrentInstance == "raid" and (GCControlsRaid or GCCleansesRaid))) then
			listener:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		else
			listener:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end

	elseif(event == "COMBAT_LOG_EVENT_UNFILTERED") then

		if(subEvent == "SPELL_CAST_SUCCESS") then

			-- check if spell is in one of the lists
			local spellData, spellType = Addon.findSpell(spellId);
			if(spellData == nil) then return; end;

			-- unpack data
			local spellCooldown, spellClass = unpack(spellData);

			--spellId, iconPath, colorRGB, playerName, targetName, spellCooldown
			Addon.Modules[spellType].StartBar(spellId, GetSpellTexture(spellId), Addon.ClassColor[spellClass], sourceName, targetName, spellCooldown);

		elseif(subEvent == "SPELL_AURA_APPLIED" and spellId == 240447) then

			Addon.Modules["quaking"].StartBar();

		end

	end

end);