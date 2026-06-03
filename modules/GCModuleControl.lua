local _, Addon = ...;

-- create the module control
Addon.Modules["control"] = {};
local Module = Addon.Modules["control"];

-- initialize active bars
Module["activeBars"] = {};

function Module.IsEnable()

    return GCControlsEverywhere
            or (Addon.CurrentInstance == "party" and GCControlsDungeon == true)
            or (Addon.CurrentInstance == "raid" and GCControlsRaid == true)

end

function Module.StartBar(spellId, iconPath, colorRGB, playerName, targetName, spellCooldown)
    Addon.ModuleUtils.StartBar(Module, Addon.Anchors["control"], spellId, iconPath, colorRGB, playerName, targetName, spellCooldown);
end

function Module.IsShowReady()
    return GCControlsReady;
end