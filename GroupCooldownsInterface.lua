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
    showAnchor:SetPoint("TOPLEFT", 12, -75);
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
    enableIn:SetText("Enable (require reload):");
    enableIn:SetTextColor(1, 1, 1, 1);
    enableIn:SetPoint("TOPLEFT", 15, -100);

    -- dungeon enable
    local dungeonEnable = CreateFrame("CheckButton", "GCInterfaceOptionDungeonEnable", addonCategory, "UICheckButtonTemplate");
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
    local raidEnable = CreateFrame("CheckButton", "GCInterfaceOptionRaidEnable", addonCategory, "UICheckButtonTemplate");
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
    local everywhereEnable = CreateFrame("CheckButton", "GCInterfaceOptionEverywhereEnable", addonCategory, "UICheckButtonTemplate");
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
    title:SetPoint("TOPLEFT", 15, -130);

    -- show cleanses anchor
    local showCleansesAnchor = CreateFrame("CheckButton", "GCInterfaceOptionShowCleansesAnchor", addonCategory, "UICheckButtonTemplate");
    showCleansesAnchor:SetSize(20, 20);
    showCleansesAnchor:SetPoint("TOPLEFT", 12, -150);
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
    enableIn:SetText("Enable (require reload):");
    enableIn:SetTextColor(1, 1, 1, 1);
    enableIn:SetPoint("TOPLEFT", 15, -175);

    -- dungeon enable
    local dungeonEnable = CreateFrame("CheckButton", "GCInterfaceOptionDungeonEnable", addonCategory, "UICheckButtonTemplate");
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
    local raidEnable = CreateFrame("CheckButton", "GCInterfaceOptionRaidEnable", addonCategory, "UICheckButtonTemplate");
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
    local everywhereEnable = CreateFrame("CheckButton", "GCInterfaceOptionEverywhereEnable", addonCategory, "UICheckButtonTemplate");
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

    -- init
    if(GCCleansesEverywhere) then
        dungeonEnable:Disable();
        raidEnable:Disable();
    else
        dungeonEnable:Enable();
        raidEnable:Enable();
    end

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

    -- reload button
    local reloadButton = CreateFrame("Button", nil, addonCategory, "UIPanelButtonTemplate");
    reloadButton:SetSize(70, 21);
    reloadButton:SetText("Reload");
    reloadButton:SetPoint("TOPLEFT", 15, -200);
    reloadButton:SetScript("OnClick", function()
        ReloadUI();
    end);

end;