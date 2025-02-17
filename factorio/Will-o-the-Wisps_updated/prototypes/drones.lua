local conf = require('config')

local utils = require('libs/utils')
local beam_ammo_cat = -- breaking change in factorio-1.1
	utils.version_to_num(mods.base) >= utils.version_to_num('1.1.0')
	and 'beam' or 'combat-robot-beam'

data:extend{{

	type = 'combat-robot',
	name = 'wisp-drone-blue',
	icon = '__Will-o-the-Wisps_updated__/graphics/icons/wisp-drone-blue.png',
	icon_size = 32,
	flags = {'placeable-player', 'player-creation', 'placeable-off-grid', 'not-on-map', 'not-repairable'},
	resistances = {
		{type='fire', percent=50},
		{type='acid', percent=90},
		{type='corrosion', percent=95} },
	order = 'z[combatrobot]',
	subgroup='capsule',
	max_health = 20,
	alert_when_damaged = false,
	collision_box = {{0, 0}, {0, 0}},
	selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
	distance_per_frame = 0.13,
	time_to_live = conf.wisp_drone_ttl, -- 3 hours
	follows_player = true,
	friction = 0.005,
	range_from_player = 8.0,
	speed = 0.01,

	attack_parameters = {
		type = 'beam',
		ammo_category = beam_ammo_cat,
		cooldown = 20,
		range = 10,
		damage_modifier = 0.2,
		-- animation =
		ammo_type = {
			category = beam_ammo_cat,
			action = {
				type = 'direct',
				action_delivery = {
					type = 'beam',
					beam = 'wisp-beam-blue',
					max_length = 12,
					duration = 100,
					source_offset = {0.0, 0.0} } } } },

	idle = {
		filename = '__Will-o-the-Wisps_updated__/graphics/entity/wisps/wisp-drone-blue.png',
		priority = 'high',
		width = 158,
		height = 158,
		frame_count = 1,
		direction_count = 8,
		line_length = 8,
		animation_speed = 0.7,
		scale = 0.3
	},
	in_motion = {
		filename = '__Will-o-the-Wisps_updated__/graphics/entity/wisps/wisp-drone-blue.png',
		priority = 'high',
		width = 158,
		height = 158,
		frame_count = 1,
		direction_count = 8,
		line_length = 8,
		animation_speed = 0.7,
		scale = 0.3
	},

	-- Floating light casts no shadow
	shadow_idle = {
		filename = '__Will-o-the-Wisps_updated__/graphics/null.png',
		priority = 'high',
		width = 1,
		height = 1,
		frame_count = 1,
		direction_count = 1,
		shift = {0, 0}
	},
	shadow_in_motion = {
		filename = '__Will-o-the-Wisps_updated__/graphics/null.png',
		priority = 'high',
		width = 1,
		height = 1,
		frame_count = 1,
		direction_count = 1,
		shift = {0, 0}
	},

}}

data:extend{{
	type = 'explosion',
	name = 'wisp-drone-blue-death',
	flags = {'not-on-map', 'placeable-off-grid'},
	animations = {
		{ filename = '__Will-o-the-Wisps_updated__/graphics/entity/wisps/wisp-drone-blue-death.png',
			priority = 'high',
			width = 158,
			height = 158,
			frame_count = 6,
			animation_speed = 0.06,
			shift = {0, 0} } },
	rotate = false,
	light = {intensity=0.4, size=45, color={r=0, g=1.0, b=0.95, a=0.7}} }}


data:extend{

	-- ----- Projectile animation makes it hard to find entity from on_player_used_capsule event
	-- { type = 'projectile',
	-- 	name = 'wisp-drone-blue-capsule',
	-- 	flags = {'not-on-map'},
	-- 	acceleration = 0.005,
	-- 	action = {
	-- 		type = 'direct',
	-- 		action_delivery = {
	-- 			type = 'instant',
	-- 			target_effects = {
	-- 				{ type = 'create-entity',
	-- 					show_in_tooltip = true,
	-- 					entity_name = 'wisp-drone-blue' } } } },
	-- 	light = {intensity = 0.5, size = 4},
	-- 	enable_drawing_with_mask = true,
	-- 	animation = {
	-- 		layers = {
	-- 			{ filename = '__base__/graphics/entity/combat-robot-capsule/defender-capsule.png',
	-- 				flags = { 'no-crop' },
	-- 				frame_count = 1,
	-- 				width = 28,
	-- 				height = 20,
	-- 				priority = 'high' },
	-- 			{ filename = '__base__/graphics/entity/combat-robot-capsule/defender-capsule-mask.png',
	-- 				flags = { 'no-crop' },
	-- 				frame_count = 1,
	-- 				width = 28,
	-- 				height = 20,
	-- 				priority = 'high',
	-- 				apply_runtime_tint = true },
	-- 		},
	-- 	},
	-- 	shadow = {
	-- 		filename = '__base__/graphics/entity/combat-robot-capsule/defender-capsule-shadow.png',
	-- 		flags = { 'no-crop' },
	-- 		frame_count = 1,
	-- 		width = 26,
	-- 		height = 20,
	-- 		priority = 'high' },
	-- 	smoke = {{
	-- 		name = 'smoke-fast',
	-- 		deviation = {0.15, 0.15},
	-- 		frequency = 1,
	-- 		position = {0, 0},
	-- 		starting_frame = 3,
	-- 		starting_frame_deviation = 5,
	-- 		starting_frame_speed_deviation = 5 }} },

	{ type = 'capsule',
		name = 'wisp-drone-blue-capsule',
		icon = '__Will-o-the-Wisps_updated__/graphics/icons/wisp-drone-blue.png',
		icon_size = 32,
		subgroup = 'capsule',
		order = 'c[wisp-drone-blue-capsule]',
		stack_size = 100,
		capsule_action = {
			type = 'throw',
			attack_parameters = {
				type = 'projectile',
				ammo_category = 'capsule',
				cooldown = 30,
				projectile_creation_distance = 0.6,
				range = 5, -- not really thrown, but placed
				ammo_type = {
					category = 'capsule',
					target_type = 'position',
					action = {
						type = 'direct',
						action_delivery = {
							type = 'instant',
							target_effects = {
								{ type = 'create-entity',
									show_in_tooltip = true,
									entity_name = 'wisp-drone-blue',
									offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}} } } } } } } } },

							-- type = 'projectile',
							-- projectile = 'wisp-drone-blue-capsule',
							-- starting_speed = 0.3 } } } } } },

}
