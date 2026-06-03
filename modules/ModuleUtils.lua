local _, Addon = ...;

local function newBar(module, anchor, spellId, iconPath, colorRGB, playerName, targetName, key)

    -- request a new bar
    local bar = Addon.ProgressBar.getProgressBar(135, 17, "Interface\\AddOns\\GroupCooldowns\\resources\\bar_serenity", iconPath, playerName, colorRGB, spellId, targetName, true);

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

    -- implement OnFinish
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
        module["activeBars"][key] = nil;

        bar:Hide();

    end

    return bar

end

local function newBarReady(anchor, spellId, iconPath, colorRGB, playerName, targetName, key)

    -- request a new bar
    local bar = Addon.ProgressBar.getProgressBar(135, 17, "Interface\\AddOns\\GroupCooldowns\\resources\\bar_serenity", iconPath, playerName, colorRGB, spellId, targetName, false);
    bar.key = key;

    -- find next bar
    local pivotBar = anchor;
    while(pivotBar.nextBar ~= nil and pivotBar.nextBar.key < key) do
        pivotBar = pivotBar.nextBar;
    end;

    -- attach the bar to the pivot bar
    bar:SetPoint("BOTTOMRIGHT", pivotBar, "TOPRIGHT", 0, 3);

    -- repoint the next bar to new bar
    local pivotNextBar = pivotBar.nextBar;
    if(pivotNextBar ~= nil) then
        pivotNextBar:ClearAllPoints();
        pivotNextBar:SetPoint("BOTTOMRIGHT", bar, "TOPRIGHT", 0, 3);
        pivotNextBar.prevBar = bar;
    end

    -- relink
    pivotBar.nextBar = bar;
    bar.prevBar = pivotBar;
    bar.nextBar = pivotNextBar;

    -- implement OnFinish
    function bar.OnFinish()

        bar.duration:SetText("R");
        bar.duration:SetTextColor(0.17, 0.8, 0.17);
        _, maxValue = bar.statusBar:GetMinMaxValues();
        bar.statusBar:SetValue(maxValue);
        --bar.statusBar:SetStatusBarColor(0.17, 0.8, 0.17);

    end

    return bar;

end

Addon.ModuleUtils = {};
function Addon.ModuleUtils.StartBar(module, anchor, spellId, iconPath, colorRGB, playerName, targetName, spellCooldown)

    -- check if module is active
    if(module.IsEnable() == false) then return; end

    -- create a key value
    local key = playerName .. "_" .. spellId;

    -- get the bar
    local activeBars = module["activeBars"];
    local bar = activeBars[key];
    if(bar == nil) then
        if(module.IsShowReady()) then
            bar = newBarReady(anchor, spellId, iconPath, colorRGB, playerName, targetName, key);
        else
            bar = newBar(module, anchor, spellId, iconPath, colorRGB, playerName, targetName, key);
        end
    end

    -- start it
    bar.duration:SetTextColor(1, 1, 1);
    bar.Start(spellCooldown);
    activeBars[key] = bar;

end