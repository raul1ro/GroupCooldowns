local _, Addon = ...;

-- create the module cleanse
Addon.Modules["cleanse"] = {};
local Module = Addon.Modules["cleanse"];

-- initialize active bars
Module["activeBars"] = {};

function Module.IsEnable()

    return GCCleansesEverywhere
            or (Addon.CurrentInstance == "party" and GCCleansesDungeon == true)
            or (Addon.CurrentInstance == "raid" and GCCleansesRaid == true)

end

function Module.StartBar(spellId, iconPath, colorRGB, playerName, targetName, spellCooldown)
    Addon.ModuleUtils.StartBar(Module, Addon.Anchors["cleanse"], spellId, iconPath, colorRGB, playerName, targetName, spellCooldown);
end

function Module.IsShowReady()
    return GCCleansesReady;
end