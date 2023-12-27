-- Decompiled with the Synapse X Luau decompiler.

return {
	superior = {
		id = "superior", 
		name = "Superior", 
		description = "This unit deals more damage!", 
		rarity = "Rare", 
		tiers = {
			["1"] = {
				increase_damage = 0.1, 
				weight = 50
			}, 
			["2"] = {
				increase_damage = 0.125, 
				weight = 35
			}, 
			["3"] = {
				increase_damage = 0.15, 
				override_rarity = "Epic", 
				weight = 15
			}
		}, 
		weight = 30
	}, 
	range = {
		id = "range", 
		name = "Range", 
		description = "This unit has increased range!", 
		rarity = "Rare", 
		tiers = {
			["1"] = {
				increase_range = 0.1, 
				weight = 50
			}, 
			["2"] = {
				increase_range = 0.125, 
				weight = 35
			}, 
			["3"] = {
				increase_range = 0.15, 
				weight = 15, 
				override_rarity = "Epic"
			}
		}, 
		weight = 25
	}, 
	nimble = {
		id = "nimble", 
		name = "Nimble", 
		description = "This unit attacks faster!", 
		rarity = "Rare", 
		tiers = {
			["1"] = {
				decrease_cooldown = -0.05, 
				weight = 50
			}, 
			["2"] = {
				decrease_cooldown = -0.075, 
				weight = 35
			}, 
			["3"] = {
				decrease_cooldown = -0.12, 
				override_rarity = "Epic", 
				weight = 15
			}
		}, 
		weight = 25
	}, 
	culling = {
		id = "culling", 
		name = "Culling", 
		description = "This unit deals more damage to low health enemies!", 
		rarity = "Legendary", 
		singular = true, 
		tiers = {
			["1"] = {}
		}, 
		weight = 5
	}, 
	neuroplasticity = {
		id = "neuroplasticity", 
		name = "Adept", 
		description = "This unit levels up much faster!", 
		rarity = "Legendary", 
		singular = true, 
		tiers = {
			["1"] = {
				weight = 100
			}
		}, 
		weight = 10
	}, 
	sniper = {
		id = "sniper", 
		name = "Sniper", 
		description = "This unit has insane range!", 
		rarity = "Legendary", 
		singular = true, 
		tiers = {
			["1"] = {
				increase_range = 0.25, 
				weight = 100
			}
		}, 
		weight = 2.5
	}, 
	godspeed = {
		id = "godspeed", 
		name = "Godspeed", 
		description = "This unit has unrivaled speed!", 
		rarity = "Legendary", 
		singular = true, 
		tiers = {
			["1"] = {
				decrease_cooldown = -0.2
			}
		}, 
		weight = 1.5
	}, 
	reaper = {
		id = "reaper", 
		name = "Reaper", 
		description = "This unit does much more damage, especially to bosses!", 
		rarity = "Mythic", 
		singular = true, 
		tiers = {
			["1"] = {
				increase_damage = 0.125, 
				weight = 100
			}
		}, 
		weight = 0.6
	}, 
	golden = {
		id = "golden", 
		name = "Golden", 
		description = "This unit gives much more money!", 
		rarity = "Mythic", 
		singular = true, 
		tiers = {
			["1"] = {
				increase_damage = 0.1, 
				weight = 100
			}
		}, 
		weight = 0.2
	}, 
	divine = {
		id = "divine", 
		name = "Divine", 
		description = "This unit is blessed with divine power! " .. utf8.char(128563), 
		rarity = "Mythic", 
		singular = true, 
		tiers = {
			["1"] = {
				increase_damage = 0.2, 
				increase_range = 0.2, 
				decrease_cooldown = -0.1, 
				weight = 100
			}
		}, 
		weight = 0.2
	}, 
	unique = {
		id = "unique", 
		name = "Unique", 
		description = "There can only be one...", 
		rarity = "Mythic", 
		singular = true, 
		tiers = {
			["1"] = {
				increase_damage = 3, 
				increase_range = 0.1, 
				decrease_cooldown = -0.1, 
				weight = 100
			}
		}, 
		weight = 0.1
	}
};
