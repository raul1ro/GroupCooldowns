local _, Addon = ...;

-- Get the bar from the list, if the bar is still visible
-- or create a new bar
Addon.ActiveBars = {
	["control"] = {},
	["cleanse"] = {}
};
Addon.CurrentInstance = nil;
local function getBar(spellType, spellKey, spellId, playerName, icon, colorRGB, targetName)

	-- get the bar from actives, if exists
	local bar = Addon.ActiveBars[spellType][spellKey];
	
	-- if there is no bar
	if(bar == nil) then
	
		-- request a bar
		-- and implement OnFinish
		bar = Addon.ProgressBar.getProgressBar(135, 17, "Interface\\AddOns\\GroupCooldowns\\bar_serenity", icon, playerName, spellId, colorRGB, targetName);
		function bar.OnFinish()

			local prevBar = bar.prevBar;
			local nextBar = bar.nextBar;
			
			-- reposition next bar 
			if(nextBar ~= nil) then
				nextBar.prevBar = prevBar;
				nextBar:ClearAllPoints();
				nextBar:SetPoint("BOTTOMRIGHT", prevBar, "TOPRIGHT", 0, 3);
			end
			prevBar.nextBar = nextBar;
			
			-- reset the bar
			bar:ClearAllPoints();
			bar.nextBar = nil;
			bar.prevBar = nil;
		
			-- remove it from actives
			Addon.ActiveBars[spellType][spellKey] = nil;

			bar:Hide();
		
		end

		-- add it to actives
		Addon.ActiveBars[spellType][spellKey] = bar;
		
	end
	
	return bar;
	
end

-- listener for events
Addon.Anchors = {};
local listener = CreateFrame("FRAME");
listener:RegisterEvent("ADDON_LOADED");
listener:SetScript("OnEvent", function(_, event, source, subEvent, _, _, sourceName, _, _, _, targetName, _, _, spellId, _) -- the last param, after spellId, is spellName. JICase

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
		
		-- position anchors
		if(GCControlsAnchorPosition == nil) then GCControlsAnchorPosition = {"CENTER", nil, "CENTER", 0, 0} end
		if(GCCleansesAnchorPosition == nil) then GCCleansesAnchorPosition = {"CENTER", nil, "CENTER", 0, 0} end
		controlsAnchor:SetPoint(unpack(GCControlsAnchorPosition));
		cleansesAnchor:SetPoint(unpack(GCCleansesAnchorPosition));
		
		controlsAnchor:Hide();
		cleansesAnchor:Hide();

		-- init GCControlsDungeon, GCControlsRaid, GCControlsEverywhere,
		if(GCControlsDungeon == nil) then GCControlsDungeon = true; end
		if(GCControlsRaid == nil) then GCControlsRaid = true; end
		if(GCControlsEverywhere == nil) then GCControlsEverywhere = false; end
		-- GCCleansesDungeon, GCCleansesRaid, GCCleansesEverywhere
		if(GCCleansesDungeon == nil) then GCCleansesDungeon = true; end
		if(GCCleansesRaid == nil) then GCCleansesRaid = true; end
		if(GCCleansesEverywhere == nil) then GCCleansesEverywhere = false; end

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
		if((GCControlsDungeon or GCControlsRaid or GCControlsEverywhere or GCCleansesDungeon or GCCleansesRaid or GCCleansesEverywhere) == false) then
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
		-- party & (GCControlsDungeon | GCCleansesDungeon)
		-- or
		-- raid & (GCControlsRaid | GCCleansesRaid)
		-- listen combat events
		if((Addon.CurrentInstance == "party" and (GCControlsDungeon or GCCleansesDungeon)) or (Addon.CurrentInstance == "raid" and (GCControlsRaid or GCCleansesRaid))) then
			listener:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		else
			listener:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
		
	elseif(event == "COMBAT_LOG_EVENT_UNFILTERED" and subEvent == "SPELL_CAST_SUCCESS") then

		-- check if spell is in one of the lists
		local spellData, spellType = Addon.findSpell(spellId);
		if(spellData == nil) then return; end;

		-- if is control
		-- everywhere is false
		-- and
		-- (party & GCControlsDungeon == false) or (raid & GCControlsRaid == false)
		-- do nothing > return
		if(spellType == "control" and GCControlsEverywhere == false and (
				(Addon.CurrentInstance == "party" and GCControlsDungeon == false) or
				(Addon.CurrentInstance == "raid" and GCControlsRaid == false)
		)) then return; end

		-- if is cleanse
		-- everywhere is false
		-- and
		-- (party & GCCleansesDungeon == false) or (raid & GCCleansesRaid == false)
		-- do nothing > return
		if(spellType == "cleanse" and GCCleansesEverywhere == false and (
				(Addon.CurrentInstance == "party" and GCCleansesDungeon == false) or
				(Addon.CurrentInstance == "raid" and GCCleansesRaid == false)
		))then return; end

		-- unpack data
		local spellCD, spellClass = unpack(spellData);

		-- get a bar
		local bar = getBar(
			spellType,
			sourceName .. "_" .. spellId,
			spellId,
			sourceName,
			GetSpellTexture(spellId),
			Addon.ClassColor[spellClass],
			targetName
		);

		-- if the bar has no point
		if(bar:GetPoint(0) == nil) then
		
			-- get the anchor
			local anchor = Addon.Anchors[spellType];

			-- get last bar
			local lastBar = anchor;
			while(lastBar.nextBar ~= nil) do
				lastBar = lastBar.nextBar;
			end;
			
			-- attach the bar to the last bar
			bar:SetPoint("BOTTOMRIGHT", lastBar, "TOPRIGHT", 0, 3);
			
			-- linking
			lastBar.nextBar = bar;
			bar.prevBar = lastBar;
			bar.nextBar = nil;
			
		end;
		
		-- start
		bar.Start(spellCD);

	end

end);