local _, Addon = ...;

local function controlCategory(addonCategory)

    -- title
    local title = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    title:SetText("Controls");
    title:SetTextColor(1, 1, 1, 1);
    title:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE");
    title:SetPoint("TOPLEFT", 15, -55);

    -- show anchor
    local showAnchor = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    showAnchor:SetSize(20, 20);
    showAnchor:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -5);
    showAnchor:SetChecked(false);
    showAnchor:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if isChecked then
            Addon.Anchors["control"]:Show();
        else
            Addon.Anchors["control"]:Hide();
        end
    end)
    local showAnchorLabel = showAnchor:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    showAnchorLabel:SetText("Show anchor");
    showAnchorLabel:SetTextColor(1, 1, 1, 1);
    showAnchorLabel:SetPoint("LEFT", 20, 0);

    -- enable in text
    local enableIn = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    enableIn:SetText("Enable:");
    enableIn:SetTextColor(1, 1, 1, 1);
    enableIn:SetPoint("TOPLEFT", showAnchor, "BOTTOMLEFT", 3, -5);

    -- dungeon enable
    local dungeonEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    dungeonEnable:SetSize(20, 20);
    dungeonEnable:SetPoint("LEFT", enableIn, "RIGHT", 5, 0);
    dungeonEnable:SetChecked(GCControlsDungeon);
    dungeonEnable:SetScript("OnClick", function(self)
        GCControlsDungeon = self:GetChecked();
    end)
    local dungeonEnableLabel = dungeonEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    dungeonEnableLabel:SetText("Dungeon");
    dungeonEnableLabel:SetTextColor(1, 1, 1, 1);
    dungeonEnableLabel:SetPoint("LEFT", 20, 0);

    -- raid enable
    local raidEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    raidEnable:SetSize(20, 20);
    raidEnable:SetPoint("LEFT", dungeonEnableLabel, "RIGHT", 5, 0);
    raidEnable:SetChecked(GCControlsRaid);
    raidEnable:SetScript("OnClick", function(self)
        GCControlsRaid = self:GetChecked();
    end)
    local raidEnableLabel = raidEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    raidEnableLabel:SetText("Raid");
    raidEnableLabel:SetTextColor(1, 1, 1, 1);
    raidEnableLabel:SetPoint("LEFT", 20, 0);

    -- everywhere enable
    local everywhereEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    everywhereEnable:SetSize(20, 20);
    everywhereEnable:SetPoint("LEFT", raidEnableLabel, "RIGHT", 5, 0);
    everywhereEnable:SetChecked(GCControlsEverywhere);
    everywhereEnable:SetScript("OnClick", function(self)
        GCControlsEverywhere = self:GetChecked();
        if(GCControlsEverywhere) then
            dungeonEnable:Disable();
            raidEnable:Disable();
        else
            dungeonEnable:Enable();
            raidEnable:Enable();
        end
    end)
    local everywhereEnableLabel = everywhereEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    everywhereEnableLabel:SetText("Everywhere");
    everywhereEnableLabel:SetTextColor(1, 1, 1, 1);
    everywhereEnableLabel:SetPoint("LEFT", 20, 0);

    -- show when ready
    local readyEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    readyEnable:SetSize(20, 20);
    readyEnable:SetPoint("TOPLEFT", enableIn, "BOTTOMLEFT", -2, -5);
    readyEnable:SetChecked(GCControlsReady);
    readyEnable:SetScript("OnClick", function(self)
        GCControlsReady = self:GetChecked();
    end)
    local readyEnableLabel = readyEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    readyEnableLabel:SetText("Show when ready");
    readyEnableLabel:SetTextColor(1, 1, 1, 1);
    readyEnableLabel:SetPoint("LEFT", 20, 0);

    -- init
    if(GCControlsEverywhere) then
        dungeonEnable:Disable();
        raidEnable:Disable();
    else
        dungeonEnable:Enable();
        raidEnable:Enable();
    end

end

