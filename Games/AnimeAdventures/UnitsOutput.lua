{
	aogiri_two = {
		hybrid_placement = true,
		animation_set = "default",
		name = "Aogiri Subordinate",
		health = 20,
		id = "aogiri_two",
		speed = 1,
		range = 7,
		barrier = {
			health_ratio = 0.25,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	flesh_demon_2 = {
		id = "flesh_demon_2",
		animation_set = "default",
		_EFFECT_SCRIPTS = {
			[1] = "hantengu_spawn_clone"
		},
		health = 20,
		ASSETS = {
			particles = {
				[1] = "hantengu_clone_spawn"
			},
			sfx = {
				[1] = "gore_explode2"
			}
		},
		speed = 1,
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "hantengu_spawn_clone"
				}
			},
			units = {
				[1] = {
					health_ratio = 0.25,
					unit = "flesh_demon_1"
				}
			},
			delay = 0,
			amount = 2
		},
		hybrid_placement = true,
		name = "Large Flesh Clone"
	},
	ant_queen = {
		attack_cooldown = 5,
		primary_attack_no_upgrades = "ant_queen:egg",
		id = "ant_queen",
		range = 7,
		animation_set = "default",
		max_spawn_units = 10,
		health = 20,
		name = "Ant Queen",
		ASSETS = {
			particles = {
				[1] = "ant_egg_spawn"
			},
			sfx = {
				[1] = "gore_explode2"
			}
		},
		speed = 1,
		_EFFECT_SCRIPTS = {
			[1] = "ant_egg_spawn"
		},
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	akainu_evolved = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "akainu:punch",
		hill_unit = true,
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "akainu"
		},
		damage = 130,
		upgrade_script = true,
		rarity = "Mythic",
		id = "akainu_evolved",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "magma_arm",
				[2] = "magma_arm_left",
				[3] = "magma_fist",
				[4] = "magma"
			},
			particles = {
				[1] = "magma_pillar"
			},
			sfx = {
				[1] = "lava_loop",
				[2] = "RocksDebris1",
				[3] = "acidburn",
				[4] = "Lazer_1",
				[5] = "ki_explosion"
			}
		},
		spawn_cap = 4,
		name = "Fleet Admiral Akano",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 325,
				range = 20.5,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 455,
				range = 21,
				cost = 2000
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Great Eruption",
				primary_attack = "akainu:erupt",
				cost = 2500,
				range = 22,
				damage = 520
			},
			[4] = {
				attack_cooldown = 7,
				damage = 650,
				range = 23,
				cost = 3500
			},
			[5] = {
				attack_cooldown = 6,
				damage = 780,
				range = 24,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 1040,
				range = 25,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 15,
				note = "+ Meteor Volcano",
				primary_attack = "akainu:shower",
				cost = 8500,
				range = 36,
				damage = 1625
			},
			[8] = {
				attack_cooldown = 15,
				damage = 1950,
				range = 48,
				cost = 10000
			},
			[9] = {
				attack_cooldown = 15,
				damage = 2600,
				range = 48,
				cost = 12500
			}
		},
		health = 100,
		cost = 1250,
		cooldown = 10,
		shiny = true
	},
	akaza = {
		attack_cooldown = 15,
		primary_attack_no_upgrades = "akaza:compass",
		id = "akaza",
		range = 100,
		animation_set = "default",
		name = "Akoku",
		ASSETS = {
			effect_models = {
				[1] = "akaza_compass"
			},
			particles = {
				[1] = "akaza_buffed"
			},
			sfx = {
				[1] = "power_up",
				[2] = "RocksDebris2"
			}
		},
		speed = 15,
		hybrid_placement = true,
		health = 5000
	},
	jiren = {
		attack_cooldown = 8,
		cost = 800,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 35,
		rarity = "Legendary",
		id = "jiren",
		hide_from_banner = true,
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "jiren_ball_explosion",
				[2] = "jiren_counter_ball"
			},
			effect_models = {
				[1] = "jiren_impact"
			},
			particles = {
				[1] = "explosion_jiren",
				[2] = "explosion_jiren_counter"
			},
			sfx = {
				[1] = "electric_explosion2",
				[2] = "dbz_charge_three",
				[3] = "electric_sparks",
				[4] = "Thunder_release",
				[5] = "physical_explosion_with_debris",
				[6] = "ki_explosion",
				[7] = "futuristic_charge_fast"
			}
		},
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 50,
				range = 12.5,
				cost = 600
			},
			[2] = {
				attack_cooldown = 7,
				damage = 75,
				range = 13,
				cost = 1100
			},
			[3] = {
				attack_cooldown = 6,
				damage = 100,
				range = 14,
				cost = 1500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 125,
				range = 15,
				cost = 1750
			},
			[5] = {
				attack_cooldown = 5,
				note = "+ Power Impact",
				primary_attack = "jiren:power_impact",
				cost = 5500,
				range = 17,
				damage = 125
			},
			[6] = {
				attack_cooldown = 5,
				damage = 130,
				range = 18,
				cost = 6000
			},
			[7] = {
				attack_cooldown = 5,
				damage = 150,
				range = 20,
				cost = 6500
			}
		},
		name = "Jirun",
		primary_attack_no_upgrades = "jiren:counter",
		health = 100,
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	hantengu = {
		id = "hantengu",
		range = 7,
		animation_set = "default",
		name = "Clone Demon",
		ASSETS = {
			particles = {
				[1] = "hantengu_clone_spawn"
			},
			sfx = {
				[1] = "gore_explode2"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "hantengu_spawn_clone"
				}
			},
			units = {
				[1] = {
					health_ratio = 0.5,
					unit = "hantengu_clone"
				}
			},
			delay = 0,
			amount = 2
		}
	},
	frieza_boss = {
		attack_cooldown = 20,
		transform = {
			health_ratio = 0.5,
			effects = {
				1 = {
					id = "zarbon_transform"
				}
			},
			unit = "frieza_boss_transformed"
		},
		primary_attack_no_upgrades = "frieza_boss:spawn_units",
		id = "frieza_boss",
		range = 20,
		animation_set = "frieza_pod",
		max_spawn_units = 5,
		boss = true,
		name = "Freezo",
		ASSETS = {
			vfx = {
				[1] = "frieza_spawn_lazer"
			},
			particles = {
				[1] = "zarbon_evolved_attack",
				[2] = "zarbon_evolved_transform",
				[3] = "zarbon_transform"
			},
			sfx = {
				[1] = "teleport_dbz",
				[2] = "stomp",
				[3] = "electricity_aura_short",
				[4] = "electric_explosion",
				[5] = "Thunder_release"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 1
	},
	attack_titan = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "titan:stomp",
		id = "attack_titan",
		hybrid_placement = true,
		range = 10,
		animation_set = "titan",
		knockback_points = {
			[1] = 0.5
		},
		health = 100,
		name = "Attack Titan",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_smoke"
			},
			[2] = {
				id = "titan_shifter_spawn_lightning"
			},
			[3] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx = "physical_explosion_with_debris"
				}
			}
		},
		speed = 1,
		spawn_anim = "titan",
		cooldown = 10,
		damage = 15
	},
	clay_dragon = {
		upgrade_script = true,
		id = "clay_dragon",
		range = 20,
		animation_set = "default",
		name = "Clay Dragon",
		ASSETS = {
			sfx = {
				[1] = "katsu",
				[2] = "liquid_to_form_something",
				[3] = "physical_explosion_squeeze"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		death_attack = "deidara_clone:self_destruct"
	},
	titan5 = {
		cost = 1000,
		id = "titan5",
		approach_distance = 15,
		range = 100,
		animation_set = "abnormal_titan",
		hybrid_placement = true,
		name = "Cart Titan",
		knockback_points = {},
		speed = 5,
		health = 10000,
		cooldown = 10,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	yahaba = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "yahaba:arrow_2",
		id = "yahaba",
		range = 50,
		animation_set = "default",
		name = "Yahobu",
		ASSETS = {
			vfx = {
				[1] = "yahaba_arrow"
			},
			sfx = {
				[1] = "charge_echo",
				[2] = "ki_explosion",
				[3] = "woosh_throw_heavy"
			},
			particles = {
				[1] = "yahaba"
			},
			projectiles = {
				[1] = "yahaba_arrow"
			}
		},
		speed = 15,
		hybrid_placement = true,
		health = 5000
	},
	marine_four = {
		hybrid_placement = true,
		name = "Marine Lieutenant",
		health = 20,
		id = "marine_four",
		speed = 1,
		range = 7,
		animation_set = "sword:1h_long"
	},
	jaw_titan = {
		cost = 1000,
		id = "jaw_titan",
		approach_distance = 15,
		range = 100,
		animation_set = "jaw_titan",
		hybrid_placement = true,
		ASSETS = {
			sfx = {
				[1] = "titan_roar_generic",
				[2] = "steam_hiss"
			}
		},
		name = "Jaw Titan",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_smoke"
			},
			[2] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx_params = {
						tween_out_time = 0.5
					},
					sfx = "titan_roar_generic"
				}
			}
		},
		speed = 5,
		knockback_points = {},
		cooldown = 10,
		health = 10000
	},
	ccg_three = {
		hybrid_placement = true,
		name = "Senior Investigator",
		health = 20,
		id = "ccg_three",
		speed = 1,
		range = 7,
		animation_set = "sword:1h"
	},
	zetsu_clone = {
		id = "zetsu_clone",
		range = 7,
		animation_set = "default",
		name = "Clone",
		ASSETS = {
			sfx = {
				[1] = "plant_grow"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		spawn_anim = "ground_rise"
	},
	gon_adult_evolved = {
		attack_cooldown = 10,
		cost = 1750,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "gon_adult"
		},
		damage = 375,
		rarity = "Mythic",
		id = "gon_adult_evolved",
		hybrid_placement = true,
		animation_set = "gon_adult",
		ASSETS = {
			_new_fx = {
				[1] = "gon_adult"
			},
			sfx = {
				[1] = "gon_charge3",
				[2] = "eto_laser_charge",
				[3] = "physical_explosion_squeeze",
				[4] = "physical_explosion_with_debris",
				[5] = "fire_release",
				[6] = "gore_explode",
				[7] = "electric_charge",
				[8] = "electric_explosion",
				[9] = "physical_explosion_long",
				[10] = "cero_charge",
				[11] = "gon_final_vo",
				[12] = "gon_scream"
			}
		},
		health = 100,
		name = "Gone (???)",
		upgrade = {
			[1] = {
				attack_cooldown = 10,
				damage = 825,
				range = 13,
				cost = 2500
			},
			[2] = {
				attack_cooldown = 10,
				damage = 1200,
				range = 15,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 15,
				note = "+ End",
				cost = 3500,
				primary_attack = "gon_adult:barrage",
				range = 16,
				damage = 2100
			},
			[4] = {
				attack_cooldown = 15,
				damage = 3000,
				range = 17,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 15,
				damage = 3600,
				range = 20,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 15,
				damage = 4125,
				range = 25,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 15,
				damage = 4500,
				range = 28,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 30,
				note = "+ ???",
				cost = 12500,
				primary_attack = "gon_adult:final_rock",
				range = 45.5,
				damage = 5625
			},
			[9] = {
				attack_cooldown = 25,
				damage = 6750,
				range = 52,
				cost = 17500
			}
		},
		spawn_cap = 3,
		primary_attack_no_upgrades = "gon_adult:single_smash",
		cooldown = 10,
		shiny = true
	},
	gon_adult = {
		attack_cooldown = 10,
		cost = 1750,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 250,
		rarity = "Mythic",
		id = "gon_adult",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "gon_adult"
			},
			sfx = {
				[1] = "gon_charge3",
				[2] = "eto_laser_charge",
				[3] = "physical_explosion_squeeze",
				[4] = "physical_explosion_with_debris",
				[5] = "fire_release",
				[6] = "gore_explode",
				[7] = "electric_charge",
				[8] = "electric_explosion",
				[9] = "physical_explosion_long",
				[10] = "cero_charge",
				[11] = "gon_final_vo",
				[12] = "gon_scream"
			}
		},
		animation_set = "gon_adult",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "gon_adult"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "gon_contract",
						amount = 1
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "gon_adult"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "gon_contract",
						amount = 1
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit = "gon_adult_evolved",
			evolve_text = "+50% Damage, +???"
		},
		health = 100,
		name = "Gone (Adult)",
		upgrade = {
			[1] = {
				attack_cooldown = 10,
				damage = 550,
				range = 13,
				cost = 2500
			},
			[2] = {
				attack_cooldown = 10,
				damage = 800,
				range = 15,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 15,
				note = "+ End",
				cost = 3500,
				primary_attack = "gon_adult:barrage",
				range = 16,
				damage = 1400
			},
			[4] = {
				attack_cooldown = 15,
				damage = 2000,
				range = 17,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 15,
				damage = 2400,
				range = 20,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 15,
				damage = 2750,
				range = 25,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 15,
				damage = 3000,
				range = 28,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 15,
				damage = 3750,
				range = 30,
				cost = 12500
			}
		},
		spawn_cap = 3,
		primary_attack_no_upgrades = "gon_adult:single_smash",
		cooldown = 10,
		shiny = true
	},
	naruto = {
		attack_cooldown = 2.5,
		cost = 250,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 6,
		rarity = "Rare",
		id = "naruto",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			effect_models = {
				[1] = "rasengan_base",
				[2] = "rasengan_base_release"
			},
			sfx = {
				[1] = "rasengan",
				[2] = "throw_knife"
			},
			projectiles = {
				[1] = "base_kunai"
			}
		},
		spawn_cap = 6,
		name = "Noruto",
		upgrade = {
			[1] = {
				attack_cooldown = 2.5,
				damage = 12,
				range = 11,
				cost = 300
			},
			[2] = {
				attack_cooldown = 2,
				damage = 16,
				range = 12,
				cost = 450
			},
			[3] = {
				attack_cooldown = 1.5,
				damage = 17.5,
				range = 13,
				cost = 600
			},
			[4] = {
				attack_cooldown = 1,
				damage = 17.5,
				range = 14,
				cost = 800
			},
			[5] = {
				attack_cooldown = 3,
				note = "+ Rasengan",
				cost = 1500,
				primary_attack = "naruto:rasengan_base",
				range = 15,
				damage = 25.5
			}
		},
		health = 100,
		primary_attack_no_upgrades = "shuriken_throw",
		cooldown = 10,
		shiny = true
	},
	smoker = {
		upgrade_script = true,
		hybrid_placement = true,
		name = "Smoka",
		health = 20,
		id = "smoker",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	akaza_raid = {
		attack_cooldown = 15,
		primary_attack_no_upgrades = "akaza_raid:compass",
		id = "akaza_raid",
		range = 100,
		animation_set = "default",
		_EFFECT_SCRIPTS = {
			[1] = "akaza_compass"
		},
		name = "Akoku",
		ASSETS = {
			effect_models = {
				[1] = "akaza_compass"
			},
			particles = {
				[1] = "akaza_buffed"
			},
			sfx = {
				[1] = "power_up",
				[2] = "RocksDebris2"
			}
		},
		speed = 15,
		hybrid_placement = true,
		health = 5000
	},
	yammy_evolved = {
		id = "yammy_evolved",
		range = 7,
		spawn_anim = "rage_spawn",
		health = 20,
		name = "Yammo (ZanpakutÅ)",
		spawn_effects = {
			[1] = {
				id = "yammy_evolved_spawn"
			}
		},
		speed = 1,
		animation_set = "default",
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	krillin = {
		attack_cooldown = 4,
		primary_attack_no_upgrades = "krillin:double_beams",
		hill_unit = true,
		range = 15,
		ranged_only = true,
		speed = 1,
		damage = 4,
		rarity = "Rare",
		id = "krillin",
		hybrid_placement = true,
		ASSETS = {
			effect_models = {
				[1] = "destructo_disc"
			},
			sfx = {
				[1] = "ki_explosion",
				[2] = "EnergyBlast",
				[3] = "destructo_disc"
			},
			projectiles = {
				[1] = "krillin_double_beams_orb"
			}
		},
		animation_set = "default",
		knockback_points = {
			[1] = 0.5
		},
		spawn_cap = 6,
		name = "Krillo",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 9,
				range = 16,
				cost = 600
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 17,
				range = 17,
				cost = 1200
			},
			[3] = {
				attack_cooldown = 3,
				note = "+ Destructo Disc",
				primary_attack = "krillin:destructo_disc",
				cost = 1700,
				range = 18,
				damage = 20
			},
			[4] = {
				attack_cooldown = 3,
				damage = 27,
				range = 20,
				cost = 2000
			}
		},
		health = 50,
		cost = 400,
		cooldown = 10,
		shiny = true
	},
	daki = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "daki:beam_aoe",
		id = "daki",
		range = 100,
		animation_set = "default",
		name = "Daka",
		ASSETS = {
			vfx = {
				[1] = "daki_beam"
			},
			particles = {
				[1] = "daki_hit"
			},
			sfx = {
				[1] = "rope_shoot"
			}
		},
		speed = 15,
		hybrid_placement = true,
		health = 5000
	},
	colossal_titan = {
		attack_cooldown = 30,
		primary_attack_no_upgrades = "colossal_titan:steam",
		id = "colossal_titan",
		range = 20,
		animation_set = "default",
		hybrid_placement = true,
		name = "Colossal Titan",
		knockback_points = {},
		speed = 5,
		ASSETS = {
			sfx = {
				[1] = "titan_shift_boss",
				[2] = "electricity_aura",
				[3] = "physical_explosion_with_debris",
				[4] = "electric_explosion",
				[5] = "titan_roar_beast",
				[6] = "wind_long",
				[7] = "steam_hiss"
			}
		},
		spawn_attack = "colossal_titan:spawn",
		health = 10000
	},
	zarbon_evolved = {
		attack_cooldown = 10,
		id = "zarbon_evolved",
		range = 20,
		animation_set = "fly_1",
		health = 1500,
		boss = true,
		name = "Zarbo (Evolved)",
		spawn_effects = {
			[1] = {
				id = "zarbon_evolved_spawn"
			}
		},
		speed = 1,
		knockback_points = {
			[1] = 0.5
		},
		hybrid_placement = true,
		damage = 100
	},
	naruto_pts = {
		attack_cooldown = 7,
		cost = 850,
		range = 10,
		moving_gui_offset = CFrame.new(-0.0500000007, 0.300000012, -1.39999998, -0.996198535, -0.00759611372, -0.0868242979, -2.78711949e-13, 0.99619472, -0.0871560648, 0.0871559605, -0.0868240893, -0.99240768),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 60,
		hybrid_placement = true,
		rarity = "Legendary",
		ASSETS = {
			_new_fx = {
				[1] = "naruto_pts"
			},
			sfx = {
				[1] = "bladedismember2",
				[2] = "rasengan_explosion",
				[3] = "naruto_beam_charge",
				[4] = "woosh_medium",
				[5] = "rasengan",
				[6] = "pika_explode"
			}
		},
		id = "naruto_pts",
		hide_from_banner = true,
		live_model_offset = CFrame.new(0, 0.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		animation_set = "naruto_pts",
		health = 100,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 4,
						unit_id = "naruto_pts"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "naruto_seal",
						amount = 2
					}
				}
			},
			evolve_unit = "naruto_pts_evolved",
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 4,
						unit_id = "naruto_pts"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "naruto_seal",
						amount = 2
					}
				}
			},
			evolve_text = "+Noruto (Beast Cloak)"
		},
		name = "Noruto (Demon Cloak)",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 120,
				range = 11,
				cost = 1150
			},
			[2] = {
				attack_cooldown = 7,
				damage = 150,
				range = 12,
				cost = 1700
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Vermillion Slash",
				primary_attack = "naruto_pts:slash",
				cost = 2150,
				range = 15,
				damage = 175
			},
			[4] = {
				attack_cooldown = 6.5,
				damage = 200,
				range = 16,
				cost = 2400
			},
			[5] = {
				attack_cooldown = 6,
				damage = 250,
				range = 17,
				cost = 3100
			},
			[6] = {
				attack_cooldown = 6,
				damage = 300,
				range = 18,
				cost = 3300
			},
			[7] = {
				attack_cooldown = 6,
				note = "+ Vermillion Rasengan",
				primary_attack = "naruto_pts:chuck",
				cost = 5250,
				range = 21,
				damage = 325
			},
			[8] = {
				attack_cooldown = 5.5,
				damage = 375,
				range = 22,
				cost = 5500
			}
		},
		primary_attack_no_upgrades = "naruto_pts:rasengan",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	hidan = {
		hybrid_placement = true,
		speed = 1,
		name = "Hido",
		health = 20,
		id = "hidan",
		buffs = {
			[1] = {
				time = -1,
				name = "healing",
				params = {
					persistent = true,
					percent = 0.005,
					healing_rate = 1
				}
			}
		},
		range = 7,
		animation_set = "sword:1h_long"
	},
	meruem = {
		attack_cooldown = 7,
		cost = 1300,
		range = 12,
		moving_gui_offset = CFrame.new(1.56324105e-13, -0.449999988, -1.07999825, -1, 0, -8.74227766e-08, 0, 1, 0, 8.74227766e-08, 0, -1),
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 150,
		rarity = "Mythic",
		id = "meruem",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "meruem"
			},
			sfx = {
				[1] = "strong_sword_slash",
				[2] = "slash_heavy_slow"
			}
		},
		animation_set = "meruem",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "meruem"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "gungi_set",
						amount = 2
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "meruem"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "gungi_set",
						amount = 2
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit = "meruem_evolved",
			evolve_text = "+King Meruam"
		},
		health = 100,
		name = "Meruam",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 250,
				range = 12,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 350,
				range = 13,
				cost = 2750
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 500,
				range = 13,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 600,
				range = 14,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 6,
				note = "+ Hunger",
				cost = 6500,
				primary_attack = "meruem:tail_swipes",
				range = 15,
				damage = 1000
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 1200,
				range = 17,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 1500,
				range = 20,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 5,
				damage = 1800,
				range = 20,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "meruem:summersault",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	piccolo = {
		attack_cooldown = 10,
		cost = 500,
		range = 30,
		ranged_only = true,
		damage = 8,
		rarity = "Epic",
		id = "piccolo",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "piccolo_ball",
				[2] = "piccolo_ground_beam",
				[3] = "piccolo_mouth_beam",
				[4] = "special_beam_cannon"
			},
			particles = {
				[1] = "piccolo_mouth_beam_charge"
			},
			sfx = {
				[1] = "dbz_charge_two",
				[2] = "sweeping_beam",
				[3] = "futuristic_blast"
			}
		},
		animation_set = "default",
		knockback_points = {
			[1] = 0.5
		},
		health = 1000,
		name = "Piccoru",
		upgrade = {
			[1] = {
				attack_cooldown = 10,
				damage = 20,
				range = 30,
				cost = 750
			},
			[2] = {
				attack_cooldown = 8,
				damage = 25,
				range = 35,
				cost = 1100
			},
			[3] = {
				attack_cooldown = 8,
				damage = 35,
				range = 35,
				cost = 1300
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Explosive Breath Cannon",
				primary_attack = "piccolo:mouth_beam",
				cost = 1750,
				range = 40,
				damage = 45
			},
			[5] = {
				attack_cooldown = 6,
				damage = 60,
				range = 45,
				cost = 2000
			}
		},
		primary_attack_no_upgrades = "piccolo:special_beam_cannon",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	crocodile = {
		attack_cooldown = 8,
		cost = 550,
		range = 19,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 10,
		rarity = "Epic",
		id = "crocodile",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			_new_fx = {
				[1] = "crocodile"
			},
			effect_models = {},
			vfx = {},
			sfx = {
				[1] = "crocodile_explosion_lightning",
				[2] = "crocodile_throw_and_explode",
				[3] = "crocodile_sandstorm",
				[4] = "crocodile_lightning_flashes",
				[5] = "crocodile_sand_rise"
			}
		},
		spawn_cap = 5,
		name = "Croc",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 25,
				range = 20,
				cost = 1000
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 37,
				range = 21,
				cost = 1250
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Pesado",
				primary_attack = "crocodile:throw_explosion",
				cost = 1500,
				range = 21.5,
				damage = 55
			},
			[4] = {
				attack_cooldown = 6.5,
				damage = 75,
				range = 22,
				cost = 2000
			},
			[5] = {
				attack_cooldown = 6,
				damage = 90,
				range = 22,
				cost = 2500
			},
			[6] = {
				attack_cooldown = 6.5,
				note = "+ Sables",
				primary_attack = "crocodile:tornado",
				cost = 3000,
				range = 22.5,
				damage = 150
			},
			[7] = {
				attack_cooldown = 6,
				damage = 200,
				range = 23,
				cost = 3500
			}
		},
		primary_attack_no_upgrades = "crocodile:spikes",
		health = 100,
		cooldown = 10,
		shiny = true
	},
	pain = {
		attack_cooldown = 10,
		cost = 825,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 35,
		rarity = "Legendary",
		id = "pain",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			vfx = {
				[1] = "almighty_push",
				[2] = "meteor",
				[3] = "pain_meteor",
				[4] = "pain_meteor_ball"
			},
			sfx = {
				[1] = "physical_explosion",
				[2] = "almighty_push",
				[3] = "rinnegan_activate",
				[4] = "RocksDebris2"
			}
		},
		upgrade = {
			[1] = {
				attack_cooldown = 9,
				damage = 70,
				range = 11,
				cost = 1150
			},
			[2] = {
				attack_cooldown = 8.5,
				damage = 100,
				range = 12,
				cost = 1250
			},
			[3] = {
				attack_cooldown = 8,
				damage = 125,
				range = 13,
				cost = 1500
			},
			[4] = {
				attack_cooldown = 7,
				damage = 150,
				range = 14,
				cost = 2500
			},
			[5] = {
				attack_cooldown = 6.5,
				note = "+ Almighty Push",
				primary_attack = "pain:almighty_push",
				cost = 6000,
				range = 16,
				damage = 200
			},
			[6] = {
				attack_cooldown = 6,
				damage = 225,
				range = 17,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 6,
				damage = 300,
				range = 18.5,
				cost = 8500
			}
		},
		name = "Agony",
		primary_attack_no_upgrades = "pain:meteor",
		health = 1000,
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	future_gohan = {
		attack_cooldown = 8,
		cost = 1500,
		range = 16,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		special_note = "[Limited] - Obtained by achieving a top 25 infinite run in Week 1",
		special_note_shiny = "[Limited] - Obtained by achieving a top 10 infinite run in Week 1",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "future_gohan"
			},
			effect_models = {},
			vfx = {},
			sfx = {
				[1] = "dbz_beam_fire",
				[2] = "ki_explosion",
				[3] = "dbz_charge_three",
				[4] = "dbz_beam_fire",
				[5] = "dbz_punch_barrage",
				[6] = "futuristic_blast",
				[7] = "charge_echo_long"
			}
		},
		rarity = "Mythic",
		gone_parts = {
			[1] = "Left Arm"
		},
		id = "future_gohan",
		hide_from_banner = true,
		shiny = true,
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 200,
				range = 17,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7,
				damage = 300,
				range = 18,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Masenko",
				primary_attack = "future_gohan:beam_1",
				cost = 3750,
				range = 19,
				damage = 400
			},
			[4] = {
				attack_cooldown = 7,
				damage = 550,
				range = 19.5,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 7,
				damage = 750,
				range = 20,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 850,
				range = 22,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 6.5,
				note = "+ Kami Blast",
				primary_attack = "future_gohan:beam_2",
				cost = 9500,
				range = 25,
				damage = 1000
			},
			[8] = {
				attack_cooldown = 6,
				damage = 1200,
				range = 27,
				cost = 12500
			}
		},
		damage = 100,
		name = "Future Guhon",
		primary_attack_no_upgrades = "future_gohan:ki_blasts",
		spawn_cap = 5,
		blessing = {
			normal = "future_gohan",
			shiny = "future_gohan_shiny"
		},
		cooldown = 10,
		health = 2000
	},
	starrk_evolved = {
		attack_cooldown = 8,
		max_spawns = {
			starrk_wolf_unit = 3
		},
		primary_attack_no_upgrades = "starrk:shoot",
		range = 30,
		_EFFECT_SCRIPTS = {
			[1] = "starrk_wolf_spawn"
		},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			use_own_model = true,
			from = "starrk"
		},
		damage = 225,
		rarity = "Mythic",
		id = "starrk_evolved",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "starrk"
			},
			particles = {
				[1] = "wolf_spawn"
			},
			sfx = {
				[1] = "draw_gun",
				[2] = "futuristic_blast",
				[3] = "pulse2",
				[4] = "cero_fire",
				[5] = "futuristic_charge2",
				[6] = "wolf_bite",
				[7] = "wolf_howl",
				[8] = "starrk_vo"
			}
		},
		animation_set = "starrk",
		max_spawn_units = 3,
		health = 100,
		name = "Coyote (Primera)",
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 450,
				range = 31,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7,
				damage = 750,
				range = 32,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 1200,
				range = 33,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 1500,
				range = 35,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 15,
				note = "+ Cero Metralleta",
				cost = 6000,
				primary_attack = "starrk:metra",
				range = 45,
				damage = 1800
			},
			[6] = {
				attack_cooldown = 15,
				damage = 2250,
				range = 46,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 14.5,
				damage = 3000,
				range = 47,
				cost = 15000
			},
			[8] = {
				attack_cooldown = 14,
				note = "+ Los Lobos",
				cost = 25000,
				damage = 4125,
				range = 48,
				secondary_attacks = {
					[1] = {
						id = "starrk:summon",
						priority = 0
					}
				}
			},
			[9] = {
				attack_cooldown = 13,
				damage = 4950,
				range = 50,
				cost = 30000
			}
		},
		cost = 1600,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	eren_founding_titan = {
		upgrade_script = true,
		not_humanoid_rig = true,
		walk_run_mode = "walk",
		id = "eren_founding_titan",
		hide_from_banner = true,
		range = 100,
		animation_set = "eren_founding_unit",
		spawn_anim = "_foundingtitanspawn",
		override_death_fx = "death_slow_destroy_instance",
		name = "Erein (Founding Titan)",
		spawn_effects = {
			[1] = {
				id = "eren_rumbling_without_model"
			}
		},
		speed = 1,
		max_angular_velocity = 0.19634954084936207,
		hybrid_placement = true,
		health = 10000
	},
	kizaru = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "kizaru:teleport",
		id = "kizaru",
		range = 7,
		animation_set = "default",
		name = "Kizora",
		ASSETS = {
			vfx = {
				[1] = "PikaFlight"
			},
			particles = {
				[1] = "PikaFlightEnd",
				[2] = "PikaFlightExplode"
			},
			sfx = {
				[1] = "pika_teleport"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	overhaul = {
		attack_cooldown = 3,
		cost = 525,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 15,
		rarity = "Epic",
		id = "overhaul",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "overhaul_spike"
			},
			particles = {
				[1] = "overhaul_lightning_particle",
				[2] = "deconstruct",
				[3] = "lightning_ref_overhaul"
			},
			sfx = {
				[1] = "zap2",
				[2] = "gore_explode",
				[3] = "electric_sparks",
				[4] = "zap1",
				[5] = "physical_explosion_with_debris"
			}
		},
		shiny = true,
		name = "Underhaul",
		upgrade = {
			[1] = {
				attack_cooldown = 3,
				damage = 30,
				range = 16,
				cost = 550
			},
			[2] = {
				attack_cooldown = 2.5,
				damage = 37,
				range = 17,
				cost = 650
			},
			[3] = {
				attack_cooldown = 2.5,
				damage = 60,
				range = 18,
				cost = 1250
			},
			[4] = {
				attack_cooldown = 2,
				damage = 70,
				range = 19,
				cost = 1550
			},
			[5] = {
				attack_cooldown = 5,
				note = "+ Reassemble",
				cost = 3500,
				primary_attack = "overhaul:spikes",
				range = 22,
				damage = 70
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 80,
				range = 25,
				cost = 3000
			}
		},
		primary_attack_no_upgrades = "overhaul:deconstruct",
		spawn_cap = 5,
		cooldown = 10,
		health = 5000
	},
	ccg_one = {
		hybrid_placement = true,
		name = "Junior Investigator",
		health = 20,
		id = "ccg_one",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	law = {
		attack_cooldown = 4,
		primary_attack_no_upgrades = "law:shot",
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 20,
		rarity = "Epic",
		shiny = true,
		animation_set = "sword:1h",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "law_blur",
				[2] = "law_blur_2",
				[3] = "law_blade",
				[4] = "law_crosshair",
				[5] = "law_gamma_impact",
				[6] = "law_shot_impact",
				[7] = "room_spiral"
			},
			effect_models = {
				[1] = "room",
				[2] = "room_backup"
			},
			_new_fx = {
				[1] = "law_revamp"
			},
			sfx = {
				[1] = "room_activate",
				[2] = "teleport",
				[3] = "Lightning_Release",
				[4] = "gamma_knife"
			}
		},
		name = "Lao",
		cost = 525,
		id = "law",
		health = 2000,
		cooldown = 10,
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 42,
				range = 16,
				cost = 650
			},
			[2] = {
				attack_cooldown = 4,
				damage = 70,
				range = 17,
				cost = 800
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 95,
				range = 18,
				cost = 1300
			},
			[4] = {
				attack_cooldown = 3.5,
				damage = 150,
				range = 19,
				cost = 2100
			},
			[5] = {
				attack_cooldown = 3.5,
				note = "+ Gamma Knife",
				cost = 2750,
				primary_attack = "law:gamma",
				range = 20,
				damage = 225
			},
			[6] = {
				attack_cooldown = 3,
				damage = 250,
				range = 25,
				cost = 3500
			}
		}
	},
	zeke = {
		attack_cooldown = 10,
		cost = 700,
		hill_unit = true,
		range = 30,
		_EFFECT_SCRIPTS = {
			[1] = "titan_small_minion_spawn",
			[2] = "titan_spawn_shift",
			[3] = "titan_shifter_spawn_lightning"
		},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		delayed_spawn = 0.7333333333333333,
		damage = 30,
		hybrid_placement = true,
		character_model = "beast_titan_smaller",
		rarity = "Legendary",
		delayed_spawn_attack = "titan_shifter_spawn",
		id = "zeke",
		hide_from_banner = true,
		ASSETS = {
			vfx = {
				[1] = "beast_titan_rock_smaller",
				[2] = "beast_titan_rock_shard"
			},
			sfx = {
				[1] = "Thunder_explosion",
				[2] = "steam_hiss",
				[3] = "titan_shift_two",
				[4] = "physical_explosion_with_debris",
				[5] = "eren_roar",
				[6] = "steam_hiss",
				[7] = "titan_roar_generic",
				[8] = "woosh_long",
				[9] = "physical_explosion_debris_fast",
				[10] = "RocksDebris1",
				[11] = "crunch"
			}
		},
		animation_set = "titan",
		pet_animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 10,
				damage = 60,
				range = 32,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 9,
				damage = 120,
				range = 35,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 9,
				damage = 200,
				range = 40,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 8,
				note = "+ Pitching Assault",
				primary_attack = "zeke:rock_throw_2",
				cost = 4500,
				range = 45,
				damage = 300
			},
			[5] = {
				attack_cooldown = 8,
				damage = 400,
				range = 50,
				cost = 6000
			}
		},
		name = "Zeike",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_shift_zeke",
				modifiers = {
					human_unit = "zeke"
				}
			}
		},
		health = 100,
		primary_attack_no_upgrades = "zeke:rock_throw",
		cooldown = 10,
		shiny = true
	},
	naruto_raid_minion = {
		hybrid_placement = true,
		name = "Desert Assassin",
		health = 20,
		id = "naruto_raid_minion",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	C3_bomb = {
		id = "C3_bomb",
		range = 12,
		animation_set = "default",
		health = 20,
		ASSETS = {
			sfx = {
				[1] = "katsu",
				[2] = "liquid_to_form_something",
				[3] = "physical_explosion_squeeze"
			}
		},
		speed = 1,
		name = "Clay Art",
		hybrid_placement = true,
		death_attack = "deidara_clone:self_destruct"
	},
	madara_evolved = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "madara:fan",
		range = 11,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "madara"
		},
		damage = 180,
		rarity = "Mythic",
		id = "madara_evolved",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			vfx = {
				[1] = "madara_fan_glow",
				[2] = "madara_susanoo_humanoid",
				[3] = "madara_susanoo_small"
			},
			effect_models = {
				[1] = "madara_fan",
				[2] = "madara_susanoo",
				[3] = "madara_particles",
				[4] = "madara_susanoo_small"
			},
			sfx = {
				[1] = "equip_generic",
				[2] = "pulse1",
				[3] = "wind_blast",
				[4] = "RocksDebris3",
				[5] = "sharingan_activate",
				[6] = "earthquake_long",
				[7] = "slash_high",
				[8] = "pulse_slash",
				[9] = "madara_susanoo"
			}
		},
		spawn_cap = 4,
		name = "Marada (Founder)",
		upgrade = {
			[1] = {
				attack_cooldown = 9,
				damage = 300,
				range = 13,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 360,
				range = 15,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 12,
				note = "+ Susanoo Strike",
				primary_attack = "madara:susanoo_small_evolved",
				cost = 3500,
				range = 20,
				damage = 540
			},
			[4] = {
				attack_cooldown = 11,
				damage = 660,
				range = 22,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 10,
				damage = 780,
				range = 23,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 10,
				damage = 960,
				range = 24,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 10,
				damage = 1200,
				range = 25,
				cost = 9000
			},
			[8] = {
				attack_cooldown = 15,
				note = "+ Perfected Susanoo!",
				primary_attack = "madara:susanoo_evolved",
				cost = 12000,
				range = 30,
				damage = 1800
			},
			[9] = {
				attack_cooldown = 15,
				damage = 2400,
				range = 30,
				cost = 15000
			}
		},
		health = 100,
		cost = 1400,
		cooldown = 10,
		shiny = true
	},
	lawliet = {
		attack_cooldown = 0,
		range = 5,
		farm_amount = 250,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 0,
		upgrade_script = true,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "lawliet",
		hide_from_banner = true,
		ASSETS = {
			_new_fx = {
				[1] = "lawliet"
			}
		},
		animation_set = "lawliet_unit",
		pet_animation_set = "lawliet_pet",
		upgrade = {
			[1] = {
				farm_amount = 750,
				cost = 1500
			},
			[2] = {
				farm_amount = 1500,
				cost = 3000
			},
			[3] = {
				farm_amount = 3000,
				cost = 4500
			}
		},
		name = "L",
		health = 100,
		cost = 800,
		spawn_cap = 1,
		cooldown = 10,
		shiny = true
	},
	sanji = {
		attack_cooldown = 4,
		cost = 250,
		range = 6,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		spawn_attack = "sanji:diabe_jamble",
		damage = 15,
		rarity = "Rare",
		id = "sanji",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			particles = {
				[1] = "round_fire_kick"
			},
			sfx = {
				[1] = "fire_explosion_1"
			}
		},
		shiny = true,
		name = "Sanjay",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 30,
				range = 6,
				cost = 300
			},
			[2] = {
				attack_cooldown = 4,
				note = "+ Fire Kick",
				cost = 450,
				primary_attack = "sanji:kick_combo",
				range = 7,
				damage = 40
			},
			[3] = {
				attack_cooldown = 4,
				damage = 50,
				range = 7,
				cost = 600
			},
			[4] = {
				attack_cooldown = 4,
				note = "+ Party Table",
				cost = 1250,
				primary_attack = "sanji:table_kick",
				range = 8,
				damage = 50
			},
			[5] = {
				attack_cooldown = 4,
				damage = 90,
				range = 8,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "spin_single_kick",
		spawn_cap = 6,
		cooldown = 10,
		health = 5000
	},
	big_test = {
		cost = 1000,
		id = "big_test",
		approach_distance = 5.5,
		range = 100,
		animation_set = "default",
		attacks = {
			jonathan:punches = {
				damage = 40,
				cooldown = 1.23,
				weight = 1
			}
		},
		name = "Colossal Titan",
		knockback_points = {
			[1] = 0.5
		},
		speed = 8,
		hybrid_placement = true,
		cooldown = 10,
		health = 20000
	},
	hollow_abnormal = {
		hybrid_placement = true,
		animation_set = "default",
		name = "Fish Hollow",
		health = 20,
		id = "hollow_abnormal",
		speed = 1,
		range = 7,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	wall_titan_two = {
		hybrid_placement = true,
		speed = 5,
		name = "Tall Wall Titan",
		knockback_points = {},
		id = "wall_titan_two",
		health = 10000,
		range = 100,
		animation_set = "default"
	},
	kisame = {
		upgrade_script = true,
		hybrid_placement = true,
		name = "Kizume",
		health = 20,
		id = "kisame",
		speed = 1,
		range = 7,
		animation_set = "kisame"
	},
	usopp = {
		attack_cooldown = 3,
		cost = 300,
		hill_unit = true,
		range = 25,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 3,
		upgrade_script = true,
		rarity = "Rare",
		id = "usopp",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "bamboo"
			},
			sfx = {
				[1] = "bow_draw",
				[2] = "bow_release",
				[3] = "dirt",
				[4] = "plant_grow"
			},
			projectiles = {
				[1] = "slingshot_ball"
			}
		},
		shiny = true,
		name = "Usoap",
		upgrade = {
			[1] = {
				attack_cooldown = 2.5,
				damage = 5.5,
				range = 25,
				cost = 450
			},
			[2] = {
				attack_cooldown = 2,
				damage = 7,
				range = 27,
				cost = 650
			},
			[3] = {
				attack_cooldown = 2,
				note = "+ Bamboo Shot",
				cost = 1500,
				primary_attack = "usopp:bamboo",
				range = 30,
				damage = 7
			},
			[4] = {
				attack_cooldown = 1.5,
				damage = 8.5,
				range = 35,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "usopp:slingshot_basic",
		spawn_cap = 6,
		cooldown = 2.2,
		health = 1000
	},
	deidara_clone_large = {
		id = "deidara_clone_large",
		range = 16,
		animation_set = "default",
		health = 20,
		ASSETS = {
			sfx = {
				[1] = "katsu",
				[2] = "liquid_to_form_something",
				[3] = "physical_explosion_squeeze"
			}
		},
		speed = 1,
		name = "Giant Explosive Clone",
		hybrid_placement = true,
		death_attack = "deidara_clone:self_destruct"
	},
	gyokko = {
		hybrid_placement = true,
		shield = 5,
		name = "Fish Demon",
		health = 20,
		id = "gyokko",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	eren_founding_titan_boss = {
		max_angular_velocity = 0.19634954084936207,
		walk_run_mode = "walk",
		range = 100,
		override_death_fx = "death_slow_destroy_instance",
		_EFFECT_SCRIPTS = {
			[1] = "eren_rumbling_without_model"
		},
		ASSETS = {
			vfx = {
				[1] = "eren_founding_titan"
			},
			_new_fx = {
				[1] = "eren_final"
			},
			sfx = {
				[1] = "titan_shift_boss",
				[2] = "electricity_aura",
				[3] = "physical_explosion_with_debris",
				[4] = "electric_explosion",
				[5] = "titan_roar_beast",
				[6] = "wind_long",
				[7] = "steam_hiss",
				[8] = "Thunder_explosion"
			}
		},
		speed = 1,
		upgrade_script = true,
		character_model = "eren_founding_titan",
		not_humanoid_rig = true,
		id = "eren_founding_titan_boss",
		animation_set = "eren_founding_unit",
		health = 10000,
		spawn_effects = {
			[1] = {
				id = "eren_rumbling_without_model"
			}
		},
		spawn_anim = "_foundingtitanspawn",
		hybrid_placement = true,
		name = "Erein (Founding Titan)"
	},
	uryu = {
		attack_cooldown = 6,
		primary_attack_no_upgrades = "uryu:shot",
		hill_unit = true,
		range = 20,
		moving_gui_offset = CFrame.new(1.56324105e-13, -0.5, -1.08000004, -1, 0, -8.74227766e-08, 0, 1, 0, 8.74227766e-08, 0, -1),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 60,
		rarity = "Mythic",
		id = "uryu",
		hybrid_placement = true,
		animation_set = "uryu",
		ASSETS = {
			_new_fx = {
				[1] = "uryu"
			},
			sfx = {
				[1] = "futuristic_charge_fast",
				[2] = "bow_release",
				[3] = "futuristic_blast4",
				[4] = "shuriken_hit",
				[5] = "pika_shot",
				[6] = "laser_fire",
				[7] = "physical_explosion_laser"
			}
		},
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "uryu"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "uryu_star",
						amount = 3
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "uryu"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "uryu_star",
						amount = 3
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			evolve_unit = "uryu_evolved",
			evolve_text = "+25% Attack, +25% Crit, +Holy Arrow"
		},
		name = "Uru",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 5.5,
				damage = 100,
				range = 20.5,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 150,
				range = 21,
				cost = 2000
			},
			[3] = {
				attack_cooldown = 5,
				damage = 200,
				range = 22,
				cost = 2500
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Rain of Light",
				cost = 3500,
				primary_attack = "uryu:volley",
				range = 25,
				damage = 250
			},
			[5] = {
				attack_cooldown = 4.5,
				damage = 350,
				range = 27,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 450,
				range = 30,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 4,
				damage = 550,
				range = 35,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 4,
				damage = 600,
				range = 40,
				cost = 9000
			}
		},
		cost = 1250,
		cooldown = 10,
		shiny = true
	},
	hisoka = {
		attack_cooldown = 7,
		cost = 850,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 40,
		rarity = "Legendary",
		id = "hisoka",
		hybrid_placement = true,
		animation_set = "hisoka",
		ASSETS = {
			_new_fx = {
				[1] = "hisoka"
			},
			sfx = {
				[1] = "dash_weird",
				[2] = "slash_heavy_slow",
				[3] = "spin_constant",
				[4] = "woosh_throw_heavier",
				[5] = "mochi_barrage_hit",
				[6] = "card_flip",
				[7] = "woosh_throw_heavy",
				[8] = "hisoka_card_slice",
				[9] = "card_woosh"
			}
		},
		health = 1000,
		name = "Hisova",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 80,
				range = 16,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 7,
				damage = 120,
				range = 17,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Bungee Flail",
				cost = 2250,
				primary_attack = "hisoka:spin_projectiles",
				range = 20,
				damage = 200
			},
			[4] = {
				attack_cooldown = 6.5,
				damage = 350,
				range = 21,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 6.5,
				damage = 450,
				range = 22,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 6,
				note = " + Five of a Kind!",
				cost = 7000,
				primary_attack = "hisoka:5_kind",
				range = 23,
				damage = 500
			},
			[7] = {
				attack_cooldown = 6,
				damage = 600,
				range = 24,
				cost = 8000
			}
		},
		spawn_cap = 4,
		primary_attack_no_upgrades = "hisoka:slash",
		cooldown = 10,
		shiny = true
	},
	zetsu_clone_2 = {
		id = "zetsu_clone_2",
		range = 7,
		animation_set = "default",
		death_spawn = {
			additional_params = {
				override_spawn_anim = "ground_rise"
			},
			spawn_unit_fx = {
				[1] = {
					id = "zetsu_spawn_unit",
					modifiers = {
						death_effect = true
					}
				}
			},
			amount = 2,
			delay = 0,
			units = {
				[1] = {
					health_ratio = 0.5,
					unit = "zetsu_clone"
				}
			}
		},
		name = "Merged Clone",
		ASSETS = {
			vfx = {
				[1] = "zetsu_spawn_ball"
			},
			sfx = {
				[1] = "plant_grow"
			}
		},
		speed = 1,
		spawn_anim = "ground_rise",
		hybrid_placement = true,
		health = 20
	},
	burter = {
		id = "burter",
		range = 20,
		animation_set = "default",
		hybrid_placement = true,
		boss = true,
		name = "Vurtor",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		ASSETS = {
			vfx = {
				[1] = "frieza_spawn_lazer"
			},
			sfx = {
				[1] = "teleport_dbz",
				[2] = "stomp"
			}
		},
		spawn_attack = "ginyu_force:spawn",
		health = 30000
	},
	dabi = {
		attack_cooldown = 7,
		cost = 875,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 25,
		rarity = "Legendary",
		id = "dabi",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "dabi_fire",
				[2] = "cremation"
			},
			particles = {
				[1] = "dabi_fire_arm"
			},
			sfx = {
				[1] = "fire_cast",
				[2] = "fire_explosion_2",
				[3] = "flamethrower",
				[4] = "woosh_medium"
			}
		},
		health = 2000,
		name = "Dabo",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 50,
				range = 17,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 5,
				damage = 65,
				range = 18,
				cost = 1700
			},
			[3] = {
				attack_cooldown = 5,
				damage = 100,
				range = 19,
				cost = 2200
			},
			[4] = {
				attack_cooldown = 4.5,
				damage = 125,
				range = 20,
				cost = 2500
			},
			[5] = {
				attack_cooldown = 8.5,
				note = "+ Cremation",
				primary_attack = "dabi:cremation",
				cost = 4000,
				range = 22,
				damage = 225
			},
			[6] = {
				attack_cooldown = 8,
				damage = 275,
				range = 24,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 7,
				damage = 400,
				range = 26,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "dabi:fire_punch",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	beast_titan = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "beast_titan_boss:rock",
		id = "beast_titan",
		range = 100,
		animation_set = "default",
		spawn_anim = "titan",
		ASSETS = {
			vfx = {
				[1] = "beast_titan_rock"
			},
			sfx = {
				[1] = "steam_hiss",
				[2] = "titan_roar_generic",
				[3] = "woosh_long",
				[4] = "physical_explosion_debris_fast",
				[5] = "RocksDebris1"
			}
		},
		name = "Beast Titan",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_smoke"
			},
			[2] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx_params = {
						tween_out_time = 0.5
					},
					sfx = "titan_roar_generic"
				}
			}
		},
		speed = 5,
		knockback_points = {},
		hybrid_placement = true,
		health = 10000
	},
	madara = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "madara:fan",
		range = 11,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 150,
		rarity = "Mythic",
		id = "madara",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "madara_fan_glow",
				[2] = "madara_susanoo_humanoid",
				[3] = "madara_susanoo_small"
			},
			effect_models = {
				[1] = "madara_fan",
				[2] = "madara_susanoo",
				[3] = "madara_particles",
				[4] = "madara_susanoo_small"
			},
			sfx = {
				[1] = "equip_generic",
				[2] = "pulse1",
				[3] = "wind_blast",
				[4] = "RocksDebris3",
				[5] = "sharingan_activate",
				[6] = "earthquake_long",
				[7] = "slash_high",
				[8] = "pulse_slash",
				[9] = "madara_susanoo"
			}
		},
		animation_set = "naruto",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "madara"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "rinnegan_eye",
						amount = 2
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "madara"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "rinnegan_eye",
						amount = 2
					}
				}
			},
			evolve_unit = "madara_evolved",
			evolve_text = "+20% damage, +Susanoo fire"
		},
		spawn_cap = 4,
		name = "Marada",
		upgrade = {
			[1] = {
				attack_cooldown = 9,
				damage = 250,
				range = 13,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 300,
				range = 15,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 12,
				note = "+ Susanoo Strike",
				primary_attack = "madara:susanoo_small",
				cost = 3500,
				range = 20,
				damage = 450
			},
			[4] = {
				attack_cooldown = 11,
				damage = 550,
				range = 22,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 10,
				damage = 650,
				range = 23,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 10,
				damage = 800,
				range = 24,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 10,
				damage = 1000,
				range = 25,
				cost = 9000
			},
			[8] = {
				attack_cooldown = 15,
				note = "+ Perfected Susanoo!",
				primary_attack = "madara:susanoo",
				cost = 12000,
				range = 30,
				damage = 1500
			}
		},
		health = 100,
		cost = 1400,
		cooldown = 10,
		shiny = true
	},
	hollow_fly = {
		id = "hollow_fly",
		passives = {
			Flying = true
		},
		range = 7,
		spawn_anim = "ground_rise",
		name = "Winged Hollow",
		speed = 1,
		animation_set = "fly_1",
		hybrid_placement = true,
		health = 20
	},
	itachi = {
		attack_cooldown = 6,
		primary_attack_no_upgrades = "amaterasu_2",
		hill_unit = true,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 90,
		rarity = "Legendary",
		id = "itachi",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			vfx = {
				[1] = "amaterasu"
			},
			particles = {
				[1] = "amaterasu",
				[2] = "amaterasu_activate",
				[3] = "amaterasu_ref"
			},
			sfx = {
				[1] = "sharingan_activate",
				[2] = "fire_explosion_3"
			}
		},
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 150,
				range = 16,
				cost = 800
			},
			[2] = {
				attack_cooldown = 6,
				damage = 175,
				range = 17,
				cost = 1000
			},
			[3] = {
				attack_cooldown = 5.5,
				damage = 200,
				range = 18,
				cost = 1000
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Black Fire Release",
				primary_attack = "amaterasu",
				cost = 4000,
				range = 20,
				damage = 200
			},
			[5] = {
				attack_cooldown = 5,
				damage = 300,
				range = 23,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 400,
				range = 25,
				cost = 6500
			}
		},
		name = "Itochi",
		health = 1000,
		cost = 900,
		spawn_cap = 5,
		cooldown = 6,
		shiny = true
	},
	tanjiro = {
		attack_cooldown = 4,
		cost = 350,
		range = 6,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 15,
		rarity = "Rare",
		id = "tanjiro",
		hybrid_placement = true,
		animation_set = "sword:1h",
		ASSETS = {
			sfx = {
				[1] = "spin_fast",
				[2] = "water_splash",
				[3] = "spin_slow"
			},
			effect_models = {
				[1] = "tanjiro_wheel",
				[2] = "tanjiro_whirlpool"
			}
		},
		health = 2000,
		name = "Tanji",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 25,
				range = 6,
				cost = 500
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 40,
				range = 6.5,
				cost = 700
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 50,
				range = 6.5,
				cost = 850
			},
			[4] = {
				attack_cooldown = 3,
				note = "+ Whirlpool",
				cost = 4000,
				primary_attack = "tanjiro:whirlpool",
				range = 7,
				damage = 55
			}
		},
		primary_attack_no_upgrades = "tanjiro:wheel",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	ayato = {
		hybrid_placement = true,
		name = "Ayato",
		health = 20,
		id = "ayato",
		speed = 1,
		range = 7,
		animation_set = "fly_ukaku"
	},
	wall_titan_one = {
		hybrid_placement = true,
		speed = 5,
		name = "Wall Titan",
		knockback_points = {},
		id = "wall_titan_one",
		health = 10000,
		range = 100,
		animation_set = "default"
	},
	kaneki = {
		attack_cooldown = 5,
		primary_attack_no_upgrades = "kaneki:stab",
		range = 6,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		passive_accessory_anim = "kaneki_kagune",
		damage = 30,
		upgrade_script = true,
		rarity = "Rare",
		id = "kaneki",
		animation_set = "default",
		hybrid_placement = true,
		ASSETS = {
			effect_models = {
				[1] = "kaneki_stab"
			},
			particles = {
				[1] = "kaneki_jump"
			},
			sfx = {
				[1] = "woosh_medium",
				[2] = "bullet_hit_flesh"
			}
		},
		name = "Kazeki",
		cost = 400,
		upgrade = {
			[1] = {
				attack_cooldown = 5,
				damage = 50,
				range = 6.5,
				cost = 550
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 60,
				range = 7,
				cost = 650
			},
			[3] = {
				attack_cooldown = 4.5,
				damage = 70,
				range = 7.5,
				cost = 800
			},
			[4] = {
				attack_cooldown = 4,
				note = "+ Quad Tentacles",
				cost = 1750,
				primary_attack = "kaneki:jump",
				range = 10,
				damage = 70
			},
			[5] = {
				attack_cooldown = 4,
				damage = 90,
				range = 12,
				cost = 2000
			}
		},
		health = 100,
		cooldown = 10,
		shiny = true
	},
	marine_six = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "flag_bearer:buff_moving",
		id = "marine_six",
		range = 14,
		animation_set = "flag_holder",
		name = "Marine Flagbearer",
		ASSETS = {
			sfx = {
				[1] = "power_up"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 15
	},
	jiren_boss = {
		attack_cooldown = 1.23,
		transform = {
			health_ratio = 0.5,
			effects = {
				1 = {
					id = "jiren_boss_evolve",
					modifiers = {
						stage = "begin"
					}
				}
			},
			unit = "jiren_boss_evolved"
		},
		id = "jiren_boss",
		range = 7,
		animation_set = "default",
		health = 20,
		name = "Jirun",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		ASSETS = {
			vfx = {
				[1] = "jiren_evolve_beams"
			}
		},
		hybrid_placement = true,
		damage = 5
	},
	ace = {
		attack_cooldown = 7,
		cost = 1200,
		hill_unit = true,
		limited = {},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 55,
		rarity = "Secret",
		id = "ace",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "ace"
			},
			sfx = {
				[1] = "charge_echo",
				[2] = "ace_fire_woosh",
				[3] = "fire_move",
				[4] = "fire_explosion_5",
				[5] = "fire_cast",
				[6] = "fire_explosion_6"
			}
		},
		animation_set = "default",
		health = 100,
		upgrade = {
			[1] = {
				attack_cooldown = 6.5,
				damage = 100,
				range = 16,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 150,
				range = 17,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 6,
				note = "+ Fire Pillar",
				primary_attack = "ace:pillar",
				cost = 2750,
				range = 18,
				damage = 195
			},
			[4] = {
				attack_cooldown = 6,
				damage = 225,
				range = 22,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 5.5,
				damage = 300,
				range = 23,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 400,
				range = 23.5,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 5,
				note = "+ Enkai!",
				primary_attack = "ace:enkai",
				cost = 9000,
				range = 24,
				damage = 500
			},
			[8] = {
				attack_cooldown = 5,
				damage = 600,
				range = 25,
				cost = 11000
			}
		},
		name = "Fire Fist",
		range = 15,
		primary_attack_no_upgrades = "ace:fireflies",
		blessing = {
			normal = "ace",
			shiny = "ace_shiny"
		},
		cooldown = 10,
		shiny = true
	},
	obito = {
		hybrid_placement = true,
		cost = 1000,
		id = "obito",
		approach_distance = 1.75,
		range = 20,
		animation_set = "naruto",
		attacks = {
			melee_basic_1:1 = {
				damage = 35,
				cooldown = 1.23,
				weight = 1
			}
		},
		knockback_points = {
			[1] = 0.5
		},
		name = "Oboti",
		xp_reward = {
			min = 50,
			max = 100
		},
		speed = 1,
		health = 1000,
		cooldown = 10,
		gold_kill_reward = {
			min = 5,
			max = 10
		}
	},
	ichigo_hollow = {
		attack_cooldown = 6,
		cost = 850,
		limited = {},
		moving_gui_offset = CFrame.new(-1.04216071e-14, -0.734000027, -1.5, -0.939692676, 0, -0.342020005, 0, 1, 0, 0.342020005, 0, -0.939692676),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 50,
		rarity = "Secret",
		hybrid_placement = true,
		id = "ichigo_hollow",
		hide_from_banner = true,
		ASSETS = {
			effect_models = {
				[1] = "ichigo_hollow_cero",
				[2] = "ichigo_hollow_cero_fire",
				[3] = "ichigo_hollow_slash"
			},
			particles = {
				[1] = "ichigo_hollow_teleport"
			},
			sfx = {
				[1] = "slash_pulse",
				[2] = "cero_charge",
				[3] = "cero_fire",
				[4] = "teleport"
			}
		},
		animation_set = "vasto_ichigo",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 80,
				range = 20,
				cost = 1200
			},
			[2] = {
				attack_cooldown = 5,
				damage = 100,
				range = 21,
				cost = 1750
			},
			[3] = {
				attack_cooldown = 5,
				note = "+ Red Cero",
				cost = 2250,
				primary_attack = "ichigo_hollow:cero",
				range = 22,
				damage = 150
			},
			[4] = {
				attack_cooldown = 5,
				damage = 200,
				range = 23,
				cost = 2750
			},
			[5] = {
				attack_cooldown = 5,
				damage = 300,
				range = 24,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 5,
				damage = 400,
				range = 25,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 5,
				damage = 600,
				range = 25,
				cost = 8000
			}
		},
		name = "Ichi (Full Hollow)",
		range = 19,
		primary_attack_no_upgrades = "ichigo_hollow:slash",
		blessing = {
			normal = "ichigo_hollow",
			shiny = "ichigo_hollow_shiny"
		},
		cooldown = 10,
		shiny = true
	},
	erwin = {
		attack_cooldown = 15,
		cost = 775,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 10,
		damage = 0,
		rarity = "Legendary",
		id = "erwin",
		ASSETS = {
			vfx = {
				[1] = "flare_gun",
				[2] = "flare",
				[3] = "flare_red"
			},
			particles = {
				[1] = "bakugou_ref"
			},
			sfx = {
				[1] = "flare_gun"
			}
		},
		cooldown = 10,
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 14,
				damage = 0,
				health = 120,
				cost = 1000
			},
			[2] = {
				attack_cooldown = 14,
				damage = 0,
				health = 220,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 13,
				note = "+ Dedicate your hearts!",
				health = 325,
				active_attack = "erwin:buff_units",
				active_attack_stats = {
					attack_cooldown = 40,
					damage = 0
				},
				cost = 2000,
				damage = 0
			},
			[4] = {
				attack_cooldown = 12,
				damage = 0,
				health = 525,
				cost = 4000
			},
			[5] = {
				attack_cooldown = 11,
				damage = 0,
				health = 750,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 10,
				damage = 0,
				health = 1100,
				cost = 7000
			}
		},
		health = 50,
		name = "Orwin",
		primary_attack_no_upgrades = "erwin:spawn_unit",
		spawn_unit = true,
		spawn_cap = 3,
		hybrid_placement = true,
		shiny = true
	},
	luffy = {
		attack_cooldown = 4,
		cost = 300,
		range = 6,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 20,
		rarity = "Rare",
		id = "luffy",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			sfx = {
				[1] = "critical_punch",
				[2] = "luffy_gun"
			},
			effect_models = {
				[1] = "luffy_gun"
			}
		},
		health = 100,
		name = "Luffo",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 40,
				range = 6.5,
				cost = 400
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 55,
				range = 7,
				cost = 500
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 65,
				range = 7.5,
				cost = 650
			},
			[4] = {
				attack_cooldown = 3,
				note = "+ Rubber Gun",
				cost = 1250,
				primary_attack = "luffy2:gun",
				range = 14,
				damage = 70
			},
			[5] = {
				attack_cooldown = 3,
				damage = 110,
				range = 15,
				cost = 2000
			}
		},
		primary_attack_no_upgrades = "luffy:punches",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	alien_soldier_yellow_shooter = {
		attack_cooldown = 5,
		id = "alien_soldier_yellow_shooter",
		range = 20,
		animation_set = "armcannon",
		max_spawn_units = 5,
		name = "Alien Captain",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 40,
		hybrid_placement = true,
		damage = 0
	},
	marine_three = {
		hybrid_placement = true,
		name = "Marine Officer",
		health = 20,
		id = "marine_three",
		speed = 1,
		range = 7,
		animation_set = "sword:1h"
	},
	female_titan = {
		attack_cooldown = 30,
		primary_attack_no_upgrades = "female_titan:invincibility_activate",
		id = "female_titan",
		spawn_anim = "titan",
		range = 7,
		animation_set = "default",
		ASSETS = {
			sfx = {
				[1] = "steam_hiss",
				[2] = "titan_roar_female",
				[3] = "glass_crunch",
				[4] = "steam_hiss"
			}
		},
		knockback_points = {
			[1] = 0.5
		},
		name = "Female Titan",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_smoke"
			},
			[2] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx_params = {
						tween_out_time = 0.5
					},
					sfx = "titan_roar_female"
				}
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 0
	},
	netero_evolved = {
		attack_cooldown = 8,
		cost = 1400,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			use_own_model = true,
			from = "netero"
		},
		damage = 135,
		rarity = "Mythic",
		id = "netero_evolved",
		hybrid_placement = true,
		animation_set = "netero",
		ASSETS = {
			_new_fx = {
				[1] = "netero"
			},
			sfx = {
				[1] = "netero_summon",
				[2] = "physical_explosion_slam",
				[3] = "physical_explosion_laser",
				[4] = "netero_charge",
				[5] = "beam_pulse_fire",
				[6] = "netero_beam",
				[7] = "netero_beam2"
			}
		},
		health = 100,
		name = "Chairman Neteru",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 270,
				range = 23,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7,
				damage = 405,
				range = 23.5,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 7,
				damage = 675,
				range = 24,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 11,
				note = "+ 99th Hand",
				primary_attack = "netero:99th_hand",
				cost = 5000,
				range = 25,
				damage = 2025.0000000000002
			},
			[5] = {
				attack_cooldown = 11,
				damage = 2700,
				range = 27,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 11,
				damage = 3712.5000000000005,
				range = 28,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 11,
				damage = 4050.0000000000005,
				range = 30,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 10,
				note = "+ Zero Hand",
				cost = 12500,
				primary_attack = "netero:zero_hand",
				range = 33,
				damage = 4590
			},
			[9] = {
				attack_cooldown = 10,
				damage = 5130,
				range = 35,
				cost = 15000
			}
		},
		primary_attack_no_upgrades = "netero:third_hand",
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	juuzou_evolved = {
		attack_cooldown = 7,
		primary_attack_no_upgrades = "juuzou:spin",
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "juuzou"
		},
		damage = 48.75,
		upgrade_script = true,
		rarity = "Mythic",
		id = "juuzou_evolved",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "juuzou"
			},
			sfx = {
				[1] = "spin_slow",
				[2] = "spin_metal",
				[3] = "explosion_fast"
			}
		},
		animation_set = "juuzou",
		shared_setup_script = "juuzou_evolved",
		spawn_cap = 4,
		name = "Juozu (Joker)",
		upgrade = {
			[1] = {
				attack_cooldown = 6.5,
				damage = 97.5,
				range = 15.5,
				cost = 1750
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 195,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6,
				damage = 243.75,
				range = 16.5,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 6,
				damage = 341.25,
				range = 20,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 7.5,
				note = "+ Manic Frenzy",
				cost = 6500,
				primary_attack = "juuzou:line",
				range = 25,
				damage = 487.5
			},
			[6] = {
				attack_cooldown = 7.5,
				damage = 633.75,
				range = 26,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 7,
				damage = 780,
				range = 27,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 5,
				note = "+ Joker Arata",
				cost = 10000,
				range = 30,
				damage = 975
			},
			[9] = {
				attack_cooldown = 5,
				damage = 1462.5,
				range = 30,
				cost = 15000
			}
		},
		health = 100,
		cost = 1250,
		cooldown = 10,
		shiny = true
	},
	rengoku_evolved = {
		attack_cooldown = 6,
		cost = 1250,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			use_own_model = true,
			from = "rengoku"
		},
		damage = 62.5,
		rarity = "Mythic",
		id = "rengoku_evolved",
		hide_from_banner = true,
		hybrid_placement = true,
		animation_set = "sword:1h_long",
		ASSETS = {
			_new_fx = {
				[1] = "rengoku_evolved"
			},
			sfx = {
				[1] = "SwordRing",
				[2] = "fire_explosion_1",
				[3] = "strong_sword_slash2",
				[4] = "fire_explosion_4",
				[5] = "spin_slow",
				[6] = "fire_cast",
				[7] = "ace_fire_woosh",
				[8] = "fire_move",
				[9] = "fire_release",
				[10] = "fire_roar",
				[11] = "fire_slash"
			}
		},
		shiny = true,
		name = "Renkoko (ABLAZE)",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 125,
				range = 18,
				cost = 1750
			},
			[2] = {
				attack_cooldown = 7.5,
				note = "+ Blazing Universe",
				cost = 2500,
				primary_attack = "rengoku_evolved:universe",
				range = 23,
				damage = 250
			},
			[3] = {
				attack_cooldown = 7,
				damage = 312.5,
				range = 23.5,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 7,
				damage = 437.5,
				range = 24,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 6.5,
				note = "+ Unknowing Fire",
				cost = 6500,
				primary_attack = "rengoku_evolved:unknowing",
				range = 25,
				damage = 562.5
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 750,
				range = 26,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 6,
				damage = 875,
				range = 27,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 6,
				note = "+ Ninth Form: Renkoko!",
				cost = 10000,
				primary_attack = "rengoku_evolved:dragon",
				range = 28,
				damage = 1062.5
			},
			[9] = {
				attack_cooldown = 6,
				damage = 1562.5,
				range = 30,
				cost = 15000
			}
		},
		primary_attack_no_upgrades = "rengoku_evolved:undulation",
		spawn_cap = 4,
		cooldown = 10,
		health = 5000
	},
	zenitsu = {
		attack_cooldown = 3,
		cost = 525,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 15,
		rarity = "Epic",
		id = "zenitsu",
		hybrid_placement = true,
		animation_set = "sword:1h",
		ASSETS = {
			sfx = {
				[1] = "electric_sparks",
				[2] = "Lightning_Release",
				[3] = "Lightning_Release_3",
				[4] = "zap1",
				[5] = "Slash_AF"
			},
			effect_models = {
				[1] = "zenitsu_lightning",
				[2] = "zenitsu_lightning_2",
				[3] = "zenitsu_lightning_2_main"
			}
		},
		health = 2000,
		name = "Zennu",
		upgrade = {
			[1] = {
				attack_cooldown = 3,
				damage = 25,
				range = 16,
				cost = 400
			},
			[2] = {
				attack_cooldown = 2.5,
				damage = 30,
				range = 17,
				cost = 500
			},
			[3] = {
				attack_cooldown = 2.5,
				damage = 40,
				range = 18,
				cost = 600
			},
			[4] = {
				attack_cooldown = 6,
				note = "+ Thunderclap and Flash",
				cost = 3000,
				primary_attack = "zenitsu:lightning_2",
				range = 20,
				damage = 55
			},
			[5] = {
				attack_cooldown = 4,
				damage = 75,
				range = 22,
				cost = 5000
			}
		},
		primary_attack_no_upgrades = "zenitsu:lightning",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	frieza = {
		attack_cooldown = 5,
		primary_attack_no_upgrades = "frieza:death_beam",
		hill_unit = true,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 9,
		upgrade_script = true,
		rarity = "Epic",
		hybrid_placement = true,
		id = "frieza",
		call_upgrade_script_on_pet = true,
		ASSETS = {
			vfx = {
				[1] = "frieza_lazer",
				[2] = "frieza_death_beam"
			},
			effect_models = {
				[1] = "frieza_ball"
			},
			particles = {
				[1] = "frieza_lazer"
			},
			sfx = {
				[1] = "charge_echo_long",
				[2] = "Thunder_release",
				[3] = "dbz_charge_one",
				[4] = "dbz_release_woop",
				[5] = "physical_explosion"
			}
		},
		animation_set = "fly_1",
		spawn_cap = 5,
		upgrade = {
			[1] = {
				attack_cooldown = 4.5,
				damage = 20,
				range = 16,
				cost = 1000
			},
			[2] = {
				attack_cooldown = 4,
				damage = 35,
				range = 17,
				cost = 1550
			},
			[3] = {
				attack_cooldown = 4,
				damage = 50,
				range = 18,
				cost = 1750
			},
			[4] = {
				attack_cooldown = 8,
				note = "+ Death Ball",
				cost = 3250,
				primary_attack = "frieza:ball",
				range = 20,
				damage = 100
			},
			[5] = {
				attack_cooldown = 7,
				damage = 125,
				range = 22,
				cost = 2000
			}
		},
		name = "Freezo (Final)",
		health = 100,
		cost = 525,
		shiny_animation_sets = {
			pet = "frieza_pod",
			spawned = "frieza_pod"
		},
		cooldown = 10,
		shiny = true
	},
	akaza_unit_evolved = {
		attack_cooldown = 7.5,
		cost = 1100,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			use_own_model = true,
			from = "akaza_unit"
		},
		damage = 120,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "akaza_unit_evolved",
		hide_from_banner = true,
		ASSETS = {
			_new_fx = {
				[1] = "akaza_unit"
			},
			effect_models = {
				[1] = "akaza_compass"
			},
			particles = {
				[1] = "akaza_buffed"
			},
			sfx = {
				[1] = "punch_heavy_1",
				[2] = "dbz_release_woop",
				[3] = "physical_explosion_quick",
				[4] = "physical_explosion_with_debris",
				[5] = "Heavy_Charge",
				[6] = "punch_barrage",
				[7] = "futuristic_charge_fast",
				[8] = "power_up",
				[9] = "RocksDebris2"
			}
		},
		animation_set = "akaza",
		shiny = true,
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 160,
				range = 15.5,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 7,
				damage = 200,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Annihilation Type",
				cost = 3000,
				primary_attack = "akaza_unit:annihilation",
				range = 16.5,
				damage = 300
			},
			[4] = {
				attack_cooldown = 6.5,
				damage = 500,
				range = 17,
				cost = 4250
			},
			[5] = {
				attack_cooldown = 6.5,
				note = "+ Ten Thousand Leaves",
				cost = 5500,
				primary_attack = "akaza_unit:leaves",
				range = 18,
				damage = 600
			},
			[6] = {
				attack_cooldown = 6,
				damage = 700,
				range = 18.5,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 6,
				damage = 1100,
				range = 19,
				cost = 8500
			},
			[8] = {
				attack_cooldown = 6,
				note = "+ Disorder",
				cost = 12500,
				primary_attack = "akaza_unit:disorder",
				range = 20,
				damage = 1500
			}
		},
		name = "Akoku (Destruction)",
		primary_attack_no_upgrades = "akaza_unit:air_type",
		health = 5000,
		spawn_cap = 5,
		cooldown = 10,
		secondary_attacks = {
			[1] = {
				id = "akaza_unit:compass"
			}
		}
	},
	goku_black = {
		attack_cooldown = 6,
		cost = 850,
		hill_unit = true,
		range = 19,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 17,
		rarity = "Legendary",
		id = "goku_black",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "goku_black_rift",
				[2] = "goku_black_scythe",
				[3] = "goku_black_slicer"
			},
			effect_models = {
				[1] = "goku_black_scythe"
			},
			sfx = {
				[1] = "divine_lasso",
				[2] = "divine_scythe_pull",
				[3] = "divine_scythe_cut",
				[4] = "divine_scythe_rift",
				[5] = "electricity_aura_short",
				[6] = "zap1",
				[7] = "ki_explosion"
			},
			particles = {
				[1] = "explosion_goku_black_slice",
				[2] = "goku_black_slicer_fire"
			},
			projectiles = {
				[1] = "goku_black_slicer_projectile"
			}
		},
		spawn_cap = 5,
		name = "Goko Black",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 40,
				range = 20,
				cost = 1200
			},
			[2] = {
				attack_cooldown = 5,
				damage = 55,
				range = 21,
				cost = 1750
			},
			[3] = {
				attack_cooldown = 5,
				damage = 80,
				range = 21.5,
				cost = 2250
			},
			[4] = {
				attack_cooldown = 4.5,
				damage = 150,
				range = 22,
				cost = 2750
			},
			[5] = {
				attack_cooldown = 4.5,
				note = "+ Sickle of Sorrow",
				primary_attack = "goku_black:scythe",
				cost = 5000,
				range = 25,
				damage = 175
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 200,
				range = 27,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 4,
				damage = 300,
				range = 30,
				cost = 8000
			}
		},
		health = 100,
		primary_attack_no_upgrades = "goku_black:slicer",
		cooldown = 10,
		shiny = true
	},
	aokiji = {
		attack_cooldown = 20,
		primary_attack_no_upgrades = "aokiji:freeze",
		id = "aokiji",
		range = 15,
		animation_set = "default",
		name = "Aojimi",
		ASSETS = {
			sfx = {
				[1] = "ice_blast2"
			},
			effect_models = {
				[1] = "aokiji_freeze"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	orochimaru = {
		hybrid_placement = true,
		health = 20,
		name = "Orochomaro",
		ASSETS = {},
		id = "orochimaru",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	naruto_minion_3 = {
		hybrid_placement = true,
		name = "Black Ops Traitor",
		health = 20,
		id = "naruto_minion_3",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	levi_evolved = {
		attack_cooldown = 7,
		cost = 1500,
		hill_unit = true,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "levi"
		},
		damage = 97.5,
		rarity = "Mythic",
		id = "levi_evolved",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "levi"
			},
			sfx = {
				[1] = "3dmg_shoot",
				[2] = "3dmg_retract",
				[3] = "3dmg_boost1",
				[4] = "3dmg_boost2",
				[5] = "spin_slow",
				[6] = "spin_fast",
				[7] = "slash_high"
			}
		},
		animation_set = "3dmg",
		health = 5000,
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 195,
				range = 15.5,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 390,
				range = 16,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 6,
				damage = 585,
				range = 16.5,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 650,
				range = 17,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 6,
				note = "+ Humanity's Strongest Soldier",
				primary_attack = "levi:slashes_2",
				cost = 5500,
				range = 21,
				damage = 845
			},
			[6] = {
				attack_cooldown = 6,
				damage = 975,
				range = 22,
				cost = 6000
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 1105,
				range = 23,
				cost = 7000
			},
			[8] = {
				attack_cooldown = 5,
				damage = 1300,
				range = 24,
				cost = 8000
			},
			[9] = {
				attack_cooldown = 5,
				damage = 1625,
				range = 25,
				cost = 10000
			}
		},
		name = "Levy Ackman",
		primary_attack_no_upgrades = "levi:slashes_1",
		spawn_cap = 6,
		crit_chance = 0.25,
		cooldown = 10,
		shiny = true
	},
	ccg_armored_normal = {
		shield = 5,
		range = 7,
		animation_set = "default",
		name = "Arata Unit",
		health = 20,
		speed = 1,
		id = "ccg_armored_normal",
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.4,
			buffs = {
				[1] = {
					params = {
						reduction = 0.2,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	cell = {
		attack_cooldown = 6,
		primary_attack_no_upgrades = "zarbon:blast",
		id = "cell",
		range = 20,
		animation_set = "fly_1",
		health = 1000,
		knockback_points = {
			[1] = 0.5
		},
		name = "Cell",
		xp_reward = {
			min = 50,
			max = 100
		},
		speed = 1,
		gold_kill_reward = {
			min = 5,
			max = 10
		},
		hybrid_placement = true,
		damage = 35
	},
	bakugou = {
		attack_cooldown = 6,
		cost = 400,
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 4.5,
		rarity = "Rare",
		id = "bakugou",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			effect_models = {
				[1] = "apshot",
				[2] = "apshot_b"
			},
			particles = {
				[1] = "bakugou_ground_explosion",
				[2] = "bakugou_ref"
			},
			sfx = {
				[1] = "futuristic_blast",
				[2] = "charge_echo",
				[3] = "physical_explosion_quick",
				[4] = "physical_explosion_squeeze",
				[5] = "woosh_medium"
			}
		},
		shiny = true,
		name = "Bakujo",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 12,
				range = 20,
				cost = 600
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 15,
				range = 22,
				cost = 750
			},
			[3] = {
				attack_cooldown = 5.5,
				damage = 20,
				range = 22,
				cost = 1250
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Blast Rush",
				cost = 2000,
				primary_attack = "bakugou:explosions_new",
				range = 23,
				damage = 22
			},
			[5] = {
				attack_cooldown = 5,
				damage = 35,
				range = 23,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "apshot",
		spawn_cap = 5,
		cooldown = 10,
		health = 2000
	},
	pitou_evolved = {
		attack_cooldown = 7,
		cost = 1350,
		range = 12,
		moving_gui_offset = CFrame.new(7.80220999e-10, -0.100000024, -1.39999998, -0.999390841, -0.0348995142, -8.6392042e-08, -0.0347666927, 0.995588243, -0.0871557444, 0.00304177962, -0.0871026739, -0.99619472),
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		passive_accessory_anim = "pitou_tail",
		damage = 180,
		hybrid_placement = true,
		rarity = "Mythic",
		ASSETS = {
			_new_fx = {
				[1] = "pitou"
			},
			sfx = {
				[1] = "slash_pitou",
				[2] = "slash_pitou_2",
				[3] = "slash_pitou_quick",
				[4] = "slash_pitou_gore",
				[5] = "summon_terpischora",
				[6] = "woosh_long"
			}
		},
		id = "pitou_evolved",
		health = 100,
		live_model_offset = CFrame.new(0, 0.25, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		animation_set = "pitou",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 300,
				range = 13,
				cost = 1400
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 480,
				range = 15,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 720,
				range = 16,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				note = "+ Lethal Ambush",
				primary_attack = "pitou:jump_slash",
				cost = 4500,
				range = 18,
				damage = 840
			},
			[5] = {
				attack_cooldown = 6,
				damage = 1080,
				range = 19,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 1560,
				range = 20,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 1800,
				range = 25,
				cost = 8500
			},
			[8] = {
				attack_cooldown = 5.5,
				note = "+ Terpsichora Rush",
				cost = 10000,
				primary_attack = "pitou:terpischora_rush",
				range = 27,
				damage = 1920
			},
			[9] = {
				attack_cooldown = 5,
				damage = 2160,
				range = 30,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "pitou:dash_slash",
		name = "Pito (Terpsichora)",
		spawn_cap = 4,
		evolved = {
			use_own_model = true,
			from = "pitou"
		},
		crit_chance = 0.25,
		cooldown = 10,
		shiny = true
	},
	jeice = {
		id = "jeice",
		range = 20,
		animation_set = "default",
		hybrid_placement = true,
		boss = true,
		name = "Jayce",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		ASSETS = {
			vfx = {
				[1] = "frieza_spawn_lazer"
			},
			sfx = {
				[1] = "teleport_dbz",
				[2] = "stomp"
			}
		},
		spawn_attack = "ginyu_force:spawn",
		health = 30000
	},
	nezuko = {
		attack_cooldown = 5,
		cost = 400,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 15,
		upgrade_script = true,
		rarity = "Rare",
		id = "nezuko",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "nezuko_slashes_2"
			},
			effect_models = {
				[1] = "nezuko_slashes",
				[2] = "nezuko_slashes_2"
			},
			particles = {
				[1] = "nezuko_arm_blood"
			},
			sfx = {
				[1] = "ki_explosion"
			}
		},
		health = 2000,
		name = "Nezuka",
		upgrade = {
			[1] = {
				attack_cooldown = 4.5,
				damage = 25,
				range = 13,
				cost = 550
			},
			[2] = {
				attack_cooldown = 4,
				damage = 30,
				range = 13,
				cost = 700
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 35,
				range = 14,
				cost = 850
			},
			[4] = {
				attack_cooldown = 6,
				note = "+ Demon Form",
				cost = 1500,
				primary_attack = "nezuko:demon_slashes",
				range = 15,
				damage = 35
			},
			[5] = {
				attack_cooldown = 5.5,
				damage = 50,
				range = 15,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "nezuko:slashes",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	clown = {
		hybrid_placement = true,
		name = "Rogue Clown",
		health = 20,
		id = "clown",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	rin_oku = {
		attack_cooldown = 8,
		cost = 1400,
		range = 17,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		special_note = "[Limited] - Obtained by achieving a top 25 infinite run in Update 1-2",
		special_note_shiny = "[Limited] - Obtained by achieving a top 10 infinite run in Update 1-2",
		hybrid_placement = true,
		rarity = "Mythic",
		ASSETS = {
			_new_fx = {
				[1] = "rin_oku"
			},
			sfx = {
				[1] = "rin_swing",
				[2] = "rin_fire_swoosh",
				[3] = "rin_fireball_throw",
				[4] = "fire_explosion_3",
				[5] = "rin_flames",
				[6] = "rin_flames2"
			}
		},
		id = "rin_oku",
		hide_from_banner = true,
		shiny = true,
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 200,
				range = 17.5,
				cost = 2100
			},
			[2] = {
				attack_cooldown = 8,
				damage = 325,
				range = 18,
				cost = 2800
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Fireburst Samadhi",
				primary_attack = "rin:skill_two",
				cost = 3500,
				range = 18.5,
				damage = 450
			},
			[4] = {
				attack_cooldown = 7,
				damage = 550,
				range = 19,
				cost = 4000
			},
			[5] = {
				attack_cooldown = 7,
				damage = 700,
				range = 19.5,
				cost = 5250
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 775,
				range = 20,
				cost = 6000
			},
			[7] = {
				attack_cooldown = 6.5,
				note = "+ Azure Campfire",
				primary_attack = "rin:skill_three",
				cost = 8500,
				range = 20,
				damage = 900
			},
			[8] = {
				attack_cooldown = 6.5,
				damage = 1000,
				range = 20.5,
				cost = 11000
			}
		},
		spawn_cap = 5,
		name = "Blue Devil",
		damage = 90,
		primary_attack_no_upgrades = "rin:skill_one",
		blessing = {
			normal = "rin_oku",
			shiny = "rin_oku_shiny"
		},
		cooldown = 10,
		health = 2000
	},
	enmu = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "enmu:hand",
		id = "enmu",
		range = 20,
		animation_set = "default",
		name = "Ennu",
		ASSETS = {
			particles = {
				[1] = "enmu_hand"
			},
			sfx = {
				[1] = "woosh_throw_heavy"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	kizaru_unit = {
		attack_cooldown = 6,
		cost = 750,
		hill_unit = true,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 25,
		rarity = "Legendary",
		id = "kizaru_unit",
		animation_set = "default",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "kizaru_unit"
			},
			sfx = {
				[1] = "pika_explode",
				[2] = "futuristic_charge_fast",
				[3] = "futuristic_blast2",
				[4] = "pika_shot"
			}
		},
		name = "Kazoru",
		health = 100,
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 50,
				range = 13,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 5,
				damage = 100,
				range = 14,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 5,
				damage = 200,
				range = 15,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 4.5,
				note = "+ Mirror Kick",
				primary_attack = "kizaru:kick",
				cost = 5000,
				range = 20,
				damage = 250
			},
			[5] = {
				attack_cooldown = 4,
				damage = 300,
				range = 25,
				cost = 7500
			}
		},
		primary_attack_no_upgrades = "kizaru_unit:barrage",
		cooldown = 10,
		shiny = true
	},
	kite_evolved_focus = {
		attack_cooldown = 8,
		cost = 4000,
		range = 27.5,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "kite"
		},
		damage = 300,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Secret",
		ASSETS = {
			_new_fx = {
				[1] = "kite"
			},
			sfx = {
				[1] = "ding",
				[2] = "boost_arcade",
				[3] = "SwordRing",
				[4] = "slower_slash",
				[5] = "wind_blow",
				[6] = "machine_gun",
				[7] = "kite_charge",
				[8] = "kite_pulse",
				[9] = "pulse1",
				[10] = "magic_blast"
			}
		},
		id = "kite_evolved_focus",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 720,
				range = 31.25,
				cost = 8000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 1440,
				range = 33.75,
				cost = 12000
			},
			[3] = {
				attack_cooldown = 8,
				damage = 2100,
				range = 36.25,
				cost = 15000
			},
			[4] = {
				attack_cooldown = 8,
				damage = 2700,
				range = 37.5,
				cost = 20000
			}
		},
		animation_set = "default",
		limited = {},
		_OVERRIDE_UNIT_SCRIPT = "script_kite",
		name = "Kit (Focus)",
		spawn_script = true,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	marine_one = {
		hybrid_placement = true,
		name = "Marine Recruit",
		health = 20,
		id = "marine_one",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	ichigo_mask = {
		attack_cooldown = 5,
		cost = 575,
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 5,
		rarity = "Epic",
		id = "ichigo_mask",
		hybrid_placement = true,
		animation_set = "sword:1h",
		ASSETS = {
			sfx = {
				[1] = "heavy_sword_swing",
				[2] = "slow_sword_slash",
				[3] = "Heavy_Charge"
			},
			effect_models = {
				[1] = "ichigo_mask_cross",
				[2] = "ichigo_mask_slash"
			}
		},
		health = 100,
		name = "Ichi (Masked)",
		upgrade = {
			[1] = {
				attack_cooldown = 4.5,
				damage = 8,
				range = 21,
				cost = 750
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 14,
				range = 22,
				cost = 1150
			},
			[3] = {
				attack_cooldown = 4,
				damage = 20,
				range = 23,
				cost = 1450
			},
			[4] = {
				attack_cooldown = 4,
				note = "+ Getsuga Tensho",
				cost = 2500,
				primary_attack = "ichigo_mask:slash",
				range = 25,
				damage = 25
			},
			[5] = {
				attack_cooldown = 3,
				damage = 30,
				range = 30,
				cost = 4000
			}
		},
		primary_attack_no_upgrades = "ichigo_mask:cross",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	netero = {
		attack_cooldown = 8,
		cost = 1400,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 100,
		rarity = "Mythic",
		id = "netero",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "netero"
			},
			sfx = {
				[1] = "netero_summon",
				[2] = "physical_explosion_slam",
				[3] = "physical_explosion_laser",
				[4] = "netero_charge",
				[5] = "beam_pulse_fire",
				[6] = "netero_beam",
				[7] = "netero_beam2"
			}
		},
		animation_set = "netero",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "netero"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "netero_rose",
						amount = 1
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "netero"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "netero_rose",
						amount = 1
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit = "netero_evolved",
			evolve_text = "+35% Damage, +Zero Hand"
		},
		health = 100,
		name = "Neteru",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 200,
				range = 23,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7,
				damage = 300,
				range = 23.5,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 7,
				damage = 500,
				range = 24,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 11,
				note = "+ 99th Hand",
				primary_attack = "netero:99th_hand",
				cost = 5000,
				range = 25,
				damage = 1500
			},
			[5] = {
				attack_cooldown = 11,
				damage = 2000,
				range = 27,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 11,
				damage = 2750,
				range = 28,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 11,
				damage = 3000,
				range = 30,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 10,
				damage = 3400,
				range = 33,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "netero:third_hand",
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	goku_ui = {
		rest_time = 0,
		cost = 1500,
		range = 30,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		dodge_chance = 0.5,
		damage = 50,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Mythic",
		ASSETS = {
			vfx = {
				[1] = "goku_ui_shadow_unrigged",
				[2] = "goku_ui_punch_slash",
				[3] = "goku_ui_rush"
			},
			effect_models = {
				[1] = "KamehamehaUI",
				[2] = "KamehamehaUI_Charge"
			},
			particles = {
				[1] = "goku_ui",
				[2] = "goku_ui_dash",
				[3] = "goku_ui_charge"
			},
			sfx = {
				[1] = "teleport_dbz2",
				[2] = "dbz_punch_barrage",
				[3] = "dbz_strong_punch",
				[4] = "dbz_charge_four",
				[5] = "KamehamehaScream",
				[6] = "Kamehameha2"
			}
		},
		id = "goku_ui",
		hide_from_banner = true,
		spawn_cap = 4,
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 100,
				range = 32,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 150,
				range = 33,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Silver Dragon Flash",
				primary_attack = "goku_ui:rush",
				cost = 3500,
				range = 35,
				damage = 200
			},
			[4] = {
				attack_cooldown = 7,
				damage = 250,
				range = 36,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 6,
				damage = 300,
				range = 38,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 350,
				range = 40,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 10,
				note = "+ Ultimate Kamehameha!",
				primary_attack = "goku_ui:beam",
				cost = 1000,
				dodge_chance = 1,
				range = 50,
				damage = 550
			},
			[8] = {
				attack_cooldown = 8,
				damage = 700,
				range = 50,
				cost = 12500
			}
		},
		attack_cooldown = 8,
		name = "Ultra Goko",
		cellshading_color = Color3.new(0.52549, 0.572549, 1),
		primary_attack_no_upgrades = "goku_ui:teleport_hits",
		health = 100,
		cooldown = 10,
		shiny = true
	},
	yammy = {
		transform = {
			health_ratio = 0.25,
			effects = {
				1 = {
					id = "yammy_transform"
				}
			},
			transform_anim_name = "mystery_update_2",
			unit = "yammy_evolved"
		},
		id = "yammy",
		range = 7,
		animation_set = "default",
		name = "Yammo",
		ASSETS = {
			vfx = {
				1 = "yammy_transform"
			},
			sfx = {
				[1] = "hollow_transform",
				[2] = "electric_explosion"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	ant_crab = {
		id = "ant_crab",
		range = 7,
		animation_set = "default",
		health = 20,
		name = "Mutant Ant",
		speed = 1,
		shield = 5,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.5,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	zetsu = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "zetsu:spawn",
		id = "zetsu",
		range = 7,
		animation_set = "default",
		max_spawn_units = 6,
		name = "Zezsuo",
		ASSETS = {
			vfx = {
				[1] = "zetsu_spawn_ball"
			},
			sfx = {
				[1] = "plant_grow"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	light = {
		attack_cooldown = 5,
		range = 20,
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "death_note_ground",
				[2] = "death_note_ground_2",
				[3] = "ryuk:appear",
				[4] = "ryuk:idle",
				[5] = "death_note_soul_nohuman",
				[6] = "soul_beam"
			},
			effect_models = {
				[1] = "ryuk"
			},
			sfx = {
				[1] = "death_note_kill",
				[2] = "death_note_kill_2",
				[3] = "pencil_write",
				[4] = "death_note_heart_attack",
				[5] = "death_note_vo"
			},
			particles = {
				[1] = "light_soul_particles"
			},
			_new_fx = {
				[1] = "light"
			}
		},
		damage = 100,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 2,
						unit_id = "light"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "death_note",
						amount = 4
					}
				}
			},
			evolve_unit = "light_eyes",
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 2,
						unit_id = "light"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "death_note",
						amount = 4
					}
				}
			}
		},
		shiny = true,
		rarity = "Mythic",
		cost = 10000,
		id = "light",
		hide_from_banner = true,
		stand_offset = CFrame.new(0.848754823, 0, -1.51782215, 0.99999994, 0, 0, 0, 1, 0, 0, 0, 0.99999994),
		animation_set = "default",
		show_stand = true,
		stand = "ryuk",
		name = "Kiru",
		active_attack_stats = {
			attack_cooldown = 15,
			damage = 15
		},
		active_attack = "death_note_active",
		spawn_cap = 1,
		cooldown = 10,
		health = 5000
	},
	amon_boss = {
		hybrid_placement = true,
		name = "Hammer",
		health = 20,
		id = "amon_boss",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	demon1 = {
		hybrid_placement = true,
		name = "Demon",
		health = 20,
		id = "demon1",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	muzan = {
		attack_cooldown = 20,
		primary_attack_no_upgrades = "muzan:spawn_units",
		id = "muzan",
		range = 100,
		animation_set = "default",
		max_spawn_units = 6,
		health = 5000,
		name = "Muzo",
		spawn_effects = {
			[1] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx = "muzan_laugh"
				}
			}
		},
		speed = 15,
		ASSETS = {
			vfx = {
				[1] = "muzan_beam",
				[2] = "demon_spawn_outline",
				[3] = "demon_spawn_outline_nohuman"
			},
			particles = {
				[1] = "muzan_heal_particles",
				[2] = "muzan_spawn_particles",
				[3] = "hantengu_clone_spawn"
			},
			sfx = {
				[1] = "gore_explode2",
				[2] = "gore_explode3",
				[3] = "muzan_suck",
				[4] = "muzan_heal",
				[5] = "muzan_laugh"
			}
		},
		hybrid_placement = true,
		secondary_attacks = {
			[1] = {
				id = "muzan:heal"
			}
		}
	},
	aot_human_1 = {
		hybrid_placement = true,
		passive_accessory_anim = "rifle",
		name = "Paradis Traitor",
		health = 10000,
		id = "aot_human_1",
		speed = 5,
		range = 100,
		animation_set = "default"
	},
	zarbon = {
		transform = {
			health_ratio = 0.5,
			effects = {
				1 = {
					id = "zarbon_transform"
				}
			},
			unit = "zarbon_evolved"
		},
		id = "zarbon",
		range = 0,
		animation_set = "fly_1",
		boss = true,
		name = "Zarbo",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		ASSETS = {
			particles = {
				[1] = "zarbon_evolved_attack",
				[2] = "zarbon_evolved_transform",
				[3] = "zarbon_transform"
			},
			sfx = {
				[1] = "electricity_aura_short",
				[2] = "electric_explosion"
			}
		},
		hybrid_placement = true,
		health = 350
	},
	rengoku = {
		attack_cooldown = 8,
		cost = 1250,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 50,
		rarity = "Mythic",
		id = "rengoku",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "rengoku_tiger",
				[2] = "rengoku_dragon",
				[3] = "rengoku_charge",
				[4] = "rengoku_charge_small",
				[5] = "flamewheel"
			},
			sfx = {
				[1] = "SwordRing",
				[2] = "fire_explosion_1",
				[3] = "strong_sword_slash2",
				[4] = "fire_explosion_4",
				[5] = "spin_slow"
			}
		},
		animation_set = "sword:1h_long",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "rengoku"
					},
					[2] = {
						amount = 4,
						unit_id = "akaza_unit"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "rengoku_donut",
						amount = 3
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "rengoku"
					},
					[2] = {
						shiny = true,
						amount = 4,
						unit_id = "akaza_unit"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "rengoku_donut",
						amount = 3
					}
				}
			},
			evolve_unit = "rengoku_evolved",
			evolve_text = "+Renkoko (ABLAZE)"
		},
		shiny = true,
		name = "Renkoko",
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 100,
				range = 15.5,
				cost = 1750
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 200,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 7,
				damage = 250,
				range = 16.5,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Flame Breathing Ninth Form!",
				cost = 5000,
				primary_attack = "rengoku:dragon",
				range = 20,
				damage = 350
			},
			[5] = {
				attack_cooldown = 6.5,
				damage = 450,
				range = 21,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 600,
				range = 22,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 6,
				damage = 700,
				range = 23,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 6,
				damage = 850,
				range = 24,
				cost = 10000
			}
		},
		primary_attack_no_upgrades = "rengoku:tiger",
		spawn_cap = 4,
		cooldown = 10,
		health = 5000
	},
	alien_soldier_pink = {
		attack_cooldown = 2.23,
		id = "alien_soldier_pink",
		range = 7,
		animation_set = "default",
		name = "Alien Elite",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 100,
		hybrid_placement = true,
		damage = 5
	},
	sengoku = {
		transform = {
			health_ratio = 0.5,
			effects = {
				1 = {
					id = "sengoku_transform",
					modifiers = {
						stage = "charge"
					}
				},
				2 = {
					id = "sengoku_transform",
					modifiers = {
						stage = "fire"
					}
				}
			},
			unit = "sengoku_buddha"
		},
		id = "sengoku",
		range = 7,
		animation_set = "default",
		name = "Senbodu",
		ASSETS = {
			sfx = {
				[1] = "one_piece_boing",
				[2] = "sengoku_grow",
				[3] = "one_piece_alert"
			},
			effect_models = {
				[1] = "sengoku_transform"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	killua = {
		attack_cooldown = 4,
		cost = 525,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 8,
		rarity = "Epic",
		id = "killua",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "godspeed_wave"
			},
			effect_models = {
				[1] = "killua_godspeed",
				[2] = "killua_thunderbolt"
			},
			particles = {
				[1] = "killua_gspeed",
				[2] = "Killua_Lightning_Aura",
				[3] = "Killua_Torso_Particles"
			},
			sfx = {
				[1] = "Lightning_Release",
				[2] = "electric_explosion",
				[3] = "Thunder_explosion",
				[4] = "zap2",
				[5] = "zap1"
			}
		},
		shiny = true,
		name = "Kizzua",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 15,
				range = 11,
				cost = 750
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 25,
				range = 12,
				cost = 1100
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 40,
				range = 13,
				cost = 1450
			},
			[4] = {
				attack_cooldown = 3,
				damage = 50,
				range = 14,
				cost = 1750
			},
			[5] = {
				attack_cooldown = 5,
				note = "+ Godspeed",
				cost = 2500,
				primary_attack = "killua:godspeed",
				range = 20,
				damage = 70
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 85,
				range = 25,
				cost = 3500
			}
		},
		primary_attack_no_upgrades = "killua:thunderbolt",
		spawn_cap = 5,
		cooldown = 10,
		health = 100
	},
	armored_titan = {
		attack_cooldown = 10,
		cost = 1,
		shield = 20,
		range = 10,
		spawn_anim = "titan",
		knockback_points = {
			[1] = 0.5
		},
		speed = 7,
		damage = 15,
		id = "armored_titan",
		animation_set = "armored_titan",
		hybrid_placement = true,
		ASSETS = {
			particles = {
				[1] = "armored_titan_charge"
			},
			sfx = {
				[1] = "steam_hiss",
				[2] = "titan_roar_armored"
			}
		},
		name = "Armored Titan",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_smoke"
			},
			[2] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx_params = {
						tween_out_time = 0.5
					},
					sfx = "titan_roar_armored"
				}
			}
		},
		barrier_destroy_script = true,
		health = 100,
		cooldown = 10,
		barrier = {
			health_ratio = 2,
			buffs = {
				[1] = {
					params = {
						reduction = 0.5,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	todoroki = {
		attack_cooldown = 5,
		cost = 500,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 10,
		rarity = "Epic",
		id = "todoroki",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			effect_models = {
				[1] = "todoroki_ice",
				[2] = "todoroki_fire"
			},
			particles = {
				[1] = "todoroki_charge"
			},
			sfx = {
				[1] = "ice_blast",
				[2] = "fire_explosion_1"
			}
		},
		health = 100,
		name = "Todorro",
		upgrade = {
			[1] = {
				attack_cooldown = 5,
				damage = 24,
				range = 10,
				cost = 750
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 37,
				range = 11,
				cost = 1250
			},
			[3] = {
				attack_cooldown = 4.5,
				damage = 55,
				range = 12,
				cost = 1750
			},
			[4] = {
				attack_cooldown = 4,
				damage = 75,
				range = 12,
				cost = 2250
			},
			[5] = {
				attack_cooldown = 4,
				note = "+ Fire and Ice",
				cost = 3500,
				primary_attack = "todoroki:ice_fire",
				range = 13,
				damage = 100
			}
		},
		primary_attack_no_upgrades = "todoroki:ice",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	whitebeard_evolved = {
		attack_cooldown = 8,
		cost = 1750,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "whitebeard"
		},
		damage = 195,
		rarity = "Mythic",
		id = "whitebeard_evolved",
		hybrid_placement = true,
		animation_set = "whitebeard",
		ASSETS = {
			vfx = {
				[1] = "whitebeard_slash_orb",
				[2] = "gura_Shockwave",
				[3] = "whitebeard_waves_orb",
				[4] = "whitebeard_ocean_wave"
			},
			effect_models = {
				[1] = "whitebeard_earthquake",
				[2] = "whitebeard_slash",
				[3] = "whitebeard_waves"
			},
			sfx = {
				[1] = "gura_charge",
				[2] = "gura_charge2",
				[3] = "gura_release",
				[4] = "gura_release2",
				[5] = "Heavy_Charge",
				[6] = "earthquake",
				[7] = "gura_wave",
				[8] = "tsunami"
			}
		},
		health = 100,
		name = "Emperor Whitehair",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 390,
				range = 13,
				cost = 2500
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 585,
				range = 15,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 7,
				damage = 715,
				range = 16,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 7,
				damage = 975,
				range = 17,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 11,
				note = "+ Earthquake",
				primary_attack = "whitebeard:earthquake",
				cost = 6500,
				range = 20,
				damage = 1105
			},
			[6] = {
				attack_cooldown = 11,
				damage = 1430,
				range = 22,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 11,
				damage = 1690,
				range = 23,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 10.5,
				note = "+ Sea Quake",
				cost = 12500,
				active_attack_stats = {
					attack_cooldown = 60
				},
				active_attack = "whitebeard:waves",
				range = 24,
				damage = 1820
			},
			[9] = {
				attack_cooldown = 10,
				damage = 2210,
				range = 25,
				cost = 17500
			}
		},
		primary_attack_no_upgrades = "whitebeard:slash",
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	vegeta = {
		attack_cooldown = 5,
		cost = 400,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 6,
		rarity = "Rare",
		id = "vegeta",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			sfx = {
				[1] = "futuristic_blast",
				[2] = "ki_explosion",
				[3] = "dbz_charge_one",
				[4] = "dbz_beam_fire"
			},
			effect_models = {
				[1] = "galick_gun",
				[2] = "galick_gun_charge"
			},
			particles = {
				[1] = "vegeta_gun"
			},
			projectiles = {
				[1] = "vegeta_gun_orb"
			}
		},
		health = 100,
		name = "Vegita",
		upgrade = {
			[1] = {
				attack_cooldown = 5,
				damage = 12,
				range = 11,
				cost = 550
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 18,
				range = 11,
				cost = 650
			},
			[3] = {
				attack_cooldown = 4.5,
				damage = 24,
				range = 12,
				cost = 750
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Galick Gun",
				cost = 1500,
				primary_attack = "vegeta:galick_gun",
				range = 12,
				damage = 28
			},
			[5] = {
				attack_cooldown = 6,
				damage = 50,
				range = 12,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "vegeta:gun",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	goku = {
		attack_cooldown = 4,
		cost = 300,
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 6,
		upgrade_script = "upgrade_goku",
		rarity = "Rare",
		id = "goku",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "goku_lazer",
				[2] = "goku_beam",
				[3] = "goku_beam_kaio"
			},
			particles = {
				[1] = "goku_lazer",
				[2] = "goku_beam",
				[3] = "goku_beam_kaio"
			},
			sfx = {
				[1] = "futuristic_blast",
				[2] = "futuristic_charge_fast"
			}
		},
		animation_set = "default",
		shiny = true,
		spawn_cap = 6,
		name = "Goko",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 12,
				range = 21,
				cost = 400
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 17,
				range = 22,
				cost = 550
			},
			[3] = {
				attack_cooldown = 3,
				damage = 30,
				range = 23,
				cost = 1250
			},
			[4] = {
				attack_cooldown = 3,
				note = "+ Kaio-ken",
				cost = 2500,
				range = 25,
				damage = 65
			}
		},
		health = 100,
		primary_attack_no_upgrades = "goku:beam",
		cooldown = 10,
		evolve_craft = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 2,
						unit_id = "goku"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "dragon_ball",
						amount = 4
					},
					[2] = {
						item_id = "StarFruitBlue",
						amount = 2
					}
				}
			},
			evolve_unit = "goku_ssb",
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 2,
						unit_id = "goku"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "dragon_ball",
						amount = 8
					},
					[2] = {
						item_id = "StarFruitBlue",
						amount = 6
					},
					[3] = {
						item_id = "StarFruitEpic",
						amount = 1
					}
				}
			}
		}
	},
	guldo = {
		attack_cooldown = 60,
		primary_attack_no_upgrades = "guldo:paralysis",
		id = "guldo",
		hybrid_placement = true,
		range = 20,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "guldo_stun",
				[2] = "frieza_spawn_lazer"
			},
			particles = {
				[1] = "guldo_stun"
			},
			sfx = {
				[1] = "time_stop_one",
				[2] = "teleport_dbz",
				[3] = "stomp"
			}
		},
		boss = true,
		name = "Goldeo",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 30000,
		spawn_attack = "ginyu_force:spawn",
		damage = 35
	},
	noro = {
		attack_cooldown = 9,
		primary_attack_no_upgrades = "noro:attack_1",
		range = 18,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		passive_accessory_anim = "noro_kagune",
		damage = 75,
		upgrade_script = true,
		rarity = "Legendary",
		id = "noro",
		animation_set = "default",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "noro_tentacle",
				[2] = "noro_tentacle_large",
				[3] = "noro_tentacle:jump",
				[4] = "noro_tentacle:jump_large"
			},
			particles = {
				[1] = "noro_ground",
				[2] = "noro_ground_2"
			},
			sfx = {
				[1] = "gore_explode",
				[2] = "monster_bite"
			}
		},
		name = "Norro",
		cost = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 9,
				damage = 150,
				range = 19,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 9,
				damage = 200,
				range = 20,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 8.5,
				damage = 250,
				range = 21,
				cost = 2500
			},
			[4] = {
				attack_cooldown = 8.5,
				note = "+ Worm Consume",
				primary_attack = "noro:attack_2",
				cost = 3000,
				range = 22,
				damage = 300
			},
			[5] = {
				attack_cooldown = 8,
				damage = 450,
				range = 23,
				cost = 4500
			},
			[6] = {
				attack_cooldown = 8,
				damage = 600,
				range = 24,
				cost = 6000
			}
		},
		health = 100,
		cooldown = 10,
		shiny = true
	},
	alien_soldier_green_tank = {
		attack_cooldown = 2.23,
		id = "alien_soldier_green_tank",
		range = 7,
		animation_set = "default",
		name = "Alien Brawler",
		knockback_points = {
			[1] = 0.5
		},
		speed = 2,
		health = 100,
		hybrid_placement = true,
		damage = 5
	},
	shuu = {
		hybrid_placement = true,
		name = "Gourmet",
		health = 20,
		id = "shuu",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	sasori_clone_2 = {
		attack_cooldown = 8,
		_COPY_EFFECT_SCRIPTS = "sasori_clone",
		primary_attack_no_upgrades = "sasori:puppet_spawn",
		id = "sasori_clone",
		range = 7,
		animation_set = "default",
		max_spawn_units = 10,
		name = "Sashora (Puppet Master)",
		ASSETS = {
			sfx = {
				[1] = "puppet_spawn",
				[2] = "sasori_vo",
				[3] = "sasori_spawn",
				[4] = "woosh"
			}
		},
		speed = 1,
		spawn_effects = {
			[1] = {
				id = "sasori_puppet_spawn",
				modifiers = {
					stage = 2
				}
			}
		},
		hybrid_placement = true,
		health = 20
	},
	jiren_boss_evolved = {
		attack_cooldown = 10,
		id = "jiren_boss_evolved",
		health = 1500,
		range = 20,
		animation_set = "default",
		knockback_points = {
			[1] = 0.5
		},
		boss = true,
		name = "Jirun (Full Power)",
		spawn_effects = {
			[1] = {
				id = "jiren_boss_evolve",
				modifiers = {
					stage = "after"
				}
			}
		},
		speed = 1,
		damage = 100,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	juuzou = {
		attack_cooldown = 7,
		primary_attack_no_upgrades = "juuzou:spin",
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 37.5,
		rarity = "Mythic",
		id = "juuzou",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "juuzou"
			},
			sfx = {
				[1] = "spin_slow",
				[2] = "spin_metal",
				[3] = "explosion_fast"
			}
		},
		animation_set = "juuzou",
		spawn_cap = 4,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "juuzou"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "forbidden_candy",
						amount = 1
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "juuzou"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "forbidden_candy",
						amount = 1
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			evolve_unit = "juuzou_evolved",
			evolve_text = "+30% Attack, +Joker Arata"
		},
		name = "Juozu",
		upgrade = {
			[1] = {
				attack_cooldown = 6.5,
				damage = 75,
				range = 15.5,
				cost = 1750
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 150,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6,
				damage = 187.5,
				range = 16.5,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 6,
				damage = 262.5,
				range = 20,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 7.5,
				note = "+ Manic Frenzy",
				cost = 6500,
				primary_attack = "juuzou:line",
				range = 25,
				damage = 375
			},
			[6] = {
				attack_cooldown = 7.5,
				damage = 487.5,
				range = 26,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 7,
				damage = 600,
				range = 27,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 7,
				damage = 750,
				range = 30,
				cost = 10000
			}
		},
		health = 100,
		cost = 1250,
		cooldown = 10,
		shiny = true
	},
	akainu = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "akainu:punch",
		hill_unit = true,
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 100,
		upgrade_script = true,
		rarity = "Mythic",
		id = "akainu",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "magma_arm",
				[2] = "magma_arm_left",
				[3] = "magma_fist",
				[4] = "magma"
			},
			particles = {
				[1] = "magma_pillar"
			},
			sfx = {
				[1] = "lava_loop",
				[2] = "RocksDebris1",
				[3] = "acidburn",
				[4] = "Lazer_1",
				[5] = "ki_explosion"
			}
		},
		animation_set = "default",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "akainu"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "magu_fruit",
						amount = 1
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 20
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "akainu"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "magu_fruit",
						amount = 1
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 20
					}
				}
			},
			evolve_unit = "akainu_evolved",
			evolve_text = "+30% Attack, +20% Volcano Range"
		},
		spawn_cap = 4,
		name = "Akano",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 250,
				range = 20.5,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 350,
				range = 21,
				cost = 2000
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Great Eruption",
				primary_attack = "akainu:erupt",
				cost = 2500,
				range = 22,
				damage = 400
			},
			[4] = {
				attack_cooldown = 7,
				damage = 500,
				range = 23,
				cost = 3500
			},
			[5] = {
				attack_cooldown = 6,
				damage = 600,
				range = 24,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 800,
				range = 25,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 15,
				note = "+ Meteor Volcano",
				primary_attack = "akainu:shower",
				cost = 8500,
				range = 30,
				damage = 1250
			},
			[8] = {
				attack_cooldown = 15,
				damage = 1500,
				range = 40,
				cost = 10000
			}
		},
		health = 100,
		cost = 1250,
		cooldown = 10,
		shiny = true
	},
	katakuri = {
		attack_cooldown = 7,
		cost = 1400,
		range = 16,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 40,
		rarity = "Mythic",
		id = "katakuri",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "katakuri"
			},
			effect_models = {},
			vfx = {},
			sfx = {
				[1] = "mochi_spin",
				[2] = "mochi_start_up",
				[3] = "mochi_arm",
				[4] = "fire_release",
				[5] = "mochi_barrage_hit",
				[6] = "mochi_ground_splash",
				[7] = "woosh_sfx"
			}
		},
		animation_set = "default",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "katakuri"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "cupcake",
						amount = 2
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 15
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "katakuri"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "cupcake",
						amount = 2
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 15
					}
				}
			},
			evolve_unit = "katakuri_evolved",
			evolve_text = "+25% Attack, +Mochi Slow"
		},
		spawn_cap = 4,
		name = "Mochi",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 120,
				range = 17,
				cost = 2100
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 200,
				range = 18,
				cost = 2750
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Fire Mochi",
				primary_attack = "katakuri:fire_mochi",
				cost = 3500,
				range = 20,
				damage = 300
			},
			[4] = {
				attack_cooldown = 6,
				damage = 350,
				range = 21,
				cost = 4750
			},
			[5] = {
				attack_cooldown = 6,
				damage = 400,
				range = 22,
				cost = 5250
			},
			[6] = {
				attack_cooldown = 6,
				damage = 450,
				range = 22,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 7,
				note = "+ Mochi Barrage",
				primary_attack = "katakuri:mochi_barrage",
				cost = 9000,
				range = 23,
				damage = 550
			},
			[8] = {
				attack_cooldown = 6.5,
				damage = 600,
				range = 25,
				cost = 12000
			}
		},
		primary_attack_no_upgrades = "katakuri:donut",
		health = 100,
		cooldown = 10,
		shiny = true
	},
	mihawk = {
		attack_cooldown = 6,
		primary_attack_no_upgrades = "mihawk:rush",
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 50,
		rarity = "Legendary",
		shiny = true,
		animation_set = "sword:1h_long",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "mihawk_rush_slash_crescents"
			},
			effect_models = {
				[1] = "mihawk_slash"
			},
			sfx = {
				[1] = "Heavy_Charge",
				[2] = "heavy_sword_swing",
				[3] = "pulse_slash",
				[4] = "RocksDebris2",
				[5] = "futuristic_blast"
			},
			particles = {
				[1] = "mihawk_charge",
				[2] = "mihawk_rush_particle"
			},
			_new_fx = {
				[1] = "mihawk_revamp"
			}
		},
		name = "Mivawk",
		cost = 825,
		id = "mihawk",
		health = 100,
		cooldown = 10,
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 75,
				range = 13,
				cost = 600
			},
			[2] = {
				attack_cooldown = 5,
				damage = 90,
				range = 14,
				cost = 750
			},
			[3] = {
				attack_cooldown = 4,
				damage = 130,
				range = 15,
				cost = 1250
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Yoru Slash",
				primary_attack = "mihawk:slash",
				cost = 7000,
				range = 30,
				damage = 170
			},
			[5] = {
				attack_cooldown = 5,
				damage = 250,
				range = 35,
				cost = 8000
			}
		}
	},
	killua_godspeed = {
		attack_cooldown = 7,
		cost = 1600,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 120,
		rarity = "Mythic",
		id = "killua_godspeed",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "killua_godspeed"
			},
			sfx = {
				[1] = "Thunder_release_2",
				[2] = "Thunder_explosion",
				[3] = "zap1",
				[4] = "physical_explosion_with_debris",
				[5] = "electric_explosion2",
				[6] = "Lightning_Release"
			}
		},
		animation_set = "killua_godspeed",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "killua_godspeed"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "killua_yoyo",
						amount = 1
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "killua_godspeed"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "killua_yoyo",
						amount = 1
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit = "killua_godspeed_evolved",
			evolve_text = "+50% attack, +Paralysis"
		},
		health = 100,
		name = "Kizzua (Whirlwind)",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 200,
				range = 16,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 250,
				range = 18,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Thunderbolt",
				cost = 3500,
				primary_attack = "killua_godspeed:narukami",
				range = 19,
				damage = 350
			},
			[4] = {
				attack_cooldown = 6,
				damage = 400,
				range = 20,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 5.5,
				damage = 500,
				range = 21,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 600,
				range = 22,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 5,
				note = "+ Godspeed Whirlwind",
				cost = 10000,
				primary_attack = "killua_godspeed:rush",
				range = 23,
				damage = 800
			},
			[8] = {
				attack_cooldown = 4.5,
				damage = 1000,
				range = 24,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "killua_godspeed:dash",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	broly_evolved = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "broly:smash",
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "broly"
		},
		damage = 137.5,
		rarity = "Mythic",
		id = "broly_evolved",
		animation_set = "broly",
		spawn_cap = 4,
		ASSETS = {
			vfx = {
				[1] = "broly_ball",
				[2] = "broly_beam_cylinder",
				[3] = "broly_blast",
				[4] = "broly_ball_small"
			},
			particles = {
				[1] = "broly_lightning_aura",
				[2] = "explosion_broly",
				[3] = "broly_ball_particles",
				[4] = "broly_beam"
			},
			sfx = {
				[1] = "dbz_explosion_1",
				[2] = "futuristic_blast_3",
				[3] = "dbz_charge_three",
				[4] = "broly_power_up",
				[5] = "quick_beam",
				[6] = "ki_charge_long"
			}
		},
		name = "Legendary Brulo",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 250,
				range = 13,
				cost = 1400
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 375,
				range = 15,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 7,
				damage = 625,
				range = 16,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Eraser Beam",
				primary_attack = "broly:beam",
				cost = 4500,
				range = 18,
				damage = 625
			},
			[5] = {
				attack_cooldown = 6,
				damage = 687.5,
				range = 19,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 875,
				range = 20,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 15,
				note = "+ Saiyan Rage",
				primary_attack = "broly:aoe_attacks_evolved",
				cost = 8500,
				range = 37.5,
				damage = 1062.5
			},
			[8] = {
				attack_cooldown = 12,
				damage = 1250,
				range = 40.5,
				cost = 10000
			},
			[9] = {
				attack_cooldown = 12,
				damage = 1562.5,
				range = 45,
				cost = 12500
			}
		},
		health = 100,
		cost = 1350,
		hybrid_placement = true,
		shiny = true
	},
	eren_final = {
		max_spawns = {
			eren_founding_titan = 1,
			wall_titan_founding = 10
		},
		cost = 100000,
		range = 10,
		show_active_attack = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			use_own_model = true,
			from = "eren"
		},
		damage = 0,
		ASSETS = {
			vfx = {
				[1] = "eren_founding_titan"
			},
			_new_fx = {
				[1] = "eren_final"
			},
			sfx = {
				[1] = "titan_shift_boss",
				[2] = "electricity_aura",
				[3] = "physical_explosion_with_debris",
				[4] = "electric_explosion",
				[5] = "titan_roar_beast",
				[6] = "wind_long",
				[7] = "steam_hiss",
				[8] = "Thunder_explosion"
			}
		},
		cooldown = 10,
		rarity = "Mythic",
		upgrade = {
			[1] = {
				health = 25000,
				cost = 150000
			},
			[2] = {
				health = 50000,
				cost = 300000
			},
			[3] = {
				health = 100000,
				cost = 500000
			}
		},
		id = "eren_final",
		hide_from_banner = true,
		spawn_cap = 1,
		animation_set = "default",
		max_spawn_units = 11,
		hybrid_placement = true,
		name = "Erein (Founder)",
		active_attack_stats = {
			attack_cooldown = 480
		},
		health = 10000,
		active_attack = "eren_final:rumbling",
		spawn_unit = true,
		shiny = true
	},
	ichigo = {
		attack_cooldown = 3.5,
		cost = 350,
		range = 6,
		moving_gui_offset = CFrame.new(0, -0.634000003, -1.08000004, -1, -2.26266792e-08, -8.44439185e-08, 0, 0.965925813, -0.258819044, 8.74227766e-08, -0.258819044, -0.965925813),
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 20,
		rarity = "Rare",
		id = "ichigo",
		hybrid_placement = true,
		animation_set = "ichigo",
		ASSETS = {
			particles = {
				[1] = "ichigo_slash",
				[2] = "ichigo_slash_2"
			},
			sfx = {
				[1] = "heavy_sword_swing"
			}
		},
		health = 100,
		name = "Ichi",
		upgrade = {
			[1] = {
				attack_cooldown = 3.5,
				damage = 35,
				range = 6,
				cost = 450
			},
			[2] = {
				attack_cooldown = 3,
				damage = 50,
				range = 6.5,
				cost = 600
			},
			[3] = {
				attack_cooldown = 3,
				damage = 70,
				range = 6.5,
				cost = 1500
			},
			[4] = {
				attack_cooldown = 2.5,
				note = "+ Cross Slash",
				cost = 2500,
				primary_attack = "ichigo:slash_2",
				range = 7,
				damage = 100
			}
		},
		primary_attack_no_upgrades = "ichigo:slash",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	pouf_small = {
		hybrid_placement = true,
		name = "Butterfly (Split)",
		health = 20,
		id = "pouf_small",
		speed = 1,
		range = 7,
		animation_set = "fly_1"
	},
	pouf = {
		hybrid_placement = true,
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "pouf_spawn_clone"
				}
			},
			amount = 10,
			from_waves = true,
			delay = 0.5,
			units = {
				[1] = {
					diff_scale = 1,
					unit = "boss5_clone"
				}
			}
		},
		name = "Butterfly",
		health = 20,
		id = "pouf",
		speed = 1,
		range = 7,
		animation_set = "fly_1"
	},
	kite_evolved_precision = {
		attack_cooldown = 8,
		cost = 4000,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		hybrid_placement = true,
		evolved = {
			from = "kite"
		},
		damage = 300,
		upgrade_script = true,
		ASSETS = {
			_new_fx = {
				[1] = "kite"
			},
			sfx = {
				[1] = "ding",
				[2] = "boost_arcade",
				[3] = "SwordRing",
				[4] = "slower_slash",
				[5] = "wind_blow",
				[6] = "machine_gun",
				[7] = "kite_charge",
				[8] = "kite_pulse",
				[9] = "pulse1",
				[10] = "magic_blast"
			}
		},
		rarity = "Secret",
		health = 1000,
		id = "kite_evolved_precision",
		limited = {},
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 720,
				range = 25,
				cost = 8000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 1440,
				range = 27,
				cost = 12000
			},
			[3] = {
				attack_cooldown = 8,
				damage = 2100,
				range = 29,
				cost = 15000
			},
			[4] = {
				attack_cooldown = 8,
				damage = 2700,
				range = 30,
				cost = 20000
			}
		},
		_OVERRIDE_UNIT_SCRIPT = "script_kite",
		name = "Kit (Precision)",
		spawn_script = true,
		spawn_cap = 3,
		crit_chance = 0.4,
		cooldown = 10,
		shiny = true
	},
	whitebeard = {
		attack_cooldown = 8,
		cost = 1750,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 150,
		rarity = "Mythic",
		id = "whitebeard",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "whitebeard_slash_orb",
				[2] = "gura_Shockwave",
				[3] = "whitebeard_waves_orb",
				[4] = "whitebeard_ocean_wave"
			},
			effect_models = {
				[1] = "whitebeard_earthquake",
				[2] = "whitebeard_slash",
				[3] = "whitebeard_waves"
			},
			sfx = {
				[1] = "gura_charge",
				[2] = "gura_charge2",
				[3] = "gura_release",
				[4] = "gura_release2",
				[5] = "Heavy_Charge",
				[6] = "earthquake",
				[7] = "gura_wave",
				[8] = "tsunami"
			}
		},
		animation_set = "whitebeard",
		health = 100,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "whitebeard"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "gura_fruit",
						amount = 1
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 20
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "whitebeard"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "gura_fruit",
						amount = 1
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 20
					}
				}
			},
			evolve_unit = "whitebeard_evolved",
			evolve_text = "+30% Attack, +Sea Quake"
		},
		name = "Whitehair",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 300,
				range = 13,
				cost = 2500
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 450,
				range = 15,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 7,
				damage = 550,
				range = 16,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 7,
				damage = 750,
				range = 17,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 11,
				note = "+ Earthquake",
				primary_attack = "whitebeard:earthquake",
				cost = 6500,
				range = 20,
				damage = 850
			},
			[6] = {
				attack_cooldown = 11,
				damage = 1100,
				range = 22,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 11,
				damage = 1300,
				range = 23,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 10.5,
				damage = 1400,
				range = 24,
				cost = 12500
			}
		},
		spawn_cap = 3,
		primary_attack_no_upgrades = "whitebeard:slash",
		cooldown = 10,
		shiny = true
	},
	grimmjow = {
		attack_cooldown = 8,
		cost = 850,
		range = 16,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 30,
		rarity = "Legendary",
		shiny = true,
		animation_set = "sword:1h",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "grimmjow"
			},
			sfx = {
				[1] = "bladedismember1",
				[2] = "eto_laser",
				[3] = "naruto_beam_fire",
				[4] = "electric_explosion"
			}
		},
		name = "Grim Jaw",
		primary_attack_no_upgrades = "grimmjow:cero_left",
		id = "grimmjow",
		health = 1000,
		cooldown = 10,
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 60,
				range = 16.5,
				cost = 1200
			},
			[2] = {
				attack_cooldown = 7,
				damage = 100,
				range = 17,
				cost = 1600
			},
			[3] = {
				attack_cooldown = 7,
				damage = 175,
				range = 17.5,
				cost = 2250
			},
			[4] = {
				attack_cooldown = 7,
				damage = 250,
				range = 18,
				cost = 2500
			},
			[5] = {
				attack_cooldown = 6.5,
				note = "+ Blue Grand Cero",
				primary_attack = "grimmjow:grand_cero",
				cost = 4350,
				range = 23,
				damage = 275
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 325,
				range = 25,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 6,
				damage = 500,
				range = 27,
				cost = 12000
			}
		}
	},
	kakashi = {
		attack_cooldown = 5,
		cost = 550,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 7,
		rarity = "Epic",
		id = "kakashi",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			sfx = {
				[1] = "chidori",
				[2] = "ChidoriStart",
				[3] = "sharingan_activate"
			},
			effect_models = {
				[1] = "kakashi_lightning"
			}
		},
		shiny = true,
		name = "Kazashu",
		upgrade = {
			[1] = {
				attack_cooldown = 5,
				damage = 16,
				range = 13,
				cost = 750
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 27,
				range = 14,
				cost = 1250
			},
			[3] = {
				attack_cooldown = 4.5,
				damage = 45,
				range = 15,
				cost = 2000
			},
			[4] = {
				attack_cooldown = 4,
				note = "+ Lightning Cutter",
				cost = 3500,
				primary_attack = "kakashi:lightning",
				range = 20,
				damage = 45
			},
			[5] = {
				attack_cooldown = 4,
				damage = 55,
				range = 25,
				cost = 4500
			}
		},
		primary_attack_no_upgrades = "sasuke:chidori",
		spawn_cap = 5,
		cooldown = 10,
		health = 100
	},
	red_puppet = {
		id = "red_puppet",
		range = 20,
		animation_set = "fly_1",
		health = 20,
		ASSETS = {
			sfx = {
				[1] = "puppet_spawn"
			}
		},
		speed = 1,
		spawn_anim = "ground_rise",
		hybrid_placement = true,
		name = "Red Puppet"
	},
	tatara_evolved = {
		attack_cooldown = 4,
		primary_attack_no_upgrades = "tatara:kagune",
		range = 8,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "tatara"
		},
		damage = 66,
		rarity = "Mythic",
		id = "tatara_evolved",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "tatara"
			},
			sfx = {
				[1] = "fire_move",
				[2] = "fire_explosion_6",
				[3] = "woosh_long",
				[4] = "fire_cast",
				[5] = "physical_explosion_squeeze",
				[6] = "explosion_fast"
			}
		},
		animation_set = "default",
		shared_setup_script = "tatara",
		cost = 1300,
		name = "Tarata (Ignite)",
		upgrade = {
			[1] = {
				attack_cooldown = 3.5,
				damage = 110.00000000000001,
				range = 9,
				cost = 1650
			},
			[2] = {
				attack_cooldown = 3,
				damage = 165,
				range = 10,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Pyrokinesis",
				primary_attack = "tatara_evolved:flamethrower",
				cost = 3250,
				range = 22.5,
				damage = 357.50000000000006
			},
			[4] = {
				attack_cooldown = 7,
				damage = 467.50000000000006,
				range = 23,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 7,
				damage = 605,
				range = 24,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 7,
				note = "+ Incineration",
				primary_attack = "tatara_evolved:flamethrower_2",
				cost = 7000,
				range = 24.5,
				damage = 770.0000000000001
			},
			[7] = {
				attack_cooldown = 6.5,
				damage = 880.0000000000001,
				range = 26,
				cost = 9000
			},
			[8] = {
				attack_cooldown = 6,
				note = "+ Scorching Slam",
				primary_attack = "tatara_evolved:slam",
				cost = 12000,
				range = 27,
				damage = 990.0000000000001
			},
			[9] = {
				attack_cooldown = 6,
				damage = 1100,
				range = 27.5,
				cost = 14500
			}
		},
		spawn_cap = 4,
		health = 100,
		cooldown = 10,
		shiny = true
	},
	wall_titan_three = {
		hybrid_placement = true,
		speed = 5,
		name = "Colossal Wall Titan",
		knockback_points = {},
		id = "wall_titan_three",
		health = 10000,
		range = 100,
		animation_set = "default"
	},
	hollow_tank = {
		hybrid_placement = true,
		animation_set = "default",
		name = "Big Hollow",
		health = 20,
		id = "hollow_tank",
		speed = 1,
		range = 7,
		spawn_anim = "ground_rise"
	},
	all_might = {
		attack_cooldown = 9,
		cost = 1300,
		range = 11.5,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		spawn_attack = "all_might:land",
		damage = 50,
		rarity = "Mythic",
		id = "all_might",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "all_might_colors"
			},
			effect_models = {
				[1] = "all_might_cross",
				[2] = "all_might_punch",
				[3] = "all_might_smash"
			},
			particles = {
				[1] = "all_might_spin"
			},
			sfx = {
				[1] = "woosh_long",
				[2] = "Thunder_explosion",
				[3] = "heavy_slam",
				[4] = "allmight_explosion",
				[5] = "physical_explosion_with_debris",
				[6] = "lightning_bolt",
				[7] = "all_might_smash",
				[8] = "spin_slow2"
			}
		},
		animation_set = "all_might_unit",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "all_might"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "shining_extract",
						amount = 3
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "all_might"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "shining_extract",
						amount = 3
					}
				}
			},
			evolve_unit = "all_might_evolved",
			evolve_text = "+Smash knocks back, +40% damage, -10% Smash cooldown"
		},
		health = 5000,
		name = "All Force",
		upgrade = {
			[1] = {
				attack_cooldown = 8.5,
				damage = 130,
				range = 12,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 200,
				range = 12.5,
				cost = 2750
			},
			[3] = {
				attack_cooldown = 7.5,
				damage = 300,
				range = 13,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 7.5,
				note = "+ California Smash",
				primary_attack = "all_might:spin_punch",
				cost = 5000,
				range = 14,
				damage = 350
			},
			[5] = {
				attack_cooldown = 7,
				damage = 400,
				range = 15,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 7,
				damage = 600,
				range = 17,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 10,
				note = "+ United States of Smash!",
				primary_attack = "all_might:smash",
				cost = 10000,
				range = 20,
				damage = 1000
			}
		},
		primary_attack_no_upgrades = "all_might:cross",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	levi = {
		attack_cooldown = 7,
		cost = 1500,
		hill_unit = true,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 75,
		rarity = "Mythic",
		id = "levi",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "levi"
			},
			sfx = {
				[1] = "3dmg_shoot",
				[2] = "3dmg_retract",
				[3] = "3dmg_boost1",
				[4] = "3dmg_boost2",
				[5] = "spin_slow",
				[6] = "spin_fast",
				[7] = "slash_high"
			}
		},
		animation_set = "3dmg",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "levi"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "aot_blade",
						amount = 2
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "levi"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "aot_blade",
						amount = 2
					}
				}
			},
			evolve_unit = "levi_evolved",
			evolve_text = "+30% Attack, +25% Crit"
		},
		health = 5000,
		name = "Levy",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 150,
				range = 15.5,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 300,
				range = 16,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 6,
				damage = 450,
				range = 16.5,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 500,
				range = 17,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 6,
				note = "+ Aerial Assault",
				primary_attack = "levi:slashes_2",
				cost = 5500,
				range = 21,
				damage = 650
			},
			[6] = {
				attack_cooldown = 6,
				damage = 750,
				range = 22,
				cost = 6000
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 850,
				range = 23,
				cost = 7000
			},
			[8] = {
				attack_cooldown = 5,
				damage = 1000,
				range = 24,
				cost = 8000
			}
		},
		primary_attack_no_upgrades = "levi:slashes_1",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	zoro = {
		attack_cooldown = 3,
		cost = 400,
		range = 6,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 3,
		rarity = "Rare",
		id = "zoro",
		hybrid_placement = true,
		animation_set = "sword:2h",
		ASSETS = {
			sfx = {
				[1] = "strong_sword_slash"
			},
			effect_models = {
				[1] = "zoro_spin",
				[2] = "zoro_slashes"
			}
		},
		health = 100,
		name = "Zoru",
		upgrade = {
			[1] = {
				attack_cooldown = 3,
				damage = 8,
				range = 6,
				cost = 550
			},
			[2] = {
				attack_cooldown = 2.5,
				damage = 10,
				range = 6.5,
				cost = 850
			},
			[3] = {
				attack_cooldown = 2.5,
				note = "+ Three Sword Style",
				cost = 1500,
				primary_attack = "zoro:slashes",
				range = 10,
				damage = 20
			},
			[4] = {
				attack_cooldown = 2,
				damage = 25,
				range = 12,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "zoro:spin",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	aot_blimp = {
		death_fx = {
			[1] = {
				id = "marine_ship_crash",
				modifiers = {
					blimp = true
				}
			}
		},
		id = "aot_blimp",
		range = 7,
		animation_set = "ship",
		_EFFECT_SCRIPTS = {
			[1] = "marine_ship_crash"
		},
		death_anim = "ship",
		name = "Traitor Airship",
		ASSETS = {
			particles = {
				[1] = "marine_ship_crash"
			},
			sfx = {
				[1] = "crashing2"
			}
		},
		speed = 1,
		override_death_fx = "death_anim_no_fade",
		hybrid_placement = true,
		health = 20
	},
	pride3 = {
		attack_cooldown = 1.23,
		id = "pride3",
		range = 7,
		animation_set = "default",
		name = "Pride Trooper Scout",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	deidara_clone = {
		id = "deidara_clone",
		range = 8,
		animation_set = "default",
		_EFFECT_SCRIPTS = {
			[1] = "deidara_clone_self_destruct"
		},
		name = "Explosive Clone",
		ASSETS = {
			vfx = {
				[1] = "deidara_clone_orb"
			},
			sfx = {
				[1] = "katsu",
				[2] = "liquid_to_form_something",
				[3] = "physical_explosion_squeeze"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		death_attack = "deidara_clone:self_destruct"
	},
	jason = {
		attack_cooldown = 30,
		primary_attack_no_upgrades = "jason:shield",
		id = "jason",
		range = 7,
		animation_set = "default",
		name = "Jason",
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 0
	},
	shinkiro = {
		death_fx = {
			[1] = {
				id = "shinkiro_death"
			}
		},
		primary_attack_no_upgrades = "shinkiro:lazer",
		range = 100,
		override_death_fx = "death_anim_no_fade",
		knockback_points = {
			[1] = 0.5
		},
		speed = 0.5,
		spawn_attack = "shinkiro:spawn",
		damage = 0,
		upgrade_script = true,
		not_humanoid_rig = true,
		id = "shinkiro",
		animation_set = "shinkiro",
		hybrid_placement = true,
		name = "Shinkura",
		health = 1,
		cost = 1,
		attack_cooldown = 20,
		cooldown = 10,
		death_anim = "shinkiro"
	},
	inosuke = {
		attack_cooldown = 5,
		cost = 550,
		range = 8,
		moving_gui_offset = CFrame.new(0, -0.634000003, -1.39999998, -1, 1.51808077e-08, 8.6094623e-08, 0, 0.98480773, -0.173648193, -8.74227766e-08, -0.173648193, -0.98480773),
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 17,
		rarity = "Epic",
		id = "inosuke",
		hybrid_placement = true,
		animation_set = "inosuke",
		ASSETS = {
			vfx = {
				[1] = "InosukeSlash"
			},
			effect_models = {
				[1] = "inosuke_cross"
			},
			sfx = {
				[1] = "strong_sword_slash",
				[2] = "spin_slow",
				[3] = "spin_slow2"
			}
		},
		health = 100,
		name = "Inosoku",
		upgrade = {
			[1] = {
				attack_cooldown = 5,
				damage = 40,
				range = 8,
				cost = 750
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 55,
				range = 9,
				cost = 1100
			},
			[3] = {
				attack_cooldown = 4.5,
				damage = 75,
				range = 10,
				cost = 1500
			},
			[4] = {
				attack_cooldown = 4,
				note = "+ Beast Spin",
				cost = 2500,
				primary_attack = "inosuke:slashes",
				range = 12,
				damage = 90
			},
			[5] = {
				attack_cooldown = 3.5,
				damage = 105,
				range = 13,
				cost = 3250
			}
		},
		primary_attack_no_upgrades = "inosuke:cross",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	byakuya = {
		attack_cooldown = 5,
		cost = 550,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 10,
		rarity = "Epic",
		id = "byakuya",
		animation_set = "sword:1h",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "byakuya"
			},
			effect_models = {
				[1] = "byakuya_bankai"
			},
			sfx = {
				[1] = "shatter",
				[2] = "strong_sword_slash",
				[3] = "shatter2",
				[4] = "SwordRing"
			}
		},
		name = "Bakayua",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 4.5,
				damage = 20,
				range = 16,
				cost = 650
			},
			[2] = {
				attack_cooldown = 4,
				damage = 25,
				range = 17,
				cost = 700
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 30,
				range = 18,
				cost = 850
			},
			[4] = {
				attack_cooldown = 3.5,
				damage = 50,
				range = 19,
				cost = 1500
			},
			[5] = {
				attack_cooldown = 4,
				note = "+ One Thousand Cherry Blossoms",
				cost = 3000,
				primary_attack = "byakuya:bankai",
				range = 22,
				damage = 80
			},
			[6] = {
				attack_cooldown = 4,
				damage = 120,
				range = 25,
				cost = 4000
			}
		},
		primary_attack_no_upgrades = "byakuya:projectiles",
		cooldown = 10,
		shiny = true
	},
	rui = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "rui:webs",
		id = "rui",
		range = 100,
		animation_set = "default",
		name = "Zui",
		ASSETS = {
			vfx = {
				[1] = "rui_web"
			},
			effect_models = {
				[1] = "rui_webs"
			},
			sfx = {
				[1] = "woosh_throw_heavy",
				[2] = "SwordRing",
				[3] = "acidburn"
			}
		},
		speed = 15,
		hybrid_placement = true,
		health = 5000
	},
	giorno = {
		attack_cooldown = 7,
		cost = 800,
		range = 9,
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 60,
		rarity = "Legendary",
		hybrid_placement = true,
		id = "giorno",
		ASSETS = {
			vfx = {
				[1] = "Tree"
			},
			sfx = {
				[1] = "gold_experience_heal",
				[2] = "gold_experience_tree_1",
				[3] = "gold_experience_tree_2"
			},
			projectiles = {
				[1] = "frog"
			}
		},
		stand = "gold_experience",
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 120,
				range = 9.5,
				cost = 1200
			},
			[2] = {
				attack_cooldown = 5,
				damage = 175,
				range = 10,
				cost = 1750
			},
			[3] = {
				attack_cooldown = 5,
				damage = 245,
				range = 11.5,
				cost = 2200
			},
			[4] = {
				attack_cooldown = 4.5,
				damage = 300,
				range = 12,
				cost = 2750
			},
			[5] = {
				attack_cooldown = 4.5,
				note = "+ Life, spring forth!",
				primary_attack = "gold_experience:tree",
				cost = 6000,
				range = 15,
				damage = 350
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 400,
				range = 17,
				cost = 6500
			}
		},
		primary_attack_no_upgrades = "gold_experience:frog_throw_2",
		name = "Jiorno",
		spawn_effects = {
			[1] = {
				id = "summon_stand",
				modifiers = {
					play_sound = true
				}
			}
		},
		shiny = true,
		spawn_cap = 5,
		cooldown = 10,
		health = 2000
	},
	jonathan = {
		attack_cooldown = 4,
		cost = 400,
		range = 6,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 20,
		rarity = "Rare",
		id = "jonathan",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			effect_models = {
				[1] = "jonathan_ripple"
			},
			particles = {
				[1] = "hamon"
			},
			sfx = {
				[1] = "Lightning_Release"
			}
		},
		shiny = true,
		name = "Johna",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 25,
				range = 6.5,
				cost = 200
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 27,
				range = 6.5,
				cost = 300
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 30,
				range = 7,
				cost = 450
			},
			[4] = {
				attack_cooldown = 4.5,
				note = "+ Ripple Overdrive",
				cost = 2500,
				primary_attack = "jonathan:ripple",
				range = 10,
				damage = 30
			},
			[5] = {
				attack_cooldown = 4,
				damage = 35,
				range = 11,
				cost = 3000
			}
		},
		primary_attack_no_upgrades = "jonathan:punches",
		spawn_cap = 6,
		cooldown = 10,
		health = 100
	},
	shanks = {
		attack_cooldown = 7,
		primary_attack_no_upgrades = "shanks:slashes",
		range = 15,
		moving_gui_offset = CFrame.new(1.49028977e-12, -0.634000003, -1, -1, 1.52573776e-09, 8.7409461e-08, 0, 0.99984771, -0.0174524058, -8.74227766e-08, -0.0174524058, -0.99984771),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 75,
		rarity = "Mythic",
		gone_parts = {
			[1] = "Left Arm"
		},
		id = "shanks",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "shanks"
			},
			sfx = {
				[1] = "one_piece_alert",
				[2] = "pulse_slash",
				[3] = "electric_explosion2",
				[4] = "equip_generic"
			}
		},
		animation_set = "shanks",
		spawn_cap = 3,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "shanks"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "straw_hat",
						amount = 1
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 15
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "shanks"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "straw_hat",
						amount = 1
					},
					[2] = {
						item_id = "xp_devil_fruit",
						amount = 15
					}
				}
			},
			evolve_unit = "shanks_evolved",
			evolve_text = "+50% Attack, +Conqueror's Haki"
		},
		name = "Red Scar",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 150,
				range = 15,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 200,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 250,
				range = 17,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 300,
				range = 18,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 5.5,
				note = "+ Red Emperor",
				cost = 5000,
				primary_attack = "shanks:lightning",
				range = 20,
				damage = 350
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 400,
				range = 20,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 5,
				damage = 550,
				range = 21,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 5,
				damage = 700,
				range = 22,
				cost = 12500
			}
		},
		health = 100,
		cost = 1500,
		cooldown = 10,
		shiny = true
	},
	frieza_boss_transformed = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "frieza_boss:spawn_units",
		id = "frieza_boss_transformed",
		call_upgrade_script_on_pet = true,
		range = 20,
		animation_set = "fly_1",
		max_spawn_units = 10,
		boss = true,
		name = "Freezo (Final)",
		spawn_effects = {
			[1] = {
				id = "zarbon_evolved_spawn"
			}
		},
		speed = 1,
		upgrade_script = true,
		hybrid_placement = true,
		health = 1
	},
	bird_bomb = {
		upgrade_script = true,
		id = "bird_bomb",
		range = 8,
		animation_set = "default",
		name = "Clay Bird",
		ASSETS = {
			sfx = {
				[1] = "katsu",
				[2] = "liquid_to_form_something",
				[3] = "physical_explosion_squeeze"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		death_attack = "deidara_clone:self_destruct"
	},
	rabbit = {
		attack_cooldown = 1.23,
		id = "rabbit",
		range = 7,
		animation_set = "default",
		name = "Rabbit",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	katakuri_evolved = {
		attack_cooldown = 7,
		cost = 1400,
		range = 16,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "katakuri"
		},
		damage = 50,
		rarity = "Mythic",
		id = "katakuri_evolved",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			_new_fx = {
				[1] = "katakuri"
			},
			effect_models = {},
			vfx = {},
			sfx = {
				[1] = "mochi_spin",
				[2] = "mochi_start_up",
				[3] = "mochi_arm",
				[4] = "fire_release",
				[5] = "mochi_barrage_hit",
				[6] = "mochi_ground_splash",
				[7] = "woosh_sfx"
			}
		},
		spawn_cap = 4,
		name = "Mochi Charlot",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 150,
				range = 17,
				cost = 2100
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 250,
				range = 18,
				cost = 2750
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Fire Mochi",
				primary_attack = "katakuri:fire_mochi_evolved",
				cost = 3500,
				range = 20,
				damage = 375
			},
			[4] = {
				attack_cooldown = 6,
				damage = 437.5,
				range = 21,
				cost = 4750
			},
			[5] = {
				attack_cooldown = 6,
				damage = 500,
				range = 22,
				cost = 5250
			},
			[6] = {
				attack_cooldown = 6,
				damage = 562.5,
				range = 22,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 7,
				note = "+ Mochi Barrage",
				primary_attack = "katakuri:mochi_barrage_evolved",
				cost = 9000,
				range = 23,
				damage = 687.5
			},
			[8] = {
				attack_cooldown = 6.5,
				damage = 750,
				range = 25,
				cost = 12000
			},
			[9] = {
				attack_cooldown = 6.5,
				damage = 1000,
				range = 25,
				cost = 20000
			}
		},
		primary_attack_no_upgrades = "katakuri:donut_evolved",
		health = 100,
		cooldown = 10,
		shiny = true
	},
	pride1 = {
		attack_cooldown = 1.23,
		id = "pride1",
		range = 7,
		animation_set = "default",
		name = "Pride Trooper Member",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	goku_ssb = {
		attack_cooldown = 10,
		cost = 900,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 10,
		damage = 25,
		upgrade_script = true,
		rarity = "Legendary",
		id = "goku_ssb",
		animation_set = "default",
		hybrid_placement = true,
		ASSETS = {
			sfx = {
				[1] = "dbz_charge_one",
				[2] = "electric_pulse_hard",
				[3] = "Kamehameha"
			},
			effect_models = {
				[1] = "KamehamehaSSB",
				[2] = "KamehamehaSSBKaio",
				[3] = "KamehamehaSSBKaio_Charge",
				[4] = "KamehamehaSSB_Charge"
			}
		},
		name = "Goko Blue",
		spawn_cap = 5,
		upgrade = {
			[1] = {
				attack_cooldown = 9.5,
				damage = 50,
				range = 15.5,
				cost = 1100
			},
			[2] = {
				attack_cooldown = 9.5,
				damage = 75,
				range = 16,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 9,
				damage = 140,
				range = 16.5,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 8,
				note = "+ Kaio-ken x20",
				primary_attack = "goku_ssb:kamehameha_kaio",
				cost = 5500,
				range = 20,
				damage = 225
			},
			[5] = {
				attack_cooldown = 8,
				damage = 350,
				range = 22,
				cost = 7500
			},
			[6] = {
				attack_cooldown = 7,
				damage = 500,
				range = 24,
				cost = 9000
			}
		},
		primary_attack_no_upgrades = "goku_ssb:kamehameha",
		cooldown = 10,
		health = 2000
	},
	lelouch_evolved = {
		attack_cooldown = 7,
		max_spawns = {
			shinkiro = 1,
			britannia_soldier = 3
		},
		primary_attack_no_upgrades = "lelouch:summon",
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "lelouch"
		},
		damage = 50,
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "rifle_beam",
				[2] = "shinkiro_lazer"
			},
			particles = {
				[1] = "shinkiro",
				[2] = "shinkiro_death",
				[3] = "geass"
			},
			sfx = {
				[1] = "futuristic_blast2",
				[2] = "shinkiro_beam_charge",
				[3] = "shinkiro_beam_fire",
				[4] = "shinkiro_beam_powerdown",
				[5] = "scifi_door_open",
				[6] = "scifi_door_close",
				[7] = "futuristic_blast2",
				[8] = "physical_explosion_squeeze",
				[9] = "earthquake2",
				[10] = "crashing",
				[11] = "geass_activate"
			}
		},
		rarity = "Secret",
		cooldown = 10,
		id = "lelouch_evolved",
		upgrade = {
			[1] = {
				attack_cooldown = 6.5,
				damage = 75,
				health = 120,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 6,
				damage = 125,
				health = 200,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6,
				damage = 187.5,
				health = 300,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 5.5,
				damage = 250,
				health = 400,
				cost = 3500
			},
			[5] = {
				attack_cooldown = 5.5,
				note = "+ Shinkura",
				health = 400,
				cost = 6500,
				primary_attack = "lelouch:summon_2",
				damage = 250
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 375,
				health = 600,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 500,
				health = 800,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 5.5,
				note = "+ Geass!",
				health = 800,
				cost = 15000,
				active_attack_stats = {
					attack_cooldown = 40,
					damage = 0
				},
				active_attack = "lelouch:geass",
				range = 20,
				damage = 500
			}
		},
		health = 150,
		animation_set = "lelouch",
		max_spawn_units = 3,
		cost = 2000,
		name = "Lulu (Geass)",
		spawn_cap = 1,
		unsellable = true,
		blessing = {
			normal = "lelouch",
			shiny = "lelouch_shiny"
		},
		spawn_unit = true,
		shiny = true
	},
	lelouch = {
		attack_cooldown = 7,
		max_spawns = {
			shinkiro = 1,
			britannia_soldier = 3
		},
		primary_attack_no_upgrades = "lelouch:summon",
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		hybrid_placement = true,
		damage = 40,
		ASSETS = {
			vfx = {
				[1] = "rifle_beam",
				[2] = "shinkiro_lazer"
			},
			particles = {
				[1] = "shinkiro",
				[2] = "shinkiro_death",
				[3] = "geass"
			},
			sfx = {
				[1] = "futuristic_blast2",
				[2] = "shinkiro_beam_charge",
				[3] = "shinkiro_beam_fire",
				[4] = "shinkiro_beam_powerdown",
				[5] = "scifi_door_open",
				[6] = "scifi_door_close",
				[7] = "futuristic_blast2",
				[8] = "physical_explosion_squeeze",
				[9] = "earthquake2",
				[10] = "crashing",
				[11] = "geass_activate"
			}
		},
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "lelouch"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "black_king",
						amount = 1
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "lelouch"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "black_king",
						amount = 1
					}
				}
			},
			evolve_unit = "lelouch_evolved",
			evolve_text = "+Geass, +25% damage"
		},
		rarity = "Secret",
		cooldown = 10,
		id = "lelouch",
		upgrade = {
			[1] = {
				attack_cooldown = 6.5,
				damage = 60,
				health = 120,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 6,
				damage = 100,
				health = 200,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6,
				damage = 150,
				health = 300,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 5.5,
				damage = 200,
				health = 400,
				cost = 3500
			},
			[5] = {
				attack_cooldown = 5.5,
				note = "+ Shinkura",
				health = 400,
				cost = 6500,
				primary_attack = "lelouch:summon_2",
				damage = 200
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 300,
				health = 600,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 400,
				health = 800,
				cost = 8000
			}
		},
		health = 80,
		animation_set = "lelouch",
		max_spawn_units = 3,
		cost = 2000,
		name = "Lulu",
		spawn_cap = 1,
		unsellable = true,
		blessing = {
			normal = "lelouch",
			shiny = "lelouch_shiny"
		},
		spawn_unit = true,
		shiny = true
	},
	aizen = {
		attack_cooldown = 8,
		cost = 1400,
		range = 17,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 120,
		rarity = "Mythic",
		id = "aizen",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "aizen"
			},
			sfx = {
				[1] = "electric_explosion",
				[2] = "divine_scythe_cut",
				[3] = "dragon_roar",
				[4] = "pika_explode",
				[5] = "aizen_coffin_charge",
				[6] = "aizen_coffin_build",
				[7] = "Thunder_explosion"
			}
		},
		animation_set = "sword:1h",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "aizen"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "aizen_cube",
						amount = 1
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "aizen"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "aizen_cube",
						amount = 1
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			evolve_unit = "aizen_evolved",
			evolve_text = "+30% Attack, +KyÅka Suigetsu"
		},
		health = 1000,
		name = "Aizo",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 200,
				range = 17.5,
				cost = 2100
			},
			[2] = {
				attack_cooldown = 8,
				damage = 325,
				range = 18,
				cost = 2800
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Dragon Reiatsu Release",
				primary_attack = "aizen:dragon",
				cost = 3500,
				range = 18.5,
				damage = 450
			},
			[4] = {
				attack_cooldown = 7,
				damage = 550,
				range = 19,
				cost = 4000
			},
			[5] = {
				attack_cooldown = 7,
				damage = 700,
				range = 19.5,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 800,
				range = 20,
				cost = 6000
			},
			[7] = {
				attack_cooldown = 6.5,
				note = "+ HadÅ 90: Black Coffin",
				primary_attack = "aizen:coffin",
				cost = 8500,
				range = 20,
				damage = 1200
			},
			[8] = {
				attack_cooldown = 6.5,
				damage = 1600,
				range = 20.5,
				cost = 11000
			}
		},
		primary_attack_no_upgrades = "aizen:lightning",
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	kite_evolved_frenzy = {
		attack_cooldown = 6,
		cost = 4000,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "kite"
		},
		damage = 300,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Secret",
		ASSETS = {
			_new_fx = {
				[1] = "kite"
			},
			sfx = {
				[1] = "ding",
				[2] = "boost_arcade",
				[3] = "SwordRing",
				[4] = "slower_slash",
				[5] = "wind_blow",
				[6] = "machine_gun",
				[7] = "kite_charge",
				[8] = "kite_pulse",
				[9] = "pulse1",
				[10] = "magic_blast"
			}
		},
		id = "kite_evolved_frenzy",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 720,
				range = 25,
				cost = 8000
			},
			[2] = {
				attack_cooldown = 6,
				damage = 1440,
				range = 27,
				cost = 12000
			},
			[3] = {
				attack_cooldown = 6,
				damage = 2100,
				range = 29,
				cost = 15000
			},
			[4] = {
				attack_cooldown = 6,
				damage = 2700,
				range = 30,
				cost = 20000
			}
		},
		animation_set = "default",
		limited = {},
		_OVERRIDE_UNIT_SCRIPT = "script_kite",
		name = "Kit (Frenzy)",
		spawn_script = true,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	hollow_one = {
		hybrid_placement = true,
		animation_set = "default",
		name = "Hollow",
		health = 20,
		id = "hollow_one",
		speed = 1,
		range = 7,
		spawn_anim = "ground_rise"
	},
	kite_evolved__placeholder = {
		attack_cooldown = 8,
		cost = 4000,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "kite"
		},
		damage = 250,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Secret",
		ASSETS = {
			_new_fx = {
				[1] = "kite"
			},
			sfx = {
				[1] = "ding",
				[2] = "boost_arcade",
				[3] = "SwordRing",
				[4] = "slower_slash",
				[5] = "wind_blow",
				[6] = "machine_gun",
				[7] = "kite_charge",
				[8] = "kite_pulse",
				[9] = "pulse1",
				[10] = "magic_blast"
			}
		},
		id = "kite_evolved__placeholder",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 600,
				range = 25,
				cost = 8000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 1200,
				range = 27,
				cost = 12000
			},
			[3] = {
				attack_cooldown = 8,
				damage = 1750,
				range = 29,
				cost = 15000
			},
			[4] = {
				attack_cooldown = 8,
				damage = 2250,
				range = 30,
				cost = 20000
			}
		},
		animation_set = "default",
		limited = {},
		_OVERRIDE_UNIT_SCRIPT = "script_kite",
		name = "Kit (Random Blessing)",
		spawn_script = true,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	alien_soldier_miniboss = {
		id = "alien_soldier_miniboss",
		range = 7,
		animation_set = "alien_miniboss",
		barrier_destroy_script = true,
		ASSETS = {
			particles = {
				[1] = "alien_soldier_miniboss_explode"
			},
			sfx = {
				[1] = "zap1"
			}
		},
		name = "Alien General",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 100,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	eren = {
		attack_cooldown = 20,
		cost = 1000,
		range = 10,
		hybrid_placement = true,
		_EFFECT_SCRIPTS = {
			[1] = "titan_small_minion_spawn"
		},
		ASSETS = {
			sfx = {
				[1] = "Thunder_explosion",
				[2] = "steam_hiss",
				[3] = "titan_shift_two",
				[4] = "physical_explosion_with_debris",
				[5] = "eren_roar",
				[6] = "stomp"
			}
		},
		cooldown = 10,
		knockback_points = {
			[1] = 0.5
		},
		unsellable = true,
		delayed_spawn = 0.7333333333333333,
		primary_attack_no_upgrades = "attack_titan:spawn_titan",
		damage = 0,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 4,
						unit_id = "eren"
					},
					[2] = {
						amount = 4,
						unit_id = "zeke"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "aot_tree",
						amount = 9
					},
					[2] = {
						item_id = "aot_fluid",
						amount = 25
					}
				}
			},
			evolve_unit = "eren_final",
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 4,
						unit_id = "eren"
					},
					[2] = {
						shiny = true,
						amount = 4,
						unit_id = "zeke"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "aot_tree",
						amount = 9
					},
					[2] = {
						item_id = "aot_fluid",
						amount = 25
					}
				}
			},
			evolve_text = "+Erein (Founder)"
		},
		character_model = "attack_titan_smaller",
		rarity = "Legendary",
		delayed_spawn_attack = "titan_shifter_spawn",
		id = "eren",
		upgrade = {
			[1] = {
				attack_cooldown = 20,
				health = 56.25,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 19,
				health = 87.5,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 18,
				health = 137.5,
				cost = 2500
			},
			[4] = {
				attack_cooldown = 17,
				health = 200,
				cost = 3000
			},
			[5] = {
				attack_cooldown = 16,
				note = "+ Attack Titan",
				health = 275,
				active_attack = "attack_titan:spawn_self",
				active_attack_stats = {
					attack_cooldown = 45,
					damage = 0
				},
				cost = 4500,
				damage = 250
			},
			[6] = {
				attack_cooldown = 15,
				health = 375,
				cost = 6000
			}
		},
		health = 25,
		animation_set = "titan",
		max_spawn_units = 3,
		spawn_cap = 2,
		name = "Erein",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_shift",
				modifiers = {
					human_unit = "eren"
				}
			}
		},
		pet_animation_set = "3dmg",
		speed = 1,
		spawn_unit = true,
		shiny = true
	},
	toppo = {
		attack_cooldown = 1.23,
		id = "toppo",
		range = 7,
		animation_set = "default",
		name = "Topon",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	kite = {
		attack_cooldown = 8,
		cost = 4000,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 250,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Mythic",
		ASSETS = {
			_new_fx = {
				[1] = "kite"
			},
			sfx = {
				[1] = "ding",
				[2] = "boost_arcade",
				[3] = "SwordRing",
				[4] = "slower_slash",
				[5] = "wind_blow",
				[6] = "machine_gun",
				[7] = "kite_charge",
				[8] = "kite_pulse",
				[9] = "pulse1",
				[10] = "magic_blast"
			}
		},
		id = "kite",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "kite"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "kite_dice",
						amount = 2
					},
					[2] = {
						item_id = "kite_clown",
						amount = 1
					},
					[3] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit_client_override = "kite_evolved__placeholder",
			evolve_text = "+20% attack, +Random Blessing",
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "kite"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "kite_dice",
						amount = 2
					},
					[2] = {
						item_id = "kite_clown",
						amount = 1
					},
					[3] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit = {
				[1] = {
					chance = 0.25,
					unit_id = "kite_evolved_frenzy"
				},
				[2] = {
					chance = 0.25,
					unit_id = "kite_evolved_precision"
				},
				[3] = {
					chance = 0.25,
					unit_id = "kite_evolved_lethal"
				},
				[4] = {
					chance = 0.25,
					unit_id = "kite_evolved_focus"
				}
			}
		},
		health = 1000,
		animation_set = "default",
		limited = {},
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 600,
				range = 25,
				cost = 8000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 1200,
				range = 27,
				cost = 12000
			},
			[3] = {
				attack_cooldown = 8,
				damage = 1750,
				range = 29,
				cost = 15000
			},
			[4] = {
				attack_cooldown = 8,
				damage = 2250,
				range = 30,
				cost = 20000
			}
		},
		name = "Kit",
		spawn_script = true,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	ant_tank = {
		id = "ant_tank",
		range = 7,
		animation_set = "default",
		health = 20,
		name = "Shelled Ant",
		speed = 1,
		shield = 1,
		hybrid_placement = true,
		barrier = {
			health_ratio = 1,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	naruto_pts_evolved = {
		attack_cooldown = 7.5,
		cost = 1500,
		range = 14,
		moving_gui_offset = CFrame.new(0, 0.349999994, -1.25, -1, 0, -8.74227766e-08, 0, 1, 0, 8.74227766e-08, 0, -1),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			use_own_model = true,
			from = "naruto_pts"
		},
		damage = 100,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "naruto_pts_evolved",
		hide_from_banner = true,
		live_model_offset = CFrame.new(0, 0.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		animation_set = "naruto_pts",
		ASSETS = {
			_new_fx = {
				[1] = "naruto_pts_evolved"
			},
			sfx = {
				[1] = "naruto_slap_explode",
				[2] = "naruto_slap",
				[3] = "naruto_swing",
				[4] = "naruto_beam_charge",
				[5] = "naruto_beam_fire",
				[6] = "naruto_beam_fire_2",
				[7] = "naruto_hand_summon",
				[8] = "bladedismember2",
				[9] = "pika_explode"
			}
		},
		health = 100,
		name = "Noruto (Beast Cloak)",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 200,
				range = 15,
				cost = 2250
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 275,
				range = 16,
				cost = 3000
			},
			[3] = {
				attack_cooldown = 6,
				note = "+ Vermillion Slash",
				primary_attack = "naruto_pts_evolved:slam",
				cost = 3500,
				range = 20,
				damage = 350
			},
			[4] = {
				attack_cooldown = 6,
				damage = 400,
				range = 21,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 6,
				damage = 500,
				range = 22,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 575,
				range = 23,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 5.5,
				note = "+ Vermillion Rasengan",
				primary_attack = "naruto_pts_evolved:beam",
				cost = 10000,
				range = 27,
				damage = 750
			},
			[8] = {
				attack_cooldown = 5,
				damage = 900,
				range = 30,
				cost = 13500
			}
		},
		primary_attack_no_upgrades = "naruto_pts_evolved:bomb_throw",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	hantengu_clone = {
		hybrid_placement = true,
		health = 20,
		name = "Clone Demon",
		ASSETS = {
			particles = {
				[1] = "hantengu_clone_spawn"
			}
		},
		id = "hantengu_clone",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	nen_ant = {
		hybrid_placement = true,
		animation_set = "default",
		name = "Officer Ant",
		health = 20,
		id = "nen_ant",
		speed = 1,
		range = 7,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	ant_fly = {
		hybrid_placement = true,
		health = 20,
		name = "Winged Ant",
		speed = 1,
		id = "ant_fly",
		passives = {
			Flying = true
		},
		range = 7,
		animation_set = "fly_1"
	},
	akainu_boss = {
		attack_cooldown = 15,
		primary_attack_no_upgrades = "akainu:magma",
		id = "akainu_boss",
		range = 7,
		animation_set = "default",
		name = "Akano",
		kill_reward = {
			item_id = "capsule_marineford"
		},
		speed = 1,
		ASSETS = {
			vfx = {
				[1] = "magma"
			},
			sfx = {
				[1] = "lava_loop",
				[2] = "acidburn"
			}
		},
		hybrid_placement = true,
		health = 20
	},
	aot_generic = {
		attack_cooldown = 10,
		hybrid_placement = true,
		upgrade_script = true,
		override_hit_animations = true,
		id = "aot_generic",
		override_bounding_box_particles = {
			orientation = CFrame.new(-3064.41992, -1.67562604, -629.428528, 1, 0, 2.23517418e-08, 0, 1, 0, 2.23517418e-08, 0, 1),
			_rootc0 = CFrame.new(-3064.41992, -2.05570006, -629.289978, 1, 0, 2.23517418e-08, 0, 1, 0, 2.23517418e-08, 0, 1),
			size = 1.727262020111084, 3.351259708404541, 3.767594814300537
		},
		range = 10,
		animation_set = "aot_rider",
		shiny = true,
		cost = 1,
		name = "Survey Corps Member",
		knockback_points = {
			[1] = 0.5
		},
		speed = 3,
		health = 100,
		cooldown = 10,
		damage = 15
	},
	starrk_wolf = {
		upgrade_script = true,
		id = "starrk_wolf",
		range = 7,
		animation_set = "default",
		shield = 1,
		name = "Spirit Wolf",
		spawn_effects = {
			[1] = {
				id = "starrk_wolf_spawn",
				modifiers = {
					stage = "wolf"
				}
			}
		},
		speed = 1,
		ASSETS = {
			particles = {
				[1] = "wolf_spawn"
			}
		},
		hybrid_placement = true,
		health = 20
	},
	arrancar_tendril = {
		upgrade_script = true,
		hybrid_placement = true,
		name = "Tendril",
		health = 20,
		id = "arrancar_tendril",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	cheeta = {
		hybrid_placement = true,
		name = "Cheetah",
		health = 20,
		id = "cheeta",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	sengoku_buddha = {
		hybrid_placement = true,
		health = 20,
		name = "Senbodu (Buddha)",
		spawn_effects = {
			[1] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx = "one_piece_alert"
				}
			}
		},
		id = "sengoku_buddha",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	colt = {
		hybrid_placement = true,
		name = "Condor",
		health = 20,
		id = "colt",
		speed = 1,
		range = 7,
		animation_set = "fly_1"
	},
	menth = {
		id = "menth",
		range = 7,
		animation_set = "default",
		health = 20,
		name = "Rage Ant",
		speed = 1,
		barrier_destroy_script = true,
		hybrid_placement = true,
		barrier = {
			health_ratio = 1,
			buffs = {
				[1] = {
					params = {
						reduction = 0.5,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	ant = {
		hybrid_placement = true,
		name = "Chimera Ant",
		health = 20,
		id = "ant",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	ant_egg = {
		id = "ant_egg",
		range = 7,
		animation_set = "default",
		health = 20,
		name = "Ant Egg",
		spawn_script = true,
		speed = 1,
		ASSETS = {
			particles = {
				[1] = "ant_egg_spawn"
			},
			sfx = {
				[1] = "gore_explode2"
			}
		},
		hybrid_placement = true,
		shield = 5
	},
	menos_grand = {
		_auto_bounding_box = true,
		not_humanoid_rig = true,
		id = "menos_grand",
		range = 7,
		animation_set = "menos_grand",
		name = "Massive Hollow",
		death_spawn = {
			units = {
				[1] = {
					health_ratio = 0.1,
					unit = "hollow_one"
				},
				[2] = {
					health_ratio = 0.2,
					unit = "hollow_tank"
				},
				[3] = {
					health_ratio = 0.15,
					unit = "hollow_fly"
				}
			},
			delay = 0.5,
			amount = 2
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.25,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	konan = {
		hybrid_placement = true,
		ASSETS = {
			particles = {
				[1] = "konan_paper"
			},
			effect_models = {
				[1] = "konan_paper_attack"
			}
		},
		cost = 1,
		id = "konan",
		approach_distance = 1.75,
		range = 20,
		animation_set = "fly_1",
		attacks = {
			melee_basic_1:1 = {
				damage = 35,
				cooldown = 1.23,
				weight = 1
			},
			konan:paper_attack = {
				damage = 52.5,
				cooldown = 3,
				weight = 1
			}
		},
		knockback_points = {
			[1] = 0.5
		},
		name = "Komon",
		xp_reward = {
			min = 50,
			max = 100
		},
		speed = 1,
		health = 1000,
		cooldown = 10,
		gold_kill_reward = {
			min = 5,
			max = 10
		}
	},
	sakura = {
		attack_cooldown = 0,
		cost = 600,
		range = 5,
		aura_buff = {
			buffs = {
				[1] = {
					name = "damage_buff__sakura",
					params = {
						damage_add = 0.1
					}
				}
			}
		},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 0,
		rarity = "Rare",
		ASSETS = {
			particles = {
				[1] = "sakura_heal"
			}
		},
		id = "sakura",
		cooldown = 10,
		end_of_wave = {
			[1] = {
				type = "heal",
				animation = "sakura:aoe_heal",
				effects = {
					[1] = {
						id = "sakura_heal_particles"
					}
				}
			}
		},
		animation_set = "naruto",
		base_heal_amount = 25,
		upgrade = {
			[1] = {
				attack_cooldown = 0,
				health = 100,
				cost = 800,
				range = 6,
				damage = 0
			},
			[2] = {
				attack_cooldown = 0,
				health = 100,
				cost = 1200,
				range = 7,
				damage = 0
			},
			[3] = {
				attack_cooldown = 0,
				health = 100,
				cost = 2000,
				range = 8,
				damage = 0
			}
		},
		name = "Sakuro",
		health = 100,
		spawn_cap = 3,
		hybrid_placement = true,
		shiny = true
	},
	ulquiorra = {
		attack_cooldown = 8,
		cost = 1350,
		range = 19,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 80,
		rarity = "Mythic",
		id = "ulquiorra",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "ulquiorra"
			},
			sfx = {
				[1] = "woosh",
				[2] = "ulquiorra_ball_explosion",
				[3] = "slower_slash",
				[4] = "pulse1",
				[5] = "quick_beam",
				[6] = "slash_strong",
				[7] = "woosh_sfx",
				[8] = "charge_really_fast",
				[9] = "cero_ulquiorra",
				[10] = "ulquiorra_spear_charge",
				[11] = "woosh_throw_spear",
				[12] = "ulquiorra_spear_explosion"
			}
		},
		animation_set = "default",
		health = 1000,
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "ulquiorra"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "ulquiorra_spear",
						amount = 2
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "ulquiorra"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "ulquiorra_spear",
						amount = 2
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			evolve_unit = "ulquiorra_evolved",
			evolve_text = "+40% attack, +ResurrecciÃ³n"
		},
		name = "Ulquiro",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 230,
				range = 20,
				cost = 2500
			},
			[2] = {
				attack_cooldown = 8,
				damage = 400,
				range = 21,
				cost = 3500
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Espada Whirlwind",
				primary_attack = "ulquiorra:spin",
				cost = 5000,
				range = 23,
				damage = 500
			},
			[4] = {
				attack_cooldown = 7.5,
				damage = 700,
				range = 24,
				cost = 5750
			},
			[5] = {
				attack_cooldown = 7,
				damage = 850,
				range = 25,
				cost = 7000
			},
			[6] = {
				attack_cooldown = 7,
				note = "+ Green Cero",
				primary_attack = "ulquiorra:cero",
				cost = 8500,
				range = 26.5,
				damage = 950
			},
			[7] = {
				attack_cooldown = 6.5,
				damage = 1050,
				range = 27,
				cost = 11000
			}
		},
		primary_attack_no_upgrades = "ulquiorra:balls_throw",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	baraggan = {
		transform = {
			health_ratio = 0.5,
			effects = {
				1 = {
					id = "baraggan_transform"
				}
			},
			transform_anim_name = "mystery_update_2",
			unit = "baraggan_evolved"
		},
		id = "baraggan",
		range = 7,
		animation_set = "sword:1h",
		name = "Barrago",
		ASSETS = {
			vfx = {
				1 = "baraggan_transform"
			},
			sfx = {
				[1] = "hollow_transform",
				[2] = "electric_explosion"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	nakime = {
		attack_cooldown = 1,
		id = "nakime",
		range = 7,
		animation_set = "default",
		name = "Upper Demon",
		health = 20,
		speed = 1,
		buffs = {
			[1] = {
				time = -1,
				name = "healing",
				params = {
					persistent = true,
					percent = 0.02,
					healing_rate = 1
				}
			}
		},
		hybrid_placement = true,
		damage = 50
	},
	arima = {
		attack_cooldown = 8,
		cost = 1350,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 55,
		rarity = "Mythic",
		id = "arima",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "ixa_tendril",
				[2] = "ixa_tendril_flipped",
				[3] = "tendril",
				[4] = "eto_shard"
			},
			_new_fx = {
				[1] = "arima"
			},
			particles = {
				[1] = "ixa_rise",
				[2] = "narukami_particles",
				[3] = "owl_particles"
			},
			sfx = {
				[1] = "electric_pulse_hard",
				[2] = "Lightning_Release_3",
				[3] = "electric_charge",
				[4] = "tendril_rise",
				[5] = "electric_slash",
				[6] = "whoosh_weird",
				[7] = "electric_slash_2",
				[8] = "owl_charge"
			}
		},
		animation_set = "3dmg",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "arima"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "weapon_briefcase",
						amount = 1
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "arima"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "weapon_briefcase",
						amount = 1
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			evolve_unit = "arima_evolved",
			evolve_text = "+35% attack, +Owl"
		},
		shiny = true,
		name = "Ariva",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 125,
				range = 23,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 200,
				range = 23.5,
				cost = 2200
			},
			[3] = {
				attack_cooldown = 7.5,
				damage = 275,
				range = 24,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Narukami",
				primary_attack = "arima:narukami_attack",
				cost = 5000,
				range = 24.5,
				damage = 375
			},
			[5] = {
				attack_cooldown = 7,
				damage = 525,
				range = 25,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 650,
				range = 26,
				cost = 7250
			},
			[7] = {
				attack_cooldown = 6.5,
				damage = 800,
				range = 26.5,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 6,
				damage = 900,
				range = 27.5,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "arima:ixa_attack",
		spawn_cap = 4,
		cooldown = 10,
		health = 5000
	},
	pitou = {
		attack_cooldown = 7,
		cost = 1350,
		range = 12,
		moving_gui_offset = CFrame.new(7.80220999e-10, -0.100000024, -1.39999998, -0.999390841, -0.0348995142, -8.6392042e-08, -0.0347666927, 0.995588243, -0.0871557444, 0.00304177962, -0.0871026739, -0.99619472),
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		passive_accessory_anim = "pitou_tail",
		damage = 150,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "pitou",
		ASSETS = {
			_new_fx = {
				[1] = "pitou"
			},
			sfx = {
				[1] = "slash_pitou",
				[2] = "slash_pitou_2",
				[3] = "slash_pitou_quick",
				[4] = "slash_pitou_gore",
				[5] = "summon_terpischora",
				[6] = "woosh_long"
			}
		},
		live_model_offset = CFrame.new(0, 0.25, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		animation_set = "pitou",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "pitou"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "pitou_puppet",
						amount = 3
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "pitou"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "pitou_puppet",
						amount = 3
					},
					[2] = {
						item_id = "hxh_fish",
						amount = 40
					}
				}
			},
			evolve_unit = "pitou_evolved",
			evolve_text = "+20% Attack, 25% Crit, +Terpsichora"
		},
		health = 100,
		name = "Pito",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 250,
				range = 13,
				cost = 1400
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 400,
				range = 15,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 600,
				range = 16,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				note = "+ Lethal Ambush",
				primary_attack = "pitou:jump_slash",
				cost = 4500,
				range = 18,
				damage = 700
			},
			[5] = {
				attack_cooldown = 6,
				damage = 900,
				range = 19,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 1300,
				range = 20,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 1500,
				range = 25,
				cost = 8500
			},
			[8] = {
				attack_cooldown = 5.5,
				damage = 1600,
				range = 27,
				cost = 10000
			}
		},
		primary_attack_no_upgrades = "pitou:dash_slash",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	gon = {
		attack_cooldown = 7,
		cost = 750,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 50,
		rarity = "Legendary",
		id = "gon",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "gon"
			},
			sfx = {
				[1] = "gon_charge",
				[2] = "pulse_slash",
				[3] = "rin_fireball_throw",
				[4] = "physical_explosion_with_debris"
			}
		},
		animation_set = "default",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 10,
						unit_id = "gon"
					}
				},
				item_requirement = {}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 10,
						unit_id = "gon"
					}
				},
				item_requirement = {}
			},
			evolve_unit = "gon_adult",
			evolve_text = "+Gone (Adult)"
		},
		health = 100,
		name = "Gone",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 100,
				range = 15,
				cost = 1200
			},
			[2] = {
				attack_cooldown = 7,
				damage = 175,
				range = 16,
				cost = 1600
			},
			[3] = {
				attack_cooldown = 6,
				note = "+ Paper",
				cost = 2000,
				primary_attack = "gon:paper",
				range = 17,
				damage = 200
			},
			[4] = {
				attack_cooldown = 6,
				damage = 300,
				range = 17,
				cost = 2400
			},
			[5] = {
				attack_cooldown = 6,
				damage = 350,
				range = 17,
				cost = 3000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 450,
				range = 18,
				cost = 3500
			},
			[7] = {
				attack_cooldown = 5,
				note = "+ Rock",
				cost = 5000,
				primary_attack = "gon:rock",
				range = 20,
				damage = 550
			},
			[8] = {
				attack_cooldown = 5,
				damage = 650,
				range = 20,
				cost = 6000
			}
		},
		primary_attack_no_upgrades = "gon:scissors",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	pitou_boss = {
		attack_cooldown = 22,
		primary_attack_no_upgrades = "pitou_boss:heal",
		id = "pitou_boss",
		range = 7,
		animation_set = "pitou_boss",
		hybrid_placement = true,
		name = "Pito",
		kill_reward = {
			item_id = "capsule_hxhant"
		},
		speed = 1,
		ASSETS = {
			_new_fx = {
				[1] = "pitou_boss"
			},
			sfx = {
				[1] = "shatter3",
				[2] = "shatter"
			}
		},
		passive_accessory_anim = "pitou_tail",
		health = 20
	},
	killua_godspeed_evolved = {
		attack_cooldown = 7,
		cost = 1600,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			use_own_model = true,
			from = "killua_godspeed"
		},
		damage = 180,
		rarity = "Mythic",
		id = "killua_godspeed_evolved",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "killua_godspeed"
			},
			sfx = {
				[1] = "Thunder_release_2",
				[2] = "Thunder_explosion",
				[3] = "zap1",
				[4] = "physical_explosion_with_debris",
				[5] = "electric_explosion2",
				[6] = "Lightning_Release"
			}
		},
		animation_set = "killua_godspeed",
		health = 100,
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 300,
				range = 16,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 375,
				range = 18,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Thunderbolt",
				cost = 3500,
				primary_attack = "killua_godspeed_evolved:narukami",
				range = 19,
				damage = 525
			},
			[4] = {
				attack_cooldown = 6,
				damage = 600,
				range = 20,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 5.5,
				damage = 750,
				range = 21,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 900,
				range = 22,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 5,
				note = "+ Godspeed Whirlwind",
				cost = 10000,
				primary_attack = "killua_godspeed_evolved:rush",
				range = 23,
				damage = 1200
			},
			[8] = {
				attack_cooldown = 4.5,
				damage = 1500,
				range = 24,
				cost = 12500
			},
			[9] = {
				attack_cooldown = 4,
				damage = 1875,
				range = 25,
				cost = 15000
			}
		},
		name = "Kizzua (Godspeed)",
		cellshading_color = Color3.new(0.501961, 0.733333, 0.858824),
		primary_attack_no_upgrades = "killua_godspeed_evolved:dash",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	hollow_adjucha = {
		id = "hollow_adjucha",
		range = 7,
		animation_set = "default",
		health = 20,
		name = "Adjuka",
		speed = 1,
		shield = 15,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	all_might_evolved = {
		attack_cooldown = 9,
		cost = 1300,
		range = 11.5,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "all_might"
		},
		damage = 70,
		rarity = "Mythic",
		id = "all_might_evolved",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "all_might_colors"
			},
			effect_models = {
				[1] = "all_might_cross",
				[2] = "all_might_punch",
				[3] = "all_might_smash"
			},
			particles = {
				[1] = "all_might_spin"
			},
			sfx = {
				[1] = "woosh_long",
				[2] = "Thunder_explosion",
				[3] = "heavy_slam",
				[4] = "allmight_explosion",
				[5] = "physical_explosion_with_debris",
				[6] = "lightning_bolt",
				[7] = "all_might_smash",
				[8] = "spin_slow2"
			}
		},
		animation_set = "all_might_unit",
		health = 5000,
		upgrade = {
			[1] = {
				attack_cooldown = 8.5,
				damage = 182,
				range = 12,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 280,
				range = 12.5,
				cost = 2750
			},
			[3] = {
				attack_cooldown = 7.5,
				damage = 420,
				range = 13,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 7.5,
				note = "+ California Smash",
				primary_attack = "all_might:spin_punch",
				cost = 5000,
				range = 14,
				damage = 489.99999999999994
			},
			[5] = {
				attack_cooldown = 7,
				damage = 560,
				range = 15,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 7,
				damage = 840,
				range = 17,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 9,
				note = "+ United States of Smash!",
				primary_attack = "all_might:smash_evolved",
				cost = 10000,
				range = 20,
				damage = 1400
			},
			[8] = {
				attack_cooldown = 9,
				damage = 2100,
				range = 20,
				cost = 12500
			}
		},
		name = "All Force (Symbol of Peace)",
		spawn_attack = "all_might:land",
		primary_attack_no_upgrades = "all_might:cross",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	naruto_minion_2 = {
		hybrid_placement = true,
		name = "Traitor Brute",
		health = 20,
		id = "naruto_minion_2",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	josuke = {
		attack_cooldown = 4.5,
		cost = 400,
		range = 10,
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 6,
		rarity = "Rare",
		hybrid_placement = true,
		id = "josuke",
		ASSETS = {
			vfx = {
				[1] = "crazy_diamond:separate"
			},
			particles = {
				[1] = "crazy_diamond_heal",
				[2] = "crazy_diamond_aura"
			},
			sfx = {
				[1] = "crazy_diamond_heavy",
				[2] = "crazy_diamond_hit",
				[3] = "crazy_diamond_fix",
				[4] = "the_world_light"
			}
		},
		shiny = true,
		animation_set = "default",
		stand = "crazy_diamond",
		upgrade = {
			[1] = {
				attack_cooldown = 4.5,
				damage = 14,
				range = 11,
				cost = 550
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 25,
				range = 12,
				cost = 650
			},
			[3] = {
				attack_cooldown = 4,
				damage = 35,
				range = 12,
				cost = 800
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Disassembling Punch",
				cost = 1750,
				primary_attack = "crazy_diamond:stun_punch",
				range = 14,
				damage = 35
			},
			[5] = {
				attack_cooldown = 4.5,
				damage = 50,
				range = 15,
				cost = 2000
			}
		},
		name = "Josuka",
		spawn_effects = {
			[1] = {
				id = "summon_stand",
				modifiers = {
					play_sound = true
				}
			}
		},
		primary_attack_no_upgrades = "crazy_diamond_barrage",
		spawn_cap = 4,
		cooldown = 10,
		health = 2000
	},
	hollow_tall = {
		_auto_bounding_box = true,
		not_humanoid_rig = true,
		override_limbs = {
			[1] = "Head",
			[2] = "LeftUpperArm",
			[3] = "LowerTorso",
			[4] = "RightUpperArm",
			[5] = "UpperTorso",
			[6] = "LeftLowerLeg",
			[7] = "RightLowerLeg"
		},
		id = "hollow_tall",
		range = 7,
		animation_set = "hollow_tall",
		name = "Tall Hollow",
		speed = 1,
		health = 20,
		hybrid_placement = true,
		shield = 5
	},
	ccg_armored = {
		shield = 15,
		range = 7,
		animation_set = "default",
		name = "Arata Unit",
		health = 20,
		speed = 1,
		id = "ccg_armored",
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	test_dummy = {
		id = "test_dummy",
		approach_distance = 30,
		range = 100,
		animation_set = "default",
		attacks = {},
		name = "Test Dummy",
		knockback_points = {
			[1] = 0.5
		},
		speed = 10,
		hybrid_placement = true,
		health = 100000
	},
	boss_puppet = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "big_puppet:shield",
		id = "boss_puppet",
		range = 20,
		animation_set = "fly_1",
		name = "Reanimated Puppet",
		ASSETS = {
			particles = {
				[1] = "big_puppet_sand"
			},
			sfx = {
				[1] = "puppet_spawn"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		spawn_anim = "ground_rise"
	},
	arrancar_one = {
		id = "arrancar_one",
		range = 7,
		animation_set = "default",
		_EFFECT_SCRIPTS = {
			[1] = "hantengu_spawn_clone"
		},
		name = "Aeronero",
		ASSETS = {
			particles = {
				[1] = "hantengu_clone_spawn"
			},
			sfx = {
				[1] = "gore_explode2"
			}
		},
		speed = 1,
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "hantengu_spawn_clone"
				}
			},
			units = {
				[1] = {
					health_ratio = 0.3,
					unit = "arrancar_tendril"
				}
			},
			delay = 0.5,
			amount = 5
		},
		hybrid_placement = true,
		health = 20
	},
	bodyguard = {
		hybrid_placement = true,
		name = "Family Bodyguard",
		health = 20,
		id = "bodyguard",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	touka = {
		attack_cooldown = 6,
		primary_attack_no_upgrades = "touka:attack_1",
		range = 15,
		ASSETS = {
			vfx = {
				[1] = "ukaku_crystal"
			},
			sfx = {
				[1] = "glass_shatter",
				[2] = "woosh_medium"
			}
		},
		speed = 15,
		damage = 25,
		rarity = "Legendary",
		id = "touka",
		hybrid_placement = true,
		animation_set = "ukaku",
		knockback_points = {
			[1] = 0.5
		},
		cost = 800,
		name = "Touci",
		spawn_effects = {
			[1] = {
				id = "touka_spawn"
			}
		},
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 50,
				range = 16,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 65,
				range = 16.5,
				cost = 1700
			},
			[3] = {
				attack_cooldown = 5.5,
				damage = 100,
				range = 17,
				cost = 2200
			},
			[4] = {
				attack_cooldown = 5,
				damage = 125,
				range = 18,
				cost = 2500
			},
			[5] = {
				attack_cooldown = 5,
				note = "+ Broken Wings",
				primary_attack = "touka:jump_attack",
				cost = 4000,
				range = 20,
				damage = 225
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 275,
				range = 22,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 4.5,
				damage = 375,
				range = 24,
				cost = 12500
			}
		},
		health = 100,
		cooldown = 10,
		shiny = true
	},
	marine_ship = {
		death_fx = {
			[1] = {
				id = "marine_ship_crash"
			}
		},
		id = "marine_ship",
		range = 7,
		animation_set = "ship",
		death_anim = "ship",
		name = "Marine Battleship",
		ASSETS = {
			particles = {
				[1] = "marine_ship_crash"
			},
			sfx = {
				[1] = "crashing2"
			}
		},
		speed = 1,
		override_death_fx = "death_anim_no_fade",
		hybrid_placement = true,
		health = 20
	},
	titan = {
		attack_cooldown = 1.23,
		id = "titan",
		range = 7,
		animation_set = "default",
		name = "Titan",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	starrk_pve = {
		attack_cooldown = 20,
		primary_attack_no_upgrades = "spawn_wolf",
		id = "starrk_pve",
		range = 7,
		animation_set = "default",
		max_spawn_units = 5,
		name = "Coyote",
		ASSETS = {
			particles = {
				[1] = "wolf_spawn"
			},
			sfx = {
				[1] = "wolf_bite",
				[2] = "wolf_howl"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	demon2 = {
		hybrid_placement = true,
		name = "Strong Demon",
		health = 20,
		id = "demon2",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	sasori_clone = {
		transform = {
			health_ratio = 0.8,
			effects = {
				1 = {
					id = "play_sfx_unit",
					modifiers = {
						play_at_position = true,
						sfx = "sasori_vo"
					}
				}
			},
			unit = "sasori_clone_2"
		},
		id = "sasori_clone",
		range = 7,
		animation_set = "default",
		name = "Sashora",
		spawn_effects = {
			[1] = {
				id = "sasori_puppet_spawn",
				modifiers = {
					stage = 1
				}
			}
		},
		speed = 1,
		ASSETS = {
			sfx = {
				[1] = "puppet_spawn",
				[2] = "sasori_vo",
				[3] = "sasori_spawn"
			}
		},
		hybrid_placement = true,
		health = 20
	},
	broly = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "broly:smash",
		range = 12,
		moving_gui_offset = CFrame.new(0, -0.629000008, -1.08000004, -1, -7.61939756e-09, -8.70901076e-08, 0, 0.99619472, -0.0871557444, 8.74227766e-08, -0.0871557444, -0.99619472),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 110,
		rarity = "Mythic",
		id = "broly",
		spawn_cap = 4,
		animation_set = "broly",
		ASSETS = {
			vfx = {
				[1] = "broly_ball",
				[2] = "broly_beam_cylinder",
				[3] = "broly_blast",
				[4] = "broly_ball_small"
			},
			particles = {
				[1] = "broly_lightning_aura",
				[2] = "explosion_broly",
				[3] = "broly_ball_particles",
				[4] = "broly_beam"
			},
			sfx = {
				[1] = "dbz_explosion_1",
				[2] = "futuristic_blast_3",
				[3] = "dbz_charge_three",
				[4] = "broly_power_up",
				[5] = "quick_beam",
				[6] = "ki_charge_long"
			}
		},
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "broly"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "broly_necklace",
						amount = 1
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "broly"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "broly_necklace",
						amount = 1
					}
				}
			},
			evolve_unit = "broly_evolved",
			evolve_text = "+50% Saiyan Rage range, +25% Damage"
		},
		name = "Brulo",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 200,
				range = 13,
				cost = 1400
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 300,
				range = 15,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 7,
				damage = 500,
				range = 16,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Eraser Beam",
				primary_attack = "broly:beam",
				cost = 4500,
				range = 18,
				damage = 500
			},
			[5] = {
				attack_cooldown = 6,
				damage = 550,
				range = 19,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 6,
				damage = 700,
				range = 20,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 15,
				note = "+ Saiyan Rage",
				primary_attack = "broly:aoe_attacks",
				cost = 8500,
				range = 25,
				damage = 850
			},
			[8] = {
				attack_cooldown = 12,
				damage = 1000,
				range = 27,
				cost = 10000
			}
		},
		health = 100,
		cost = 1350,
		hybrid_placement = true,
		shiny = true
	},
	meruem_evolved = {
		attack_cooldown = 7,
		cost = 1300,
		range = 15,
		moving_gui_offset = CFrame.new(0, -2.20000005, -1.20000005, -1, 0, -8.74227766e-08, 0, 1, 0, 8.74227766e-08, 0, -1),
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			use_own_model = true,
			from = "meruem"
		},
		damage = 195,
		rarity = "Mythic",
		id = "meruem_evolved",
		ASSETS = {
			_new_fx = {
				[1] = "meruem"
			},
			sfx = {
				[1] = "strong_sword_slash",
				[2] = "slash_heavy_slow",
				[3] = "slash_long_gory",
				[4] = "spin_fast",
				[5] = "EnergyBlast2",
				[6] = "ki_charge_long",
				[7] = "physical_explosion_squeeze",
				[8] = "beam_loud"
			}
		},
		live_model_offset = CFrame.new(0, -1.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		animation_set = "meruem_evolved",
		cooldown = 10,
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 325,
				range = 16,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 455,
				range = 17,
				cost = 2750
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 650,
				range = 18,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 780,
				range = 19,
				cost = 5000
			},
			[5] = {
				attack_cooldown = 6,
				note = "+ Rage Blast",
				cost = 6500,
				primary_attack = "meruem_evolved:beam",
				range = 25,
				damage = 1300
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 1560,
				range = 27,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 5.5,
				damage = 1950,
				range = 28,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 5,
				damage = 2340,
				range = 30,
				cost = 12500
			}
		},
		name = "King Meruam",
		primary_attack_no_upgrades = "meruem_evolved:rush",
		spawn_cap = 4,
		health = 100,
		hybrid_placement = true,
		shiny = true
	},
	baraggan_evolved = {
		id = "baraggan_evolved",
		range = 7,
		animation_set = "fly_1",
		name = "Barrago (King)",
		spawn_effects = {
			[1] = {
				id = "baraggan_evolved_spawn"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		shield = 15
	},
	aizen_evolved = {
		attack_cooldown = 8,
		cost = 1400,
		range = 17,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			use_own_model = true,
			from = "aizen"
		},
		damage = 156,
		rarity = "Mythic",
		id = "aizen_evolved",
		hybrid_placement = true,
		animation_set = "sword:1h",
		ASSETS = {
			_new_fx = {
				[1] = "aizen"
			},
			sfx = {
				[1] = "electric_explosion",
				[2] = "divine_scythe_cut",
				[3] = "dragon_roar",
				[4] = "pika_explode",
				[5] = "aizen_coffin_charge",
				[6] = "aizen_coffin_build",
				[7] = "Thunder_explosion",
				[8] = "shatter",
				[9] = "shatter2",
				[10] = "shatter3"
			}
		},
		health = 1000,
		name = "Aizo (Betrayal)",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 260,
				range = 17.5,
				cost = 2100
			},
			[2] = {
				attack_cooldown = 8,
				damage = 422.5,
				range = 18,
				cost = 2800
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Dragon Reiatsu Release",
				primary_attack = "aizen:dragon",
				cost = 3500,
				range = 18.5,
				damage = 585
			},
			[4] = {
				attack_cooldown = 7,
				damage = 715,
				range = 19,
				cost = 4000
			},
			[5] = {
				attack_cooldown = 7,
				damage = 910,
				range = 19.5,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 1040,
				range = 20,
				cost = 6000
			},
			[7] = {
				attack_cooldown = 6.5,
				note = "+ HadÅ 90: Black Coffin",
				primary_attack = "aizen:coffin",
				cost = 8500,
				range = 20,
				damage = 1560
			},
			[8] = {
				attack_cooldown = 6.5,
				damage = 2080,
				range = 20.5,
				cost = 11000
			},
			[9] = {
				attack_cooldown = 6.5,
				note = "+ KyÅka Suigetsu",
				active_attack = "aizen:illusion",
				cost = 15000,
				active_attack_stats = {
					attack_cooldown = 420
				},
				range = 22,
				damage = 2600
			}
		},
		primary_attack_no_upgrades = "aizen:lightning",
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	kaneki_2 = {
		attack_cooldown = 5,
		primary_attack_no_upgrades = "kaneki_centipede:swipe",
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		passive_accessory_anim = "centipede_kagune",
		damage = 50,
		rarity = "Legendary",
		id = "kaneki_2",
		animation_set = "kaneki_centipede",
		hybrid_placement = true,
		ASSETS = {
			sfx = {
				[1] = "slower_slash",
				[2] = "the_world_heavy_physical",
				[3] = "ki_explosion"
			},
			effect_models = {
				[1] = "kaneki_centipede_jump",
				[2] = "kaneki_centipede_swipe"
			}
		},
		name = "Kazeki (Centipede)",
		cost = 850,
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 85,
				range = 11,
				cost = 1200
			},
			[2] = {
				attack_cooldown = 5,
				damage = 150,
				range = 12,
				cost = 1750
			},
			[3] = {
				attack_cooldown = 5,
				damage = 200,
				range = 13,
				cost = 2250
			},
			[4] = {
				attack_cooldown = 4.5,
				damage = 250,
				range = 14,
				cost = 2750
			},
			[5] = {
				attack_cooldown = 7,
				note = "+ Kakuja Rush",
				primary_attack = "kaneki_centipede:jump",
				cost = 5000,
				range = 15,
				damage = 350
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 400,
				range = 16,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 6,
				damage = 500,
				range = 17,
				cost = 8000
			}
		},
		health = 100,
		cooldown = 10,
		shiny = true
	},
	flesh_demon_1 = {
		name = "Flesh Clone",
		health = 20,
		id = "flesh_demon_1",
		speed = 1,
		hybrid_placement = true,
		animation_set = "default"
	},
	starrk = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "starrk:shoot",
		range = 30,
		_EFFECT_SCRIPTS = {
			[1] = "starrk_wolf_spawn"
		},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 150,
		rarity = "Mythic",
		id = "starrk",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "starrk"
			},
			particles = {
				[1] = "wolf_spawn"
			},
			sfx = {
				[1] = "draw_gun",
				[2] = "futuristic_blast",
				[3] = "pulse2",
				[4] = "cero_fire",
				[5] = "futuristic_charge2",
				[6] = "wolf_bite",
				[7] = "wolf_howl",
				[8] = "starrk_vo"
			}
		},
		animation_set = "starrk",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "starrk"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "starrk_helmet",
						amount = 1
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "starrk"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "starrk_helmet",
						amount = 1
					},
					[2] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			evolve_unit = "starrk_evolved",
			evolve_text = "+50% Attack, +Los Lobos"
		},
		health = 100,
		name = "Coyote",
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 300,
				range = 31,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7,
				damage = 500,
				range = 32,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 800,
				range = 33,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 1000,
				range = 35,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 15,
				note = "+ Cero Metralleta",
				cost = 6000,
				primary_attack = "starrk:metra",
				range = 45,
				damage = 1200
			},
			[6] = {
				attack_cooldown = 15,
				damage = 1500,
				range = 46,
				cost = 8000
			},
			[7] = {
				attack_cooldown = 14.5,
				damage = 2000,
				range = 47,
				cost = 15000
			},
			[8] = {
				attack_cooldown = 14,
				damage = 2750,
				range = 48,
				cost = 25000
			}
		},
		cost = 1600,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	recoome = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "recoome:beam",
		id = "recoome",
		hybrid_placement = true,
		range = 20,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "frieza_spawn_lazer"
			},
			effect_models = {
				[1] = "recoome_beam"
			},
			sfx = {
				[1] = "pulse2",
				[2] = "dbz_release_woop",
				[3] = "teleport_dbz",
				[4] = "stomp"
			}
		},
		boss = true,
		name = "Zezoom",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 30000,
		spawn_attack = "ginyu_force:spawn",
		damage = 35
	},
	sasuke = {
		attack_cooldown = 6,
		cost = 350,
		range = 12,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 4,
		rarity = "Rare",
		id = "sasuke",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			vfx = {
				[1] = "sasuke_dragon_fire"
			},
			sfx = {
				[1] = "fire_explosion_2",
				[2] = "FireProjectile"
			}
		},
		health = 1000,
		name = "Sosuke",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 8,
				range = 12.5,
				cost = 450
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 15,
				range = 13,
				cost = 750
			},
			[3] = {
				attack_cooldown = 5.5,
				damage = 28,
				range = 13,
				cost = 1250
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Dragon Release",
				cost = 3000,
				primary_attack = "sasuke:dragon_fire",
				range = 15,
				damage = 35
			}
		},
		primary_attack_no_upgrades = "sasuke:fireball",
		spawn_cap = 6,
		cooldown = 10,
		shiny = true
	},
	kisuke = {
		attack_cooldown = 8,
		cost = 1500,
		limited = {},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 80,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "kisuke",
		ASSETS = {
			_new_fx = {
				[1] = "kisuke"
			},
			sfx = {
				[1] = "woosh_kisuke",
				[2] = "fire_move",
				[3] = "rin_flames2",
				[4] = "EnergyBlast2",
				[5] = "Lazer_shot",
				[6] = "physical_explosion_laser",
				[7] = "futuristic_charge_fast",
				[8] = "divine_scythe_cut",
				[9] = "portal_open",
				[10] = "pika_shot"
			}
		},
		health = 1000,
		animation_set = "kisuke_unit",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "kisuke"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "kisuke_stitches",
						amount = 2
					},
					[2] = {
						item_id = "kisuke_orb",
						amount = 1
					},
					[3] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "kisuke"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "kisuke_stitches",
						amount = 2
					},
					[2] = {
						item_id = "kisuke_orb",
						amount = 1
					},
					[3] = {
						item_id = "soul_candy",
						amount = 40
					}
				}
			},
			evolve_unit = "kisuke_evolved",
			evolve_text = "+40% attack, +Opened Crimson Princess"
		},
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 200,
				range = 22,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 300,
				range = 23,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Binding Mesh Net",
				primary_attack = "kisuke:net",
				cost = 3500,
				range = 25,
				damage = 350
			},
			[4] = {
				attack_cooldown = 7,
				damage = 400,
				range = 25.5,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 7,
				damage = 600,
				range = 26,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 6.5,
				note = "+ Crimson Princess",
				primary_attack = "kisuke:shield_blasts",
				cost = 6500,
				range = 27,
				damage = 800
			},
			[7] = {
				attack_cooldown = 6,
				damage = 1200,
				range = 28,
				cost = 9000
			},
			[8] = {
				attack_cooldown = 6,
				damage = 1400,
				range = 29,
				cost = 12000
			}
		},
		name = "Kisoko",
		range = 20,
		primary_attack_no_upgrades = "kisuke:portal",
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	aogiri_one = {
		hybrid_placement = true,
		name = "Aogiri Ghoul",
		health = 20,
		id = "aogiri_one",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	rukia = {
		attack_cooldown = 7,
		cost = 900,
		range = 12,
		_EFFECT_SCRIPTS = {
			[1] = "icecube_stun"
		},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 100,
		rarity = "Legendary",
		id = "rukia",
		hybrid_placement = true,
		animation_set = "sword:1h",
		ASSETS = {
			_new_fx = {
				[1] = "rukia"
			},
			sfx = {
				[1] = "slash_strong",
				[2] = "ice_burst",
				[3] = "ice_burst2",
				[4] = "ice_break1",
				[5] = "ice_break2",
				[6] = "wind_blow"
			}
		},
		health = 1000,
		name = "Ruki",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 125,
				range = 13,
				cost = 1350
			},
			[2] = {
				attack_cooldown = 7,
				damage = 150,
				range = 15,
				cost = 1700
			},
			[3] = {
				attack_cooldown = 15,
				note = "+ Second Dance: Hakuren",
				primary_attack = "rukia:juhaku",
				cost = 2150,
				range = 20,
				damage = 175
			},
			[4] = {
				attack_cooldown = 15,
				damage = 200,
				range = 20,
				cost = 2400
			},
			[5] = {
				attack_cooldown = 14,
				damage = 250,
				range = 20,
				cost = 3100
			},
			[6] = {
				attack_cooldown = 14,
				damage = 300,
				range = 20,
				cost = 3300
			},
			[7] = {
				attack_cooldown = 13,
				note = "+ Third Dance: Shirafune",
				primary_attack = "rukia:hakuren",
				cost = 5250,
				range = 21,
				damage = 400
			},
			[8] = {
				attack_cooldown = 12,
				damage = 500,
				range = 22,
				cost = 5500
			}
		},
		primary_attack_no_upgrades = "rukia:tsuki",
		spawn_cap = 4,
		cooldown = 10,
		shiny = true
	},
	britannia_soldier = {
		attack_cooldown = 2,
		primary_attack_no_upgrades = "britannia_soldier:rifle",
		id = "britannia_soldier",
		hybrid_placement = true,
		range = 20,
		animation_set = "default",
		cost = 1,
		cooldown = 10,
		name = "Britannia Soldier",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 1,
		passive_accessory_anim = "rifle",
		damage = 0
	},
	starrk_wolf_unit = {
		upgrade_script = true,
		not_humanoid_rig = true,
		id = "starrk_wolf_unit",
		range = 5,
		animation_set = "default",
		health = 20,
		name = "Spirit Wolf",
		spawn_effects = {
			[1] = {
				id = "starrk_wolf_spawn",
				modifiers = {
					stage = "wolf"
				}
			}
		},
		speed = 3,
		ASSETS = {
			particles = {
				[1] = "wolf_spawn"
			}
		},
		hybrid_placement = true,
		death_attack = "starrk_wolf_unit:explode"
	},
	ulquiorra_evolved = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "ulquiorra_evolved:dash",
		range = 20,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			use_own_model = true,
			from = "ulquiorra"
		},
		damage = 140,
		rarity = "Mythic",
		id = "ulquiorra_evolved",
		hybrid_placement = true,
		animation_set = "ulquiorra_evolved",
		ASSETS = {
			_new_fx = {
				[1] = "ulquiorra"
			},
			sfx = {
				[1] = "woosh",
				[2] = "ulquiorra_ball_explosion",
				[3] = "slower_slash",
				[4] = "pulse1",
				[5] = "quick_beam",
				[6] = "slash_strong",
				[7] = "woosh_sfx",
				[8] = "charge_really_fast",
				[9] = "cero_ulquiorra",
				[10] = "ulquiorra_spear_charge",
				[11] = "woosh_throw_spear",
				[12] = "ulquiorra_spear_explosion"
			}
		},
		spawn_cap = 4,
		name = "Ulquiro (ResurrecciÃ³n)",
		upgrade = {
			[1] = {
				attack_cooldown = 7.5,
				damage = 280,
				range = 23,
				cost = 2650
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 489.99999999999994,
				range = 25,
				cost = 3250
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Cero Oscuras",
				primary_attack = "ulquiorra_evolved:cero",
				cost = 5250,
				range = 28,
				damage = 700
			},
			[4] = {
				attack_cooldown = 7,
				damage = 979.9999999999999,
				range = 29,
				cost = 5500
			},
			[5] = {
				attack_cooldown = 7,
				damage = 1120,
				range = 29.5,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 7,
				damage = 1260,
				range = 30,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 7.5,
				note = "+ Lanza del RelÃ¡mpago",
				primary_attack = "ulquiorra_evolved:spear",
				cost = 8500,
				range = 37,
				damage = 1680
			},
			[8] = {
				attack_cooldown = 7.5,
				damage = 2240,
				range = 38,
				cost = 10000
			},
			[9] = {
				attack_cooldown = 7,
				damage = 2800,
				range = 40,
				cost = 12500
			}
		},
		cost = 1350,
		health = 1000,
		cooldown = 10,
		shiny = true
	},
	wall_titan_founding = {
		upgrade_script = true,
		id = "wall_titan_founding",
		hide_from_banner = true,
		range = 100,
		animation_set = "default",
		name = "Wall Titan",
		knockback_points = {},
		speed = 1.5,
		walk_run_mode = "walk",
		hybrid_placement = true,
		health = 10000
	},
	dio = {
		attack_cooldown = 5,
		cost = 900,
		range = 9,
		_EFFECT_SCRIPTS = {
			[1] = "star_platinum_ts"
		},
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 70,
		upgrade_script = true,
		rarity = "Legendary",
		hybrid_placement = true,
		id = "dio",
		ASSETS = {
			vfx = {
				[1] = "the_world_ref",
				[2] = "the_world_ts",
				[3] = "road_roller"
			},
			particles = {
				[1] = "road_roller_particles"
			},
			sfx = {
				[1] = "the_world_light",
				[2] = "the_world_heavy_physical",
				[3] = "time_stop_two",
				[4] = "physical_explosion_with_debris",
				[5] = "dio_muda",
				[6] = "heavy_slam",
				[7] = "the_world_vo"
			}
		},
		stand = "the_world",
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 120,
				range = 9.5,
				cost = 1050
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 150,
				range = 10,
				cost = 1100
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 200,
				range = 11,
				cost = 1550
			},
			[4] = {
				attack_cooldown = 15,
				note = "+ Road Rolla",
				primary_attack = "dio:road_roller_new",
				cost = 3000,
				range = 14,
				damage = 250
			},
			[5] = {
				attack_cooldown = 14,
				damage = 300,
				range = 15,
				cost = 4500
			},
			[6] = {
				attack_cooldown = 13,
				damage = 400,
				range = 16,
				cost = 5500
			}
		},
		primary_attack_no_upgrades = "stand_kick_barrage",
		name = "JIO",
		spawn_effects = {
			[1] = {
				id = "summon_stand",
				modifiers = {
					play_sound = true
				}
			}
		},
		shiny = true,
		spawn_cap = 3,
		cooldown = 10,
		health = 2000
	},
	kisuke_evolved = {
		attack_cooldown = 8,
		cost = 1500,
		limited = {},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			use_own_model = true,
			from = "kisuke"
		},
		damage = 112,
		upgrade_script = true,
		rarity = "Secret",
		hybrid_placement = true,
		id = "kisuke_evolved",
		ASSETS = {
			_new_fx = {
				[1] = "kisuke"
			},
			sfx = {
				[1] = "woosh_kisuke",
				[2] = "fire_move",
				[3] = "rin_flames2",
				[4] = "EnergyBlast2",
				[5] = "Lazer_shot",
				[6] = "physical_explosion_laser",
				[7] = "futuristic_charge_fast",
				[8] = "divine_scythe_cut",
				[9] = "portal_open",
				[10] = "pika_shot"
			}
		},
		health = 1000,
		animation_set = "kisuke_evolved",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 280,
				range = 22,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 420,
				range = 23,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 7,
				note = "+ Binding Mesh Net",
				primary_attack = "kisuke:net",
				cost = 3500,
				range = 25,
				damage = 489.99999999999994
			},
			[4] = {
				attack_cooldown = 7,
				damage = 560,
				range = 25.5,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 7,
				damage = 840,
				range = 26,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 6.5,
				note = "+ Opened Crimson Princess",
				active_attack_stats = {
					attack_cooldown = 120
				},
				primary_attack = "kisuke:shield_blasts",
				active_attack = "kisuke:buff",
				cost = 6500,
				range = 27,
				damage = 1120
			},
			[7] = {
				attack_cooldown = 6,
				cost = 9000,
				active_attack_stats = {
					attack_cooldown = 105
				},
				range = 28,
				damage = 1680
			},
			[8] = {
				attack_cooldown = 6,
				cost = 12000,
				active_attack_stats = {
					attack_cooldown = 90
				},
				range = 29,
				damage = 1959.9999999999998
			},
			[9] = {
				attack_cooldown = 6,
				damage = 2520,
				range = 30,
				cost = 14000
			}
		},
		range = 20,
		name = "Kisoko (Bankai)",
		primary_attack_no_upgrades = "kisuke:portal",
		spawn_cap = 3,
		blessing = {
			normal = "kisuke_evolved",
			shiny = "kisuke_evolved"
		},
		cooldown = 10,
		shiny = true
	},
	shanks_evolved = {
		attack_cooldown = 7,
		primary_attack_no_upgrades = "shanks:slashes",
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "shanks"
		},
		damage = 112.5,
		rarity = "Mythic",
		gone_parts = {
			[1] = "Left Arm"
		},
		id = "shanks_evolved",
		hybrid_placement = true,
		ASSETS = {
			_new_fx = {
				[1] = "shanks"
			},
			sfx = {
				[1] = "one_piece_alert",
				[2] = "pulse_slash",
				[3] = "electric_explosion2",
				[4] = "equip_generic"
			}
		},
		animation_set = "shanks",
		shared_setup_script = "shanks_evolved",
		spawn_cap = 3,
		name = "Red Scar (Conqueror)",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 225,
				range = 15,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 300,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 375,
				range = 17,
				cost = 3500
			},
			[4] = {
				attack_cooldown = 6,
				damage = 450,
				range = 18,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 5.5,
				note = "+ Red Emperor",
				cost = 5000,
				primary_attack = "shanks:lightning",
				range = 20,
				damage = 525
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 600,
				range = 20,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 5,
				damage = 825,
				range = 21,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 5,
				note = "+ Conqueror's Haki!",
				cost = 12500,
				active_attack_stats = {
					attack_cooldown = 30
				},
				active_attack = "shanks:haki",
				range = 22,
				damage = 1050
			},
			[9] = {
				attack_cooldown = 5,
				damage = 1500,
				range = 22,
				cost = 15000
			}
		},
		health = 100,
		cost = 1500,
		cooldown = 10,
		shiny = true
	},
	ginyu = {
		attack_cooldown = 10,
		primary_attack_no_upgrades = "ginyu:spawn_unit",
		id = "ginyu",
		range = 20,
		animation_set = "default",
		hybrid_placement = true,
		boss = true,
		name = "Gunyu",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		ASSETS = {
			vfx = {
				[1] = "frieza_spawn_lazer"
			},
			sfx = {
				[1] = "teleport_dbz",
				[2] = "stomp"
			}
		},
		spawn_attack = "ginyu_force:spawn",
		health = 30000
	},
	ccg_two = {
		hybrid_placement = true,
		name = "CCG Agent",
		health = 20,
		id = "ccg_two",
		speed = 1,
		range = 7,
		animation_set = "sword:1h_long"
	},
	luffy_marineford = {
		attack_cooldown = 6,
		cost = 525,
		limited = {},
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 20,
		rarity = "Epic",
		hybrid_placement = true,
		id = "luffy_marineford",
		hide_from_banner = true,
		ASSETS = {
			_new_fx = {
				[1] = "luffy_marineford"
			},
			sfx = {
				[1] = "critical_punch",
				[2] = "luffy_gun",
				[3] = "physical_explosion_quick"
			}
		},
		animation_set = "default",
		health = 100,
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 25,
				range = 10,
				cost = 400
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 35,
				range = 11,
				cost = 500
			},
			[3] = {
				attack_cooldown = 5.5,
				damage = 50,
				range = 12,
				cost = 600
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Jet Gatling Gear II",
				cost = 3000,
				primary_attack = "luffy_marineford:barrage",
				range = 13,
				damage = 100
			},
			[5] = {
				attack_cooldown = 5,
				damage = 150,
				range = 15,
				cost = 5000
			}
		},
		name = "Luffo (Marine's Ford)",
		range = 9,
		primary_attack_no_upgrades = "luffy_marineford:stomp",
		spawn_cap = 5,
		cooldown = 10,
		shiny = nil
	},
	orochimaru_boss = {
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "orochimaru_snake_projectile"
			}
		},
		cost = 1000,
		id = "orochimaru_boss",
		approach_distance = 1.75,
		range = 20,
		animation_set = "naruto",
		attacks = {
			orochimaru:snake_aoe = {
				damage = 35,
				cooldown = 4,
				weight = 1
			}
		},
		knockback_points = {
			[1] = 0.5
		},
		name = "Orochomaro",
		xp_reward = {
			min = 50,
			max = 100
		},
		speed = 1,
		health = 1000,
		cooldown = 10,
		gold_kill_reward = {
			min = 5,
			max = 10
		}
	},
	genos = {
		attack_cooldown = 4,
		cost = 550,
		hill_unit = true,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 11,
		rarity = "Epic",
		id = "genos",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "genos_lazer"
			},
			effect_models = {
				[1] = "genos_beam"
			},
			sfx = {
				[1] = "missile_fired",
				[2] = "physical_explosion_debris_fast",
				[3] = "Thunder_release",
				[4] = "Heavy_Charge"
			},
			particles = {
				[1] = "explosion_genos_lazer",
				[2] = "explosion_genos_missile",
				[3] = "genos_charge",
				[4] = "genos_fire",
				[5] = "genos_lazer"
			},
			projectiles = {
				[1] = "genos_missile"
			}
		},
		spawn_cap = 6,
		name = "Geno",
		upgrade = {
			[1] = {
				attack_cooldown = 3.5,
				damage = 20,
				range = 16,
				cost = 650
			},
			[2] = {
				attack_cooldown = 3,
				damage = 25,
				range = 17,
				cost = 700
			},
			[3] = {
				attack_cooldown = 2.5,
				damage = 30,
				range = 18,
				cost = 850
			},
			[4] = {
				attack_cooldown = 2.5,
				damage = 40,
				range = 19,
				cost = 1500
			},
			[5] = {
				attack_cooldown = 2.5,
				note = "+ Lazer Upgrade",
				cost = 3000,
				primary_attack = "genos:lazer",
				range = 22,
				damage = 50
			},
			[6] = {
				attack_cooldown = 2,
				damage = 60,
				range = 25,
				cost = 4000
			}
		},
		primary_attack_no_upgrades = "genos:missile",
		shiny = true,
		cooldown = 10,
		health = 100
	},
	akaza_unit = {
		attack_cooldown = 7.5,
		cost = 1100,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 60,
		rarity = "Legendary",
		hybrid_placement = true,
		id = "akaza_unit",
		hide_from_banner = true,
		ASSETS = {
			_new_fx = {
				[1] = "akaza_unit"
			},
			effect_models = {
				[1] = "akaza_compass"
			},
			particles = {
				[1] = "akaza_buffed"
			},
			sfx = {
				[1] = "punch_heavy_1",
				[2] = "dbz_release_woop",
				[3] = "physical_explosion_quick",
				[4] = "physical_explosion_with_debris",
				[5] = "Heavy_Charge",
				[6] = "punch_barrage",
				[7] = "futuristic_charge_fast",
				[8] = "power_up",
				[9] = "RocksDebris2"
			}
		},
		animation_set = "akaza",
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 4,
						unit_id = "akaza_unit"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "akaza_beads",
						amount = 2
					}
				}
			},
			evolve_unit = "akaza_unit_evolved",
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 4,
						unit_id = "akaza_unit"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "akaza_beads",
						amount = 2
					}
				}
			},
			evolve_text = "+200% Attack, +Disorder, +Compass Needle"
		},
		shiny = true,
		name = "Akoku",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 80,
				range = 15.5,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 7,
				damage = 100,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				note = "+ Annihilation Type",
				cost = 3000,
				primary_attack = "akaza_unit:annihilation",
				range = 16.5,
				damage = 150
			},
			[4] = {
				attack_cooldown = 6.5,
				damage = 250,
				range = 17,
				cost = 4250
			},
			[5] = {
				attack_cooldown = 6.5,
				note = "+ Ten Thousand Leaves",
				cost = 5500,
				primary_attack = "akaza_unit:leaves",
				range = 18,
				damage = 300
			},
			[6] = {
				attack_cooldown = 6,
				damage = 350,
				range = 18.5,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 6,
				damage = 550,
				range = 19,
				cost = 8500
			},
			[8] = {
				attack_cooldown = 6,
				damage = 750,
				range = 20,
				cost = 12500
			}
		},
		primary_attack_no_upgrades = "akaza_unit:air_type",
		spawn_cap = 5,
		cooldown = 10,
		health = 5000
	},
	marine_two = {
		hybrid_placement = true,
		name = "Marine Apprentice",
		health = 20,
		id = "marine_two",
		speed = 1,
		range = 7,
		animation_set = "sword:1h_long"
	},
	kokushibo = {
		attack_cooldown = 15,
		primary_attack_no_upgrades = "kokushibo:slash",
		id = "kokushibo",
		range = 30,
		animation_set = "sword:1h",
		name = "Kokoshibon",
		ASSETS = {
			vfx = {
				[1] = "kokushibo_katana_2",
				[2] = "kokushibo_slash"
			},
			sfx = {
				[1] = "gore_explode2",
				[2] = "strong_sword_slash2"
			}
		},
		speed = 15,
		hybrid_placement = true,
		health = 5000
	},
	slasher_demon = {
		name = "Slasher Demon",
		health = 20,
		id = "slasher_demon",
		speed = 1,
		hybrid_placement = true,
		animation_set = "default"
	},
	alien_soldier_red_shooter = {
		id = "alien_soldier_red_shooter",
		approach_distance = 17.5,
		range = 20,
		animation_set = "armcannon",
		attacks = {
			arm_cannon_blast = {
				damage = 35,
				cooldown = 1,
				weight = 1
			}
		},
		health = 1000,
		name = "Alien Captain",
		xp_reward = {
			min = 50,
			max = 100
		},
		speed = 1,
		knockback_points = {
			[1] = 0.5
		},
		hybrid_placement = true,
		gold_kill_reward = {
			min = 5,
			max = 10
		}
	},
	train_demon = {
		name = "Train Demon",
		health = 20,
		id = "train_demon",
		speed = 1,
		hybrid_placement = true,
		animation_set = "default"
	},
	pride_trooper_miniboss = {
		id = "pride_trooper_miniboss",
		range = 7,
		animation_set = "alien_miniboss",
		shield = 5,
		health = 100,
		name = "Pride Trooper General",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		barrier_destroy_script = true,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	pride2 = {
		attack_cooldown = 1.23,
		id = "pride2",
		range = 7,
		animation_set = "default",
		name = "Pride Trooper Elite",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	enmu_hand = {
		upgrade_script = true,
		name = "Detached Hand",
		health = 20,
		id = "enmu_hand",
		speed = 1,
		hybrid_placement = true,
		animation_set = "default"
	},
	renji = {
		attack_cooldown = 7.5,
		primary_attack_no_upgrades = "renji:orb",
		limited = {},
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 55,
		rarity = "Secret",
		hybrid_placement = true,
		id = "renji",
		ASSETS = {
			_new_fx = {
				[1] = "renji"
			},
			sfx = {
				[1] = "zap_long",
				[2] = "electric_sparks",
				[3] = "electric_sparks_2",
				[4] = "lightning_bolt_loud",
				[5] = "electric_explosion"
			}
		},
		shiny = true,
		animation_set = "default",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 100,
				range = 15.5,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 7,
				damage = 200,
				range = 16,
				cost = 2500
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 300,
				range = 16.5,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 6.5,
				damage = 400,
				range = 17,
				cost = 4250
			},
			[5] = {
				attack_cooldown = 6.5,
				note = "+ Charged RC Strike",
				primary_attack = "renji:strike",
				cost = 5500,
				range = 18,
				damage = 450
			},
			[6] = {
				attack_cooldown = 6,
				damage = 500,
				range = 18.5,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 6,
				damage = 600,
				range = 19,
				cost = 8500
			},
			[8] = {
				attack_cooldown = 5.5,
				damage = 700,
				range = 20,
				cost = 10000
			}
		},
		range = 15,
		name = "Renzi",
		health = 100,
		cost = 1100,
		blessing = {
			normal = "renji",
			shiny = "renji"
		},
		cooldown = 10,
		spawn_cap = 5
	},
	eto_evolved = {
		attack_cooldown = 8.5,
		primary_attack_no_upgrades = "eto:shards",
		range = 21,
		pet_character_model = "eto_pet",
		speed = 15,
		hybrid_placement = true,
		evolved = {
			from = "eto"
		},
		damage = 114.99999999999999,
		ASSETS = {
			vfx = {
				[1] = "eto_shard"
			},
			effect_models = {
				[1] = "eto_jump_land"
			},
			sfx = {
				[1] = "sweeping_beam",
				[2] = "tendril_rise",
				[3] = "eto_laser_charge",
				[4] = "eto_laser",
				[5] = "eto_laser_2",
				[6] = "eto_shards",
				[7] = "eto_screech",
				[8] = "eto_screech2",
				[9] = "physical_explosion_with_debris",
				[10] = "physical_swing",
				[11] = "monster_attack_sound"
			},
			particles = {
				[1] = "eto_spawn"
			},
			_new_fx = {
				[1] = "eto"
			}
		},
		knockback_points = {
			[1] = 0.5
		},
		rarity = "Mythic",
		spawn_cap = 3,
		id = "eto_evolved",
		health = 100,
		override_hitbox_radius = 8,
		animation_set = "eto",
		on_kill = {
			percent_damage = 0.00033333333
		},
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 258.75,
				range = 22,
				cost = 3500
			},
			[2] = {
				attack_cooldown = 8,
				damage = 402.49999999999994,
				range = 23.5,
				cost = 4500
			},
			[3] = {
				attack_cooldown = 8,
				damage = 575,
				range = 24,
				cost = 5000
			},
			[4] = {
				attack_cooldown = 8,
				note = "+ Kakuja Barrage",
				primary_attack = "eto:jump",
				cost = 6000,
				range = 25,
				damage = 862.4999999999999
			},
			[5] = {
				attack_cooldown = 7.5,
				damage = 1035,
				range = 26,
				cost = 7500
			},
			[6] = {
				attack_cooldown = 7,
				damage = 1150,
				range = 27,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 11,
				note = "+ Laser Augment",
				primary_attack = "eto:laser",
				cost = 20000,
				range = 40,
				damage = 2012.4999999999998
			},
			[8] = {
				attack_cooldown = 10,
				damage = 2530,
				range = 50,
				cost = 25000
			}
		},
		name = "Eta (One-Eye)",
		spawn_effects = {
			[1] = {
				id = "eto_spawn"
			}
		},
		cost = 2500,
		pet_animation_set = "default",
		cooldown = 10,
		shiny = true
	},
	gaara = {
		attack_cooldown = 4.5,
		cost = 550,
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		damage = 12,
		rarity = "Epic",
		id = "gaara",
		hybrid_placement = true,
		animation_set = "naruto",
		ASSETS = {
			vfx = {
				[1] = "gaara_coffin"
			},
			effect_models = {
				[1] = "gaara_spikes"
			},
			sfx = {
				[1] = "woosh_throw_heavy",
				[2] = "dirt",
				[3] = "wind_slap",
				[4] = "crunch"
			}
		},
		health = 100,
		name = "Gaaro",
		upgrade = {
			[1] = {
				attack_cooldown = 4.5,
				damage = 27,
				range = 10,
				cost = 750
			},
			[2] = {
				attack_cooldown = 4,
				damage = 40,
				range = 11,
				cost = 1250
			},
			[3] = {
				attack_cooldown = 4,
				damage = 55,
				range = 12,
				cost = 1500
			},
			[4] = {
				attack_cooldown = 3.5,
				damage = 80,
				range = 12,
				cost = 2500
			},
			[5] = {
				attack_cooldown = 3.5,
				note = "+ Sand Coffin",
				cost = 5000,
				primary_attack = "gaara:coffin",
				range = 15,
				damage = 90
			}
		},
		primary_attack_no_upgrades = "gaara:spikes",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	diavolo = {
		attack_cooldown = 9,
		primary_attack_no_upgrades = "king_crimson:slice",
		range = 10,
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 100,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "diavolo",
		ASSETS = {
			particles = {
				[1] = "king_crimson_blur"
			},
			sfx = {
				[1] = "king_crimson_hit_1",
				[2] = "king_crimson_hit_2_blood",
				[3] = "king_crimson_hit_3_heavy",
				[4] = "erase_time",
				[5] = "kc_ambience",
				[6] = "kc_resume",
				[7] = "time_erase"
			}
		},
		shiny = true,
		animation_set = "default",
		stand = "king_crimson",
		upgrade = {
			[1] = {
				attack_cooldown = 8.5,
				damage = 250,
				range = 11,
				cost = 1300
			},
			[2] = {
				attack_cooldown = 8,
				damage = 300,
				range = 12,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 7.5,
				damage = 500,
				range = 13,
				cost = 2500
			},
			[4] = {
				attack_cooldown = 7.5,
				note = "+ Mortal Blow",
				primary_attack = "king_crimson:back_attack",
				cost = 4500,
				range = 16,
				damage = 700
			},
			[5] = {
				attack_cooldown = 7,
				damage = 900,
				range = 17,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 7,
				damage = 1000,
				range = 18,
				cost = 7500
			},
			[7] = {
				attack_cooldown = 6,
				note = "+ Time Erase",
				active_attack = "kc:time_erase",
				cost = 12500,
				active_attack_stats = {
					attack_cooldown = 120,
					damage = 15
				},
				range = 20,
				damage = 1500
			}
		},
		name = "Diavoro",
		spawn_effects = {
			[1] = {
				id = "summon_stand",
				modifiers = {
					play_sound = true
				}
			}
		},
		cost = 1100,
		spawn_cap = 5,
		cooldown = 10,
		health = 2000
	},
	warhammer_titan = {
		attack_cooldown = 20,
		primary_attack_no_upgrades = "warhammer_titan:slam",
		id = "warhammer_titan",
		range = 14,
		animation_set = "default",
		spawn_effects = {
			[1] = {
				id = "titan_spawn_smoke"
			},
			[2] = {
				id = "play_sfx_unit",
				modifiers = {
					sfx_params = {
						tween_out_time = 0.5
					},
					sfx = "titan_roar_female"
				}
			}
		},
		ASSETS = {
			vfx = {
				[1] = "warhammer_spike"
			},
			particles = {
				[1] = "warhammer_titan_charge_particles"
			},
			sfx = {
				[1] = "steam_hiss",
				[2] = "titan_roar_female",
				[3] = "electric_sparks",
				[4] = "charge_echo",
				[5] = "physical_explosion_debris_fast"
			}
		},
		name = "Warhammer Titan",
		knockback_points = {},
		speed = 5,
		spawn_anim = "titan",
		hybrid_placement = true,
		health = 10000
	},
	arima_evolved = {
		attack_cooldown = 8,
		cost = 1350,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		evolved = {
			from = "arima"
		},
		damage = 74.25,
		upgrade_script = true,
		rarity = "Mythic",
		id = "arima_evolved",
		hybrid_placement = true,
		animation_set = "3dmg",
		ASSETS = {
			vfx = {
				[1] = "ixa_tendril",
				[2] = "ixa_tendril_flipped",
				[3] = "tendril",
				[4] = "eto_shard"
			},
			_new_fx = {
				[1] = "arima"
			},
			particles = {
				[1] = "ixa_rise",
				[2] = "narukami_particles",
				[3] = "owl_particles"
			},
			sfx = {
				[1] = "electric_pulse_hard",
				[2] = "Lightning_Release_3",
				[3] = "electric_charge",
				[4] = "tendril_rise",
				[5] = "electric_slash",
				[6] = "whoosh_weird",
				[7] = "electric_slash_2",
				[8] = "owl_charge"
			}
		},
		shiny = true,
		name = "Ariva (Reaper)",
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 168.75,
				range = 23,
				cost = 2000
			},
			[2] = {
				attack_cooldown = 7.5,
				damage = 270,
				range = 23.5,
				cost = 2200
			},
			[3] = {
				attack_cooldown = 7.5,
				damage = 371.25,
				range = 24,
				cost = 3000
			},
			[4] = {
				attack_cooldown = 7,
				note = "+ Narukami",
				primary_attack = "arima:narukami_attack",
				cost = 5000,
				range = 24.5,
				damage = 506.25000000000006
			},
			[5] = {
				attack_cooldown = 7,
				damage = 708.75,
				range = 25,
				cost = 6000
			},
			[6] = {
				attack_cooldown = 6.5,
				damage = 877.5000000000001,
				range = 26,
				cost = 7250
			},
			[7] = {
				attack_cooldown = 6.5,
				damage = 1080,
				range = 26.5,
				cost = 10000
			},
			[8] = {
				attack_cooldown = 6.5,
				note = "+ Owl",
				primary_attack = "arima:owl_slash",
				cost = 12500,
				range = 35,
				damage = 1890.0000000000002
			},
			[9] = {
				attack_cooldown = 6,
				damage = 2295,
				range = 40,
				cost = 15000
			}
		},
		primary_attack_no_upgrades = "arima:ixa_attack",
		spawn_cap = 4,
		cooldown = 10,
		health = 5000
	},
	armin = {
		cost = 5000,
		range = 30,
		_EFFECT_SCRIPTS = {
			[1] = "titan_shift"
		},
		show_active_attack = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 1000,
		rarity = "Mythic",
		id = "armin",
		hybrid_placement = true,
		ASSETS = {
			vfx = {
				[1] = "armin_colossal_titan",
				[2] = "colossal_titan_nuke"
			},
			sfx = {
				[1] = "electricity_aura",
				[2] = "big_physical_explosion_with_debris",
				[3] = "nuke",
				[4] = "physical_explosion_with_debris",
				[5] = "electric_explosion",
				[6] = "titan_shift_large"
			}
		},
		animation_set = "3dmg",
		shiny = true,
		upgrade = {
			[1] = {
				damage = 1250,
				active_attack_stats = {
					attack_cooldown = 57
				},
				cost = 6500
			},
			[2] = {
				damage = 2000,
				active_attack_stats = {
					attack_cooldown = 55
				},
				cost = 8000
			},
			[3] = {
				damage = 3000,
				active_attack_stats = {
					attack_cooldown = 52
				},
				cost = 10000
			},
			[4] = {
				damage = 4000,
				active_attack_stats = {
					attack_cooldown = 47.5
				},
				cost = 12500
			},
			[5] = {
				damage = 5000,
				active_attack_stats = {
					attack_cooldown = 45
				},
				cost = 15000
			}
		},
		name = "Armein",
		active_attack_stats = {
			attack_cooldown = 60
		},
		active_attack = "armin:titan_shift",
		spawn_cap = 3,
		cooldown = 10,
		health = 2000
	},
	tatara = {
		attack_cooldown = 4,
		primary_attack_no_upgrades = "tatara:kagune",
		range = 8,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 60,
		rarity = "Mythic",
		hybrid_placement = true,
		id = "tatara",
		ASSETS = {
			_new_fx = {
				[1] = "tatara"
			},
			sfx = {
				[1] = "fire_move",
				[2] = "fire_explosion_6",
				[3] = "woosh_long",
				[4] = "fire_cast",
				[5] = "physical_explosion_squeeze",
				[6] = "explosion_fast"
			}
		},
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "tatara"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "tatara_scales",
						amount = 2
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "tatara"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "tatara_scales",
						amount = 2
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			evolve_unit = "tatara_evolved",
			evolve_text = "+10% Damage, +2x Burn Damage, +Scorching Slam"
		},
		animation_set = "default",
		shared_setup_script = "tatara",
		spawn_cap = 4,
		name = "Tarata",
		upgrade = {
			[1] = {
				attack_cooldown = 3.5,
				damage = 100,
				range = 9,
				cost = 1650
			},
			[2] = {
				attack_cooldown = 3,
				damage = 150,
				range = 10,
				cost = 2250
			},
			[3] = {
				attack_cooldown = 7.5,
				note = "+ Pyrokinesis",
				primary_attack = "tatara:flamethrower",
				cost = 3250,
				range = 22.5,
				damage = 325
			},
			[4] = {
				attack_cooldown = 7,
				damage = 425,
				range = 23,
				cost = 4500
			},
			[5] = {
				attack_cooldown = 7,
				damage = 550,
				range = 24,
				cost = 5500
			},
			[6] = {
				attack_cooldown = 7,
				note = "+ Incineration",
				primary_attack = "tatara:flamethrower_2",
				cost = 7000,
				range = 24.5,
				damage = 700
			},
			[7] = {
				attack_cooldown = 6.5,
				damage = 800,
				range = 26,
				cost = 9000
			},
			[8] = {
				attack_cooldown = 6,
				damage = 900,
				range = 27,
				cost = 12000
			}
		},
		health = 100,
		cost = 1300,
		cooldown = 10,
		shiny = true
	},
	titan4 = {
		cost = 1000,
		id = "titan4",
		approach_distance = 15,
		range = 100,
		animation_set = "fast_titan",
		name = "Abnormal Titan",
		knockback_points = {},
		speed = 5,
		hybrid_placement = true,
		cooldown = 10,
		health = 10000
	},
	amon = {
		attack_cooldown = 4,
		upgrade = {
			[1] = {
				attack_cooldown = 4,
				damage = 25,
				range = 13,
				cost = 500
			},
			[2] = {
				attack_cooldown = 3.5,
				damage = 40,
				range = 14,
				cost = 700
			},
			[3] = {
				attack_cooldown = 3.5,
				damage = 50,
				range = 15,
				cost = 850
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Smash",
				cost = 5000,
				primary_attack = "amon:smash_2",
				range = 20,
				damage = 60
			}
		},
		range = 10,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 15,
		rarity = "Rare",
		shiny = true,
		animation_set = "default",
		hybrid_placement = true,
		ASSETS = {
			sfx = {
				[1] = "physical_swing",
				[2] = "Thunder_release_2"
			}
		},
		name = "Aman",
		primary_attack_no_upgrades = "amon:smash_1",
		id = "amon",
		health = 100,
		cooldown = 10,
		cost = 350
	},
	eto = {
		attack_cooldown = 8,
		primary_attack_no_upgrades = "eto:shards",
		range = 21,
		pet_character_model = "eto_pet",
		speed = 15,
		hybrid_placement = true,
		damage = 100,
		ASSETS = {
			vfx = {
				[1] = "eto_shard"
			},
			effect_models = {
				[1] = "eto_jump_land"
			},
			sfx = {
				[1] = "sweeping_beam",
				[2] = "tendril_rise",
				[3] = "eto_laser_charge",
				[4] = "eto_laser",
				[5] = "eto_laser_2",
				[6] = "eto_shards",
				[7] = "eto_screech",
				[8] = "eto_screech2",
				[9] = "physical_explosion_with_debris",
				[10] = "physical_swing",
				[11] = "monster_attack_sound"
			},
			particles = {
				[1] = "eto_spawn"
			},
			_new_fx = {
				[1] = "eto"
			}
		},
		evolve = {
			normal = {
				unit_requirement = {
					[1] = {
						amount = 1,
						unit_id = "eto"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "eto_shards",
						amount = 3
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			shiny = {
				unit_requirement = {
					[1] = {
						shiny = true,
						amount = 1,
						unit_id = "eto"
					}
				},
				item_requirement = {
					[1] = {
						item_id = "eto_shards",
						amount = 3
					},
					[2] = {
						item_id = "coffee",
						amount = 20
					}
				}
			},
			evolve_unit = "eto_evolved",
			evolve_text = "+15% attack, +Laser Augment, +Kakuja Evolution"
		},
		rarity = "Mythic",
		knockback_points = {
			[1] = 0.5
		},
		id = "eto",
		spawn_cap = 3,
		override_hitbox_radius = 8,
		animation_set = "eto",
		health = 100,
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 225,
				range = 22,
				cost = 3500
			},
			[2] = {
				attack_cooldown = 8,
				damage = 350,
				range = 23.5,
				cost = 4500
			},
			[3] = {
				attack_cooldown = 8,
				damage = 500,
				range = 24,
				cost = 5000
			},
			[4] = {
				attack_cooldown = 8,
				note = "+ Kakuja Barrage",
				primary_attack = "eto:jump",
				cost = 6000,
				range = 25,
				damage = 750
			},
			[5] = {
				attack_cooldown = 7.5,
				damage = 900,
				range = 26,
				cost = 7500
			},
			[6] = {
				attack_cooldown = 7,
				damage = 1000,
				range = 27,
				cost = 8500
			},
			[7] = {
				attack_cooldown = 7,
				damage = 1100,
				range = 30,
				cost = 12000
			}
		},
		name = "Eta",
		spawn_effects = {
			[1] = {
				id = "eto_spawn"
			}
		},
		cost = 2500,
		pet_animation_set = "default",
		cooldown = 10,
		shiny = true
	},
	alien_soldier_blue = {
		attack_cooldown = 1.23,
		id = "alien_soldier_blue",
		range = 7,
		animation_set = "default",
		name = "Alien Soldier",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		damage = 5
	},
	speedwagon = {
		attack_cooldown = 0,
		range = 10,
		farm_amount = 200,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 0,
		upgrade_script = "upgrade_speedwagon",
		rarity = "Epic",
		id = "speedwagon",
		hybrid_placement = true,
		override_hitbox_radius = 5,
		animation_set = "default",
		spawn_cap = 3,
		cost = 550,
		name = "Speedcart",
		upgrade = {
			[1] = {
				farm_amount = 500,
				cost = 1000
			},
			[2] = {
				farm_amount = 1000,
				cost = 1750
			},
			[3] = {
				farm_amount = 1750,
				cost = 2500
			},
			[4] = {
				farm_amount = 2500,
				cost = 3000
			}
		},
		end_of_wave = {
			[1] = {
				type = "farm",
				animation = "speedwagon:money",
				effects = {
					[1] = {
						id = "full_body_particle",
						modifiers = {
							particle = "money",
							dont_scale = true
						}
					},
					[2] = {
						id = "play_sfx_unit",
						modifiers = {
							sfx = "farm_money"
						}
					}
				}
			}
		},
		health = 100,
		cooldown = 10,
		shiny = true
	},
	titan2 = {
		cost = 1000,
		id = "titan2",
		approach_distance = 15,
		range = 100,
		animation_set = "default",
		name = "Big Titan",
		knockback_points = {},
		speed = 5,
		hybrid_placement = true,
		cooldown = 10,
		health = 10000
	},
	kakyoin = {
		attack_cooldown = 5,
		cost = 525,
		hill_unit = true,
		range = 15,
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 9,
		rarity = "Epic",
		hybrid_placement = true,
		id = "kakyoin",
		ASSETS = {
			vfx = {
				[1] = "emerald"
			},
			sfx = {
				[1] = "emerald_splash_release",
				[2] = "emerald_splash_hit"
			}
		},
		health = 100,
		animation_set = "default",
		stand = "hierophant_green",
		upgrade = {
			[1] = {
				attack_cooldown = 5,
				damage = 20,
				range = 16,
				cost = 650
			},
			[2] = {
				attack_cooldown = 4.5,
				damage = 35,
				range = 17,
				cost = 1250
			},
			[3] = {
				attack_cooldown = 4.5,
				damage = 55,
				range = 18,
				cost = 1750
			},
			[4] = {
				attack_cooldown = 4,
				damage = 75,
				range = 19,
				cost = 2500
			},
			[5] = {
				attack_cooldown = 4,
				note = "+ 20x Emerald Splash",
				cost = 3500,
				primary_attack = "hierophant_green:splash_2",
				range = 20,
				damage = 80
			}
		},
		name = "Karyoin",
		spawn_effects = {
			[1] = {
				id = "summon_stand",
				modifiers = {
					play_sound = true
				}
			}
		},
		primary_attack_no_upgrades = "hierophant_green:splash",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	aogiri_three = {
		hybrid_placement = true,
		health = 20,
		name = "Aogiri Executive",
		speed = 1,
		id = "aogiri_three",
		buffs = {
			[1] = {
				time = -1,
				name = "healing",
				params = {
					persistent = true,
					percent = 0.02,
					healing_rate = 1
				}
			}
		},
		range = 7,
		animation_set = "default"
	},
	light_eyes = {
		attack_cooldown = 5,
		_COPY_EFFECT_SCRIPTS = "light",
		range = 20,
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		hybrid_placement = true,
		evolved = {
			from = "light"
		},
		damage = 100,
		ASSETS = {
			vfx = {
				[1] = "death_note_ground",
				[2] = "death_note_ground_2",
				[3] = "ryuk:appear",
				[4] = "ryuk:idle",
				[5] = "death_note_soul_nohuman",
				[6] = "soul_beam"
			},
			effect_models = {
				[1] = "ryuk"
			},
			sfx = {
				[1] = "death_note_kill",
				[2] = "death_note_kill_2",
				[3] = "pencil_write",
				[4] = "death_note_heart_attack",
				[5] = "death_note_vo"
			},
			particles = {
				[1] = "light_soul_particles"
			},
			_new_fx = {
				[1] = "light"
			}
		},
		health = 5000,
		rarity = "Mythic",
		cost = 10000,
		id = "light_eyes",
		stand_offset = CFrame.new(0.848754823, 0, -1.51782215, 0.99999994, 0, 0, 0, 1, 0, 0, 0, 0.99999994),
		track_kills = true,
		animation_set = "default",
		show_stand = true,
		stand = "ryuk",
		name = "Kiru (God)",
		active_attack_stats = {
			attack_cooldown = 15,
			damage = 15
		},
		active_attack = "death_note_active",
		spawn_cap = 1,
		cooldown = 10,
		shiny = true
	},
	owl_1 = {
		hybrid_placement = true,
		health = 20,
		name = "Owl",
		spawn_effects = {
			[1] = {
				id = "owl_boss_spawned"
			},
			[2] = {
				id = "zarbon_evolved_spawn"
			}
		},
		id = "owl_1",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	bulma = {
		attack_cooldown = 0,
		range = 5,
		farm_amount = 250,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 0,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Legendary",
		ASSETS = {
			vfx = {
				[1] = "bulma_ship",
				[2] = "capsules_kit"
			},
			sfx = {
				[1] = "scifi_door_open",
				[2] = "scifi_door_close"
			}
		},
		id = "bulma",
		spawn_cap = 1,
		override_hitbox_radius = 6,
		animation_set = "default",
		cost = 800,
		upgrade = {
			[1] = {
				farm_amount = 750,
				cost = 1500
			},
			[2] = {
				farm_amount = 1500,
				cost = 3000
			},
			[3] = {
				farm_amount = 3000,
				cost = 4500
			},
			[4] = {
				farm_amount = 5000,
				cost = 7500
			},
			[5] = {
				farm_amount = 8000,
				cost = 10000
			},
			[6] = {
				farm_amount = 10000,
				cost = 12500
			}
		},
		name = "Bulmy",
		end_of_wave = {
			[1] = {
				effects = {
					[1] = {
						id = "full_body_particle",
						modifiers = {
							particle = "money",
							dont_scale = true
						}
					},
					[2] = {
						id = "bulma_endofwave"
					}
				},
				type = "farm"
			}
		},
		unsellable = true,
		health = 100,
		cooldown = 10,
		shiny = true
	},
	uryu_evolved = {
		attack_cooldown = 6,
		primary_attack_no_upgrades = "uryu:shot",
		hill_unit = true,
		range = 20,
		moving_gui_offset = CFrame.new(1.56324105e-13, -0.5, -1.08000004, -1, 0, -8.74227766e-08, 0, 1, 0, 8.74227766e-08, 0, -1),
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			use_own_model = true,
			from = "uryu"
		},
		damage = 75,
		rarity = "Mythic",
		id = "uryu_evolved",
		hybrid_placement = true,
		animation_set = "uryu",
		ASSETS = {
			_new_fx = {
				[1] = "uryu"
			},
			sfx = {
				[1] = "futuristic_charge_fast",
				[2] = "bow_release",
				[3] = "futuristic_blast4",
				[4] = "shuriken_hit",
				[5] = "pika_shot",
				[6] = "laser_fire",
				[7] = "physical_explosion_laser"
			}
		},
		health = 1000,
		name = "Uru (Antithesis)",
		upgrade = {
			[1] = {
				attack_cooldown = 5.5,
				damage = 125,
				range = 20.5,
				cost = 1500
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 187.5,
				range = 21,
				cost = 2000
			},
			[3] = {
				attack_cooldown = 5,
				damage = 250,
				range = 22,
				cost = 2500
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ Rain of Light",
				cost = 3500,
				primary_attack = "uryu:volley",
				range = 25,
				damage = 312.5
			},
			[5] = {
				attack_cooldown = 4.5,
				damage = 437.5,
				range = 27,
				cost = 5000
			},
			[6] = {
				attack_cooldown = 4.5,
				damage = 562.5,
				range = 30,
				cost = 6500
			},
			[7] = {
				attack_cooldown = 4,
				damage = 687.5,
				range = 35,
				cost = 8000
			},
			[8] = {
				attack_cooldown = 4,
				note = "+ Holy Arrow",
				cost = 9000,
				damage = 750,
				range = 40,
				secondary_attacks = {
					[1] = {
						id = "uryu:beam",
						priority = 0
					}
				}
			},
			[9] = {
				attack_cooldown = 3.5,
				damage = 875,
				range = 45,
				cost = 10000
			}
		},
		cost = 1250,
		crit_chance = 0.25,
		cooldown = 10,
		shiny = true
	},
	jotaro = {
		attack_cooldown = 3,
		cost = 575,
		range = 12,
		_EFFECT_SCRIPTS = {
			[1] = "star_platinum_ts"
		},
		stand_requires_humanoid = true,
		knockback_points = {
			[1] = 0.5
		},
		speed = 150,
		damage = 22,
		rarity = "Epic",
		hybrid_placement = true,
		id = "jotaro",
		ASSETS = {
			vfx = {
				[1] = "star_platinum_ts"
			},
			sfx = {
				[1] = "time_stop_one",
				[2] = "jotaro_ora",
				[3] = "jotaro_vo",
				[4] = "the_world_light",
				[5] = "the_world_heavy_physical"
			}
		},
		shiny = true,
		animation_set = "default",
		stand = "star_platinum",
		upgrade = {
			[1] = {
				attack_cooldown = 3,
				damage = 45,
				range = 12,
				cost = 650
			},
			[2] = {
				attack_cooldown = 3,
				damage = 70,
				range = 13,
				cost = 750
			},
			[3] = {
				attack_cooldown = 2.5,
				damage = 95,
				range = 13,
				cost = 1250
			},
			[4] = {
				attack_cooldown = 2.5,
				note = "+ Timestop",
				cost = 2500,
				active_attack_stats = {
					attack_cooldown = 40,
					damage = 0
				},
				active_attack = "star_platinum_ts",
				range = 15,
				damage = 150
			},
			[5] = {
				attack_cooldown = 2.5,
				cost = 3500,
				active_attack_stats = {
					attack_cooldown = 20,
					damage = 0
				},
				range = 20,
				damage = 180
			}
		},
		name = "Jokujo",
		spawn_effects = {
			[1] = {
				id = "summon_stand",
				modifiers = {
					play_sound = true
				}
			}
		},
		primary_attack_no_upgrades = "stand_barrage_heavy_end",
		spawn_cap = 3,
		cooldown = 10,
		health = 2000
	},
	aot_human_2 = {
		hybrid_placement = true,
		name = "Paradis Military Traitor",
		health = 10000,
		id = "aot_human_2",
		speed = 5,
		range = 100,
		animation_set = "3dmg"
	},
	deidara = {
		attack_cooldown = 4,
		primary_attack_no_upgrades = "deidara:create_unit",
		pre_death_fx = {
			[1] = {
				id = "deidara_c0"
			}
		},
		override_hit_animations = true,
		id = "deidara",
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "zetsu_spawn_unit",
					modifiers = {
						death_effect = true
					}
				}
			},
			amount = 8,
			from_waves = true,
			delay = 0.5,
			units = {
				[1] = {
					diff_scale = 0.5,
					unit = "normal"
				},
				[2] = {
					diff_scale = 0.4,
					unit = "strong"
				},
				[3] = {
					diff_scale = 0.25,
					unit = "tank"
				},
				[4] = {
					diff_scale = 0.25,
					unit = "quick"
				},
				[5] = {
					diff_scale = 0.5,
					unit = "miniboss"
				},
				[6] = {
					diff_scale = 0.5,
					unit = "miniboss2"
				}
			}
		},
		range = 50,
		animation_set = "deidara",
		max_spawn_units = 6,
		upgrade_script = true,
		name = "Daedora",
		ASSETS = {
			vfx = {
				[1] = "deidara_clone_orb",
				[2] = "zetsu_spawn_ball"
			},
			effect_models = {
				[1] = "deidara_c0"
			},
			sfx = {
				[1] = "plant_grow",
				[2] = "katsu",
				[3] = "woosh_throw_heavy",
				[4] = "liquid_to_form_something",
				[5] = "nuke",
				[6] = "charge_echo2",
				[7] = "gura_release",
				[8] = "physical_explosion"
			},
			particles = {
				[1] = "deidara_c0"
			},
			projectiles = {
				[1] = "deidara_bird"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		death_attack = "deidara:c0"
	},
	big_ant = {
		id = "big_ant",
		range = 7,
		animation_set = "default",
		_EFFECT_SCRIPTS = {
			[1] = "ant_egg_spawn"
		},
		name = "Massive Ant",
		ASSETS = {
			particles = {
				[1] = "ant_egg_spawn"
			},
			sfx = {
				[1] = "gore_explode2"
			}
		},
		speed = 1,
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "ant_egg_spawn"
				}
			},
			amount = 1,
			from_waves = true,
			delay = 0,
			units = {
				[1] = {
					unit = "egg"
				}
			}
		},
		hybrid_placement = true,
		health = 20
	},
	kamanue = {
		hybrid_placement = true,
		name = "Lower Demon",
		health = 20,
		id = "kamanue",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	owl_human = {
		transform = {
			health_ratio = 0.5,
			effects = {
				1 = {
					id = "owl_transform",
					modifiers = {
						stage = "charge"
					}
				},
				2 = {
					id = "owl_transform",
					modifiers = {
						stage = "fire"
					}
				}
			},
			unit = "owl_1"
		},
		id = "owl_human",
		range = 7,
		animation_set = "default",
		name = "Owl (Human)",
		ASSETS = {
			_new_fx = {
				[1] = "owl"
			},
			particles = {
				[1] = "muzan_spawn_particles",
				[2] = "zarbon_evolved_transform",
				[3] = "zarbon_evolved_attack",
				[4] = "zarbon_transform"
			},
			sfx = {
				[1] = "electricity_aura_short",
				[2] = "electric_explosion"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	kite_evolved_lethal = {
		attack_cooldown = 8,
		cost = 4000,
		range = 22,
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		evolved = {
			from = "kite"
		},
		damage = 375,
		upgrade_script = true,
		hybrid_placement = true,
		rarity = "Secret",
		ASSETS = {
			_new_fx = {
				[1] = "kite"
			},
			sfx = {
				[1] = "ding",
				[2] = "boost_arcade",
				[3] = "SwordRing",
				[4] = "slower_slash",
				[5] = "wind_blow",
				[6] = "machine_gun",
				[7] = "kite_charge",
				[8] = "kite_pulse",
				[9] = "pulse1",
				[10] = "magic_blast"
			}
		},
		id = "kite_evolved_lethal",
		health = 1000,
		upgrade = {
			[1] = {
				attack_cooldown = 8,
				damage = 900,
				range = 25,
				cost = 8000
			},
			[2] = {
				attack_cooldown = 8,
				damage = 1800,
				range = 27,
				cost = 12000
			},
			[3] = {
				attack_cooldown = 8,
				damage = 2625,
				range = 29,
				cost = 15000
			},
			[4] = {
				attack_cooldown = 8,
				damage = 3375,
				range = 30,
				cost = 20000
			}
		},
		animation_set = "default",
		limited = {},
		_OVERRIDE_UNIT_SCRIPT = "script_kite",
		name = "Kit (Lethal)",
		spawn_script = true,
		spawn_cap = 3,
		cooldown = 10,
		shiny = true
	},
	deku = {
		attack_cooldown = 7,
		cost = 400,
		range = 15,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 3.5,
		rarity = "Rare",
		id = "deku",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			effect_models = {
				[1] = "deku_smash"
			},
			particles = {
				[1] = "deku_lightning"
			},
			sfx = {
				[1] = "deku_charge",
				[2] = "deku_punch"
			}
		},
		shiny = true,
		name = "Dezu",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 8,
				range = 15,
				cost = 550
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 14,
				range = 16,
				cost = 750
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 20,
				range = 16,
				cost = 900
			},
			[4] = {
				attack_cooldown = 6,
				note = "+ Delaware Smash",
				cost = 1500,
				primary_attack = "delaware_smash",
				range = 20,
				damage = 23
			},
			[5] = {
				attack_cooldown = 6,
				damage = 35,
				range = 22,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "deku:punch_1",
		spawn_cap = 5,
		cooldown = 10,
		health = 2000
	},
	naruto_minion_1 = {
		hybrid_placement = true,
		name = "Village Traitor",
		health = 20,
		id = "naruto_minion_1",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	titan6 = {
		cost = 1000,
		id = "titan6",
		approach_distance = 15,
		range = 100,
		animation_set = "default",
		hybrid_placement = true,
		ASSETS = {
			sfx = {
				[1] = "Thunder_explosion"
			}
		},
		name = "Massive Titan",
		knockback_points = {},
		speed = 5,
		death_spawn = {
			spawn_unit_fx = {
				[1] = {
					id = "titan_small_minion_spawn"
				}
			},
			amount = 3,
			from_waves = true,
			delay = 0.2,
			units = {
				[1] = {
					diff_scale = 0.5,
					unit = "normal"
				},
				[2] = {
					diff_scale = 0.25,
					unit = "strong"
				},
				[3] = {
					diff_scale = 0.15,
					unit = "tank"
				},
				[4] = {
					diff_scale = 0.15,
					unit = "quick"
				}
			}
		},
		cooldown = 10,
		health = 10000
	},
	marine_five = {
		hybrid_placement = true,
		name = "Marine Captain",
		health = 20,
		id = "marine_five",
		speed = 1,
		range = 7,
		animation_set = "default"
	},
	kuma = {
		id = "kuma",
		range = 7,
		animation_set = "default",
		barrier_destroy_script = true,
		name = "Kumo",
		ASSETS = {
			particles = {
				[1] = "kuma_explode"
			},
			sfx = {
				[1] = "electric_explosion2"
			}
		},
		speed = 1,
		health = 20,
		hybrid_placement = true,
		barrier = {
			health_ratio = 0.5,
			buffs = {
				[1] = {
					params = {
						reduction = 0.25,
						persistent = true
					},
					name = "damage_reduction",
					damage = 1
				}
			}
		}
	},
	uraraka = {
		attack_cooldown = 6.5,
		cost = 400,
		hill_unit = true,
		range = 20,
		knockback_points = {
			[1] = 3
		},
		speed = 1,
		damage = 2.5,
		rarity = "Rare",
		id = "uraraka",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			effect_models = {
				[1] = "rock_throw"
			},
			sfx = {
				[1] = "physical_explosion_debris_fast",
				[2] = "charge_long",
				[3] = "futuristic_charge_fast"
			},
			projectiles = {
				[1] = "uraraka_rock",
				[2] = "uraraka_rock_2"
			}
		},
		health = 100,
		name = "Urakara",
		upgrade = {
			[1] = {
				attack_cooldown = 6,
				damage = 5,
				range = 21,
				cost = 550
			},
			[2] = {
				attack_cooldown = 5.5,
				damage = 8,
				range = 22,
				cost = 750
			},
			[3] = {
				attack_cooldown = 5.5,
				damage = 12,
				range = 23,
				cost = 900
			},
			[4] = {
				attack_cooldown = 5,
				note = "+ 2 Gravity Rocks",
				primary_attack = "uraraka:rock_throw",
				cost = 1500,
				range = 24,
				damage = 18
			},
			[5] = {
				attack_cooldown = 5,
				damage = 28,
				range = 25,
				cost = 2500
			}
		},
		primary_attack_no_upgrades = "uraraka:rock_throw_single",
		spawn_cap = 5,
		cooldown = 10,
		shiny = true
	},
	test_unit = {
		cost = 1,
		id = "test_unit",
		range = 7,
		animation_set = "default",
		attacks = {
			melee_basic_1:1 = {
				damage = 7,
				cooldown = 2.23,
				weight = 1
			}
		},
		name = "Test Unit",
		knockback_points = {
			[1] = 0.5
		},
		speed = 1,
		hybrid_placement = true,
		cooldown = 0,
		health = 200
	},
	blackbeard = {
		attack_cooldown = 8,
		cost = 850,
		range = 13,
		knockback_points = {
			[1] = 0.5
		},
		speed = 15,
		damage = 30,
		upgrade_script = true,
		rarity = "Legendary",
		id = "blackbeard",
		hybrid_placement = true,
		animation_set = "default",
		ASSETS = {
			vfx = {
				[1] = "black_hole"
			},
			particles = {
				[1] = "blackbeard_charge",
				[2] = "liberation"
			},
			sfx = {
				[1] = "Gravity_SFX",
				[2] = "black_hole",
				[3] = "black_hole2"
			}
		},
		shiny = true,
		name = "Blackhair",
		upgrade = {
			[1] = {
				attack_cooldown = 7,
				damage = 60,
				range = 14,
				cost = 1250
			},
			[2] = {
				attack_cooldown = 6.5,
				damage = 80,
				range = 15,
				cost = 1500
			},
			[3] = {
				attack_cooldown = 6.5,
				damage = 125,
				range = 16,
				cost = 2250
			},
			[4] = {
				attack_cooldown = 6,
				note = "+ Black Hole",
				primary_attack = "blackbeard:black_hole",
				cost = 5000,
				range = 16,
				damage = 150
			},
			[5] = {
				attack_cooldown = 6,
				damage = 200,
				range = 16.5,
				cost = 6500
			},
			[6] = {
				attack_cooldown = 5.5,
				damage = 200,
				range = 17,
				cost = 7000
			},
			[7] = {
				attack_cooldown = 5,
				damage = 250,
				range = 17.5,
				cost = 8000
			}
		},
		primary_attack_no_upgrades = "blackbeard:liberation",
		spawn_cap = 5,
		cooldown = 10,
		health = 2000
	},
	itachi_boss = {
		attack_cooldown = 15,
		primary_attack_no_upgrades = "itachi_boss:start_teleport",
		id = "itachi_boss",
		range = 7,
		animation_set = "default",
		name = "Itochi",
		ASSETS = {
			particles = {
				[1] = "itachi_teleport"
			},
			sfx = {
				[1] = "flock_birds"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	},
	titan3 = {
		cost = 1000,
		id = "titan3",
		approach_distance = 15,
		range = 100,
		animation_set = "abnormal_titan",
		name = "Crawling Titan",
		knockback_points = {},
		speed = 5,
		hybrid_placement = true,
		cooldown = 10,
		health = 10000
	},
	test_dummy_2 = {
		id = "test_dummy_2",
		approach_distance = 5,
		range = 100,
		animation_set = "default",
		attacks = {
			melee_basic_1:1 = {
				damage = 40,
				cooldown = 1.23,
				weight = 1
			}
		},
		name = "Test Dummy 2",
		knockback_points = {
			[1] = 0.5
		},
		speed = 10,
		hybrid_placement = true,
		health = 100000
	},
	sasori = {
		transform = {
			health_ratio = 0.8,
			transformed_speed_ratio = 0.3333333333333333,
			unit = "sasori_clone"
		},
		id = "sasori",
		range = 7,
		animation_set = "crawler",
		name = "Sashora",
		ASSETS = {
			vfx = {
				[1] = "sasori_puppet_strings",
				[2] = "sasori_strings"
			},
			particles = {
				[1] = "sasori_fire"
			},
			sfx = {
				[1] = "puppet_spawn",
				[2] = "sasori_vo",
				[3] = "sasori_spawn",
				[4] = "naruto_poof"
			}
		},
		speed = 1,
		hybrid_placement = true,
		health = 20
	}
}