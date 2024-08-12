local _, Addon = ...;

-- create the object
Addon.ProgressBar = {};
Addon.ProgressBar.Cache = {};

-- Find an available bar in cache
local function findBar()

	for _, bar in pairs(Addon.ProgressBar.Cache) do

		if(bar.active == false) then
			return bar;
		end

	end

	return nil;

end

-- Set the duration of the bar
local function setDuration(bar, duration)

	-- rount the duration up: 3.01 -> 4
	duration = ceil(duration);
	if(duration >= 60) then -- 1 minute

		-- split in minutes and seconds
		local m = floor(duration/60)
		local s = duration - (m*60)
		bar.duration:SetFormattedText("%d:%02d", m, s)
		
	else
		bar.duration:SetText(duration);
	end
		
end

-- Initialize functions to the bar
-- Start, Update, Finish, OnFinish
local function initFunctionsBar(bar)

	-- start the countdown
	function bar.Start(duration)

		-- state true -- bar is used and is not available for other usage.
		bar.active = true;

		-- save the end moment
		local now = GetTime();
		bar.endTime = now+duration;

		-- set the duration and status bar
		setDuration(bar, duration);
		bar.statusBar:SetMinMaxValues(0, duration);
		bar.statusBar:SetValue(duration);

		-- (re)start
		bar.updater:Restart();

		-- show the bar
		bar:Show();

	end

	-- update the duration and status bar, based on remained time
	function bar.Update()

		-- get the now, end and remained time
		local now = GetTime();
		local endTime = bar.endTime;
		local remained = endTime - now;

		-- if - remained time, update it
		-- else - call finish
		if(remained > 0) then
			setDuration(bar, remained);
			bar.statusBar:SetValue(remained);
		else
			bar.Finish();
		end

	end

	-- function for when the countdown reached zero
	function bar.Finish()

		-- stop the updater
		bar.updater:Finish();

		-- call OnFinish
		bar.OnFinish();

		-- state false -- for reuse
		bar.active = false;

	end

	-- this can be overrided for more complex usecase
	function bar.OnFinish()
		bar:Hide();
	end

end


-- Add a thin border to the bar
local function addBorder(bar, height)

	local topBorder = bar:CreateTexture(nil, "BORDER");
	topBorder:SetColorTexture(0, 0, 0);
	topBorder:SetPoint("TOPLEFT", -height, 1);
	topBorder:SetPoint("TOPRIGHT", 0, 1);

	local botBorder = bar:CreateTexture(nil, "BORDER");
	botBorder:SetColorTexture(0, 0, 0);
	botBorder:SetPoint("BOTTOMLEFT", -height, -1);
	botBorder:SetPoint("BOTTOMRIGHT", 0, -1);

	local leftBorder = bar:CreateTexture(nil, "BORDER");
	leftBorder:SetColorTexture(0, 0, 0);
	leftBorder:SetPoint("TOPLEFT", -1-height, 1);
	leftBorder:SetPoint("BOTTOMLEFT", -1-height, -1);

	local rightBorder = bar:CreateTexture(nil, "BORDER");
	rightBorder:SetColorTexture(0, 0, 0);
	rightBorder:SetPoint("TOPRIGHT", 1, 1);
	rightBorder:SetPoint("BOTTOMRIGHT", 1, -1);

	local separatorBorder = bar:CreateTexture(nil, "BORDER");
	separatorBorder:SetColorTexture(0, 0, 0);
	separatorBorder:SetPoint("TOPLEFT", 0, 1);
	separatorBorder:SetPoint("BOTTOMLEFT", 0, -1);

end

-- Initialize the bar
-- Create updater, bg, icon, statusbar, label, duration
-- Add border
-- Add functions
local function initBar(bar, height, bgTexture)

	-- create animation
	local updater = bar:CreateAnimationGroup();
	updater:SetLooping("REPEAT");
	updater:SetScript("OnLoop", function() bar.Update(); end);
	local animation = updater:CreateAnimation();
	animation:SetDuration(0.05); -- every 50ms
	bar.updater = updater;

	-- create bg
	local bg = bar:CreateTexture(nil, "BACKGROUND");
	bg:SetAllPoints();
	bg:SetTexture(bgTexture);
	bg:SetVertexColor(0, 0, 0, 0.5);
	bar.bg = bg;
	
	-- create the icon
	local icon = bar:CreateTexture(nil, "ARTWORK");
	icon:SetPoint("RIGHT", bar, "LEFT");
	icon:SetTexCoord(0.07, 0.93, 0.07, 0.93); -- some crop
	bar.icon = icon;

	-- create the status bar
	local statusBar = CreateFrame("StatusBar", nil, bar);
	statusBar:SetPoint("TOPLEFT", 1, 0);
	statusBar:SetPoint("BOTTOMRIGHT");
	statusBar:SetOrientation("HORIZONTAL");
	bar.statusBar = statusBar;
	
	-- label
	local label = statusBar:CreateFontString(nil, "OVERLAY", "GroupCooldownsFont")
	label:SetJustifyH("LEFT");
	label:SetJustifyV("MIDDLE");
	label:SetPoint("LEFT", 1, 1);
	bar.label = label;
	
	-- duration
	local duration = statusBar:CreateFontString(nil, "OVERLAY", "GroupCooldownsFont")
	duration:SetJustifyH("RIGHT");
	duration:SetJustifyV("MIDDLE");
	duration:SetPoint("RIGHT", 1, 1);
	bar.duration = duration;
	
	-- create border
	addBorder(bar, height);

	-- add functions
	initFunctionsBar(bar);

	-- mouse over only
	bar:SetScript("OnEnter", function() bar.OnEnter() end);
	bar:SetScript("OnLeave", function() GameTooltip:Hide() end);
	bar:SetMouseMotionEnabled(true);
	bar:SetMouseClickEnabled(false);

end

-- Prepare the design of bar
-- sizes, bar texture & color, icon, label, tooltip
local function prepareBar(bar, width, height, barTexture, iconTexture, label, colorRGB, spellId, targetName)

	-- size
	bar:SetSize(width, height);

	-- statusbar
	bar.statusBar:SetStatusBarTexture(barTexture);
	bar.statusBar:SetStatusBarColor(unpack(colorRGB));

	-- icon
	bar.icon:SetTexture(iconTexture);
	bar.icon:SetSize(height, height);

	-- label
	bar.label:SetText(label);

	-- function for mouse enter
	function bar.OnEnter()
		GameTooltip:SetOwner(bar, "ANCHOR_RIGHT", 2, -height-2);
		GameTooltip:AddSpellByID(spellId);
		if(targetName ~= nil) then GameTooltip:AddLine("\nTarget: " .. targetName, 0, 1, 1, true); end
		GameTooltip:Show();
	end

end

function Addon.ProgressBar.getProgressBar(width, height, barTexture, iconTexture, label, spellId, colorRGB, targetName)

	local bar = findBar();

	-- create the bar
	if(bar == nil) then

		-- create the bar
		bar = CreateFrame("Frame", nil, UIParent);

		-- init the bar
		initBar(bar, height, barTexture);
	
		-- save it in cache, for reuse
		table.insert(Addon.ProgressBar.Cache, bar);
		
	end

	-- set the bar
	prepareBar(bar, width, height, barTexture, iconTexture, label, colorRGB, spellId, targetName);

	return bar;
	
end;