local function cleanseCategory(addonCategory)

    -- sub title
    local title = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    title:SetText("Cleanses");
    title:SetTextColor(1, 1, 1, 1);
    title:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE");
    title:SetPoint("TOPLEFT", 15, -160);

    -- show cleanses anchor
    local showCleansesAnchor = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    showCleansesAnchor:SetSize(20, 20);
    showCleansesAnchor:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -5);
    showCleansesAnchor:SetChecked(false);
    showCleansesAnchor:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if isChecked then
            Addon.Anchors["cleanse"]:Show();
        else
            Addon.Anchors["cleanse"]:Hide();
        end
    end)
    local showCleansesAnchorLabel = showCleansesAnchor:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    showCleansesAnchorLabel:SetText("Show anchor");
    showCleansesAnchorLabel:SetTextColor(1, 1, 1, 1);
    showCleansesAnchorLabel:SetPoint("LEFT", 20, 0);

    -- enable in text
    local enableIn = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    enableIn:SetText("Enable:");
    enableIn:SetTextColor(1, 1, 1, 1);
    enableIn:SetPoint("TOPLEFT", showCleansesAnchor, "BOTTOMLEFT", 3, -5);

    -- dungeon enable
    local dungeonEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    dungeonEnable:SetSize(20, 20);
    dungeonEnable:SetPoint("LEFT", enableIn, "RIGHT", 5, 0);
    dungeonEnable:SetChecked(GCCleansesDungeon);
    dungeonEnable:SetScript("OnClick", function(self)
        GCCleansesDungeon = self:GetChecked();
    end)
    local dungeonEnableLabel = dungeonEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    dungeonEnableLabel:SetText("Dungeon");
    dungeonEnableLabel:SetTextColor(1, 1, 1, 1);
    dungeonEnableLabel:SetPoint("LEFT", 20, 0);

    -- raid enable
    local raidEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    raidEnable:SetSize(20, 20);
    raidEnable:SetPoint("LEFT", dungeonEnableLabel, "RIGHT", 5, 0);
    raidEnable:SetChecked(GCCleansesRaid);
    raidEnable:SetScript("OnClick", function(self)
        GCCleansesRaid = self:GetChecked();
    end)
    local raidEnableLabel = raidEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    raidEnableLabel:SetText("Raid");
    raidEnableLabel:SetTextColor(1, 1, 1, 1);
    raidEnableLabel:SetPoint("LEFT", 20, 0);

    -- everywhere enable
    local everywhereEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    everywhereEnable:SetSize(20, 20);
    everywhereEnable:SetPoint("LEFT", raidEnableLabel, "RIGHT", 5, 0);
    everywhereEnable:SetChecked(GCCleansesEverywhere);
    everywhereEnable:SetScript("OnClick", function(self)
        GCCleansesEverywhere = self:GetChecked();
        if(GCCleansesEverywhere) then
            dungeonEnable:Disable();
            raidEnable:Disable();
        else
            dungeonEnable:Enable();
            raidEnable:Enable();
        end
    end)
    local everywhereEnableLabel = everywhereEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    everywhereEnableLabel:SetText("Everywhere");
    everywhereEnableLabel:SetTextColor(1, 1, 1, 1);
    everywhereEnableLabel:SetPoint("LEFT", 20, 0);

    -- show when ready
    local readyEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    readyEnable:SetSize(20, 20);
    readyEnable:SetPoint("TOPLEFT", enableIn, "BOTTOMLEFT", -2, -5);
    readyEnable:SetChecked(GCCleansesReady);
    readyEnable:SetScript("OnClick", function(self)
        GCCleansesReady = self:GetChecked();
    end)
    local readyEnableLabel = readyEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    readyEnableLabel:SetText("Show when ready");
    readyEnableLabel:SetTextColor(1, 1, 1, 1);
    readyEnableLabel:SetPoint("LEFT", 20, 0);

    -- init
    if(GCCleansesEverywhere) then
        dungeonEnable:Disable();
        raidEnable:Disable();
    else
        dungeonEnable:Enable();
        raidEnable:Enable();
    end

end

local function quakingCategory(addonCategory)

    -- sub title
    local title = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    title:SetText("Quaking Affix");
    title:SetTextColor(1, 1, 1, 1);
    title:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE");
    title:SetPoint("TOPLEFT", 15, -260);
    local titleLabel = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    titleLabel:SetText("Quake is occured at random intervals. Minimum interval is 20 seconds.");
    titleLabel:SetTextColor(1, 1, 1, 1);
    titleLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5);

    -- show cleanses anchor
    local showQuakingAnchor = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    showQuakingAnchor:SetSize(20, 20);
    showQuakingAnchor:SetPoint("TOPLEFT", titleLabel, "BOTTOMLEFT", -2, -5);
    showQuakingAnchor:SetChecked(false);
    showQuakingAnchor:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if isChecked then
            Addon.Anchors["quaking"]:Show();
        else
            Addon.Anchors["quaking"]:Hide();
        end
    end)
    local showQuakingAnchorLabel = showQuakingAnchor:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    showQuakingAnchorLabel:SetText("Show anchor");
    showQuakingAnchorLabel:SetTextColor(1, 1, 1, 1);
    showQuakingAnchorLabel:SetPoint("LEFT", 20, 0);

    -- listen quaking enable
    local quakingEnable = CreateFrame("CheckButton", nil, addonCategory, "UICheckButtonTemplate");
    quakingEnable:SetSize(20, 20);
    quakingEnable:SetPoint("TOPLEFT", showQuakingAnchor, "BOTTOMLEFT", 0, -5);
    quakingEnable:SetChecked(GCQuaking);
    quakingEnable:SetScript("OnClick", function(self)
        GCQuaking = self:GetChecked();
    end)
    local quakingEnableLabel = quakingEnable:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    quakingEnableLabel:SetText("Enable");
    quakingEnableLabel:SetTextColor(1, 1, 1, 1);
    quakingEnableLabel:SetPoint("LEFT", 20, 0);

end

function Addon.CreateInterfaceOptions()

    -- create a category in interface>addons
    local addonCategory = CreateFrame("Frame", "GroupCooldownsAddonCategory");
    addonCategory.name = "GroupCooldowns";
    InterfaceOptions_AddCategory(addonCategory);

    -- set title
    local title = addonCategory:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    title:SetText("GroupCooldowns");
    title:SetTextColor(1, 1, 1, 1);
    title:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE");
    title:SetPoint("TOPLEFT", 15, -15);

    controlCategory(addonCategory);
    cleanseCategory(addonCategory);
    quakingCategory(addonCategory);

    -- reload button
    local reloadButton = CreateFrame("Button", nil, addonCategory, "UIPanelButtonTemplate");
    reloadButton:SetSize(70, 21);
    reloadButton:SetText("Reload");
    reloadButton:SetPoint("LEFT", title, "RIGHT", 15, 0);
    reloadButton:SetScript("OnClick", function()
        ReloadUI();
    end);
    local reloadButtonLabel = reloadButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    reloadButtonLabel:SetText("Any change requires reload, for immediately effect.");
    reloadButtonLabel:SetTextColor(1, 1, 1, 1);
    reloadButtonLabel:SetPoint("LEFT", reloadButton, "RIGHT", 5, 0);

end;