local _, Addon = ...;

-- create the module control
Addon.Modules["quaking"] = {};
local Module = Addon.Modules["quaking"];

-- initialize active bars
Module["activeBars"] = {};

function Module.IsEnable()

    return GCQuaking
            or (Addon.CurrentInstance == "party")

end

function Module.StartBar()
    Addon.ModuleUtils.StartBar(Module, Addon.Anchors["quaking"], 240447, GetSpellTexture(240447), {0.4, 0.4, 0.4}, "Quake", nil, 20);
end

function Module.IsShowReady()
    return true;
end