local _, Addon = ...;

Addon.ClassColor = {
	
	["dk"] = {0.77, 0.12, 0.23},
	["dh"] = {0.64, 0.19, 0.79},
	["druid"] = {1.00, 0.49, 0.04},
	["hunter"] = {0.67, 0.83, 0.45},
	["mage"] = {0.25, 0.78, 0.92},
	["monk"] = {0, 1, 0.6},
	["paladin"] = {0.96, 0.55, 0.73},
	["priest"] = {1, 1, 1},
	["rogue"] = {1, 0.96, 0.41},
	["shaman"] = {0, 0.44, 0.87},
	["warlock"] = {0.53, 0.53, 0.93},
	["warrior"] = {0.78, 0.61, 0.43},
	["race"] = {0.35, 0.35, 0.35},
	
}

function Addon.findSpell(spellId)

	local spellControl = Addon.ControlList[spellId];
	local spellCleanse = Addon.CleanseList[spellId];
	
	if(spellControl ~= nil) then
		return spellControl, "control";
	elseif(spellCleanse ~= nil) then
		return spellCleanse, "cleanse";
	else
		return nil;
	end
end

-- time, classColor
Addon.ControlList = {

	-- dk
	[47528] = {15, "dk"}, -- Mind Freeze
	[221562] = {45, "dk"}, -- Asphyxiate
	[108199] = {120, "dk"}, -- Gorefiend's Grasp - with talent 90s
	[49576] = {25, "dk"}, -- Death Grip
	
	-- dh
	[183752] = {15, "dh"}, -- Consume Magic
	[179057] = {60, "dh"}, -- Chaos Nova
	[202137] = {60, "dh"}, -- Sigil of Silence
	[202138] = {90, "dh"}, -- Sigil of Chains
	[207684] = {60, "dh"}, -- Sigil of Misery
	[217832] = {15, "dh"}, -- Imprison
	
	-- druid
	[106839] = {15, "druid" }, -- Skull Bash
	[78675] = {60, "druid" }, -- Solar Beam
	[132469] = {30, "druid" }, -- Typhoon
	[5211] = {50, "druid" }, -- Mighty Bash
	[236748] = {30, "druid"}, -- Intimidating Roar

	-- hunter
	[147362] = {24, "hunter"}, -- Counter Shot
	[187650] = {30, "hunter"}, -- Freezing Trap
	[187707] = {15, "hunter"}, -- Muzzle
	[109248] = {45, "hunter"}, -- Binding Shot
	
	-- mage
	[2139] = {24, "mage"}, -- Counterspell
	[113724] = {45, "mage"}, -- Ring of Frost
	
	-- monk
	[116705] = {15, "monk"}, -- Spear Hand Strike116705
	[119381] = {45, "monk"}, -- Leg Sweep
	[115078] = {15, "monk"}, -- Paralysis
	[116844] = {45, "monk"}, -- ring of peace
	[198898] = {15, "monk"}, -- song of chi-ji
	
	-- paladin
	[96231] = {15, "paladin"}, -- Rebuke
	[853] = {60, "paladin"}, -- Hammer of Justice
	[20066] = {15, "paladin"}, -- Repentance
	
	-- priest
	[15487] = {45, "priest"}, -- Silence
	[205369] = {30, "priest"}, -- Mind Bomb
	[8122] = {60, "priest"}, -- Psychic Scream
	
	-- rogue
	[1766] = {15, "rogue"}, -- Kick
	[408] = {20, "rogue"}, -- Kidney Shot
	
	-- shaman
	[57994] = {12, "shaman"}, -- Wind Shear
	[192058] = {45, "shaman"}, -- Lightning Surge Totem
	[51514] = {30, "shaman"}, -- Hex
	
	-- warlock
	[171140] = {24, "warlock"}, -- Shadow Lock
	[30283] = {30, "warlock"}, -- Shadowfury
	
	-- warrior
	[6552] = {15, "warrior"}, -- Pummel
	[46968] = {40, "warrior"}, -- Shockwave -- 20s if hits +3 targets [132168]
	[5246] = {90, "warrior"}, -- Intimidating Shout
	
	-- race
	[107079] = {120, "race"}, -- Quaking Palm
	[20549] = {90, "race"}, -- War Stomp
	[28730] = {120, "race"} -- Arcane Torrent

}

Addon.CleanseList = {

	-- warrior
	[97462] = {180, "warrior"}, -- commanding shout
	
	-- paladin
	[6940] = {150, "paladin"}, -- blessing of sacrifice
	[1022] = {300, "paladin"}, -- bo protection
	[22433] = {180, "paladin"}, -- bo spellwarding
	[1044] = {25, "paladin"}, -- bo freedom
	[31821] = {180, "paladin"}, -- aura mastery
	[4987] = {8, "paladin"}, -- cleanse
		
	-- priest
	[32375] = {15, "priest"}, -- mass dispel
	[213634] = {8, "priest"}, -- purify disease
	[64843] = {180, "priest"}, -- divine hymn
	[527] = {8, "priest"}, -- purify
	[47788] = {240, "priest"}, -- guardian spirit
	[33206] = {240, "priest"}, -- pain suppression
	[62618] = {180, "priest"}, -- power word: barrier
	
	-- shaman
	[108281] = {120, "shaman"}, -- ancenstral guidance
	[98008] = {180, "shaman"}, -- spirit link totem
	[198838] = {60, "shaman"}, -- earthen shield totem
	[108280] = {180, "shaman"}, -- healing tide totem
	[114052] = {180, "shaman"}, -- ascendance
	[77130] = {8, "shaman"}, -- purify spirit
	
	-- monk
	[115310] = {180, "monk"}, -- revival
	[116849] = {180, "monk"}, -- life cocoon
	[115450] = {8, "monk"}, -- detox
	
	-- druid
	[88423] = {8, "druid"}, -- nature's cure
	[740] = {180, "druid"}, -- tranquility
	[77764] = {120, "druid"}, -- stampeding roar (feral)
	[77761] = {120, "druid"}, -- stampeding roar (guardian)

}