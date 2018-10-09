--spiral troopers-- mewmew wrote this -- inspired from kyte

local event = require 'utils.event'
require "maps.tools.map_pregen"
local map_functions = require "maps.tools.map_functions"

local function shuffle(tbl)
	local size = #tbl
		for i = size, 1, -1 do
			local rand = math.random(size)
			tbl[i], tbl[rand] = tbl[rand], tbl[i]
		end
	return tbl
end

local function treasure_chest(position, surface)
	local math_random = math.random
	local chest_raffle = {}
	local chest_loot = {					
		{{name = "submachine-gun", count = math_random(1,3)}, weight = 3, evolution_min = 0.0, evolution_max = 0.1},		
		{{name = "slowdown-capsule", count = math_random(16,32)}, weight = 1, evolution_min = 0.0, evolution_max = 1},
		{{name = "poison-capsule", count = math_random(16,32)}, weight = 3, evolution_min = 0.3, evolution_max = 1},		
		{{name = "uranium-cannon-shell", count = math_random(16,32)}, weight = 5, evolution_min = 0.6, evolution_max = 1},
		{{name = "cannon-shell", count = math_random(16,32)}, weight = 5, evolution_min = 0.4, evolution_max = 0.7},
		{{name = "explosive-uranium-cannon-shell", count = math_random(16,32)}, weight = 5, evolution_min = 0.6, evolution_max = 1},
		{{name = "explosive-cannon-shell", count = math_random(16,32)}, weight = 5, evolution_min = 0.4, evolution_max = 0.8},
		{{name = "shotgun", count = 1}, weight = 2, evolution_min = 0.0, evolution_max = 0.2},
		{{name = "shotgun-shell", count = math_random(16,32)}, weight = 5, evolution_min = 0.0, evolution_max = 0.2},
		{{name = "combat-shotgun", count = 1}, weight = 10, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "piercing-shotgun-shell", count = math_random(16,32)}, weight = 10, evolution_min = 0.2, evolution_max = 1},
		{{name = "flamethrower", count = 1}, weight = 3, evolution_min = 0.3, evolution_max = 0.6},
		{{name = "flamethrower-ammo", count = math_random(16,32)}, weight = 5, evolution_min = 0.3, evolution_max = 1},
		{{name = "rocket-launcher", count = 1}, weight = 5, evolution_min = 0.2, evolution_max = 0.6},
		{{name = "rocket", count = math_random(16,32)}, weight = 10, evolution_min = 0.2, evolution_max = 0.7},		
		{{name = "explosive-rocket", count = math_random(16,32)}, weight = 10, evolution_min = 0.3, evolution_max = 1},
		{{name = "land-mine", count = math_random(8,16)}, weight = 10, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "grenade", count = math_random(8,16)}, weight = 10, evolution_min = 0.0, evolution_max = 0.5},
		{{name = "cluster-grenade", count = math_random(8,16)}, weight = 5, evolution_min = 0.4, evolution_max = 1},
		{{name = "firearm-magazine", count = math_random(32,128)}, weight = 10, evolution_min = 0, evolution_max = 0.3},
		{{name = "piercing-rounds-magazine", count = math_random(32,128)}, weight = 10, evolution_min = 0.1, evolution_max = 0.8},
		{{name = "uranium-rounds-magazine", count = math_random(32,128)}, weight = 10, evolution_min = 0.5, evolution_max = 1},
		{{name = "railgun", count = 1}, weight = 1, evolution_min = 0.2, evolution_max = 1},
		{{name = "railgun-dart", count = math_random(16,32)}, weight = 3, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "defender-capsule", count = math_random(8,16)}, weight = 10, evolution_min = 0.0, evolution_max = 0.7},
		{{name = "distractor-capsule", count = math_random(8,16)}, weight = 10, evolution_min = 0.2, evolution_max = 1},
		{{name = "destroyer-capsule", count = math_random(8,16)}, weight = 10, evolution_min = 0.3, evolution_max = 1},
		{{name = "atomic-bomb", count = math_random(8,16)}, weight = 1, evolution_min = 0.3, evolution_max = 1},		
		{{name = "light-armor", count = 1}, weight = 3, evolution_min = 0, evolution_max = 0.1},		
		{{name = "heavy-armor", count = 1}, weight = 3, evolution_min = 0.1, evolution_max = 0.3},
		{{name = "modular-armor", count = 1}, weight = 2, evolution_min = 0.2, evolution_max = 0.6},
		{{name = "power-armor", count = 1}, weight = 2, evolution_min = 0.4, evolution_max = 1},
		{{name = "power-armor-mk2", count = 1}, weight = 1, evolution_min = 0.8, evolution_max = 1},
		{{name = "battery-equipment", count = 1}, weight = 2, evolution_min = 0.3, evolution_max = 0.7},
		{{name = "battery-mk2-equipment", count = 1}, weight = 2, evolution_min = 0.6, evolution_max = 1},
		{{name = "belt-immunity-equipment", count = 1}, weight = 1, evolution_min = 0.3, evolution_max = 1},
		{{name = "solar-panel-equipment", count = math_random(1,4)}, weight = 5, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "discharge-defense-equipment", count = 1}, weight = 1, evolution_min = 0.5, evolution_max = 0.8},
		{{name = "energy-shield-equipment", count = math_random(1,2)}, weight = 2, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "energy-shield-mk2-equipment", count = 1}, weight = 2, evolution_min = 0.7, evolution_max = 1},
		{{name = "exoskeleton-equipment", count = 1}, weight = 1, evolution_min = 0.3, evolution_max = 1},
		{{name = "fusion-reactor-equipment", count = 1}, weight = 1, evolution_min = 0.5, evolution_max = 1},
		{{name = "night-vision-equipment", count = 1}, weight = 1, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "personal-laser-defense-equipment", count = 1}, weight = 2, evolution_min = 0.4, evolution_max = 1},
		{{name = "exoskeleton-equipment", count = 1}, weight = 1, evolution_min = 0.3, evolution_max = 1},
								
		{{name = "iron-gear-wheel", count = math_random(80,100)}, weight = 3, evolution_min = 0.0, evolution_max = 0.3},
		{{name = "copper-cable", count = math_random(100,200)}, weight = 3, evolution_min = 0.0, evolution_max = 0.3},
		{{name = "engine-unit", count = math_random(16,32)}, weight = 2, evolution_min = 0.1, evolution_max = 0.5},
		{{name = "electric-engine-unit", count = math_random(16,32)}, weight = 2, evolution_min = 0.4, evolution_max = 0.8},
		{{name = "battery", count = math_random(100,200)}, weight = 2, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "advanced-circuit", count = math_random(100,200)}, weight = 3, evolution_min = 0.4, evolution_max = 1},
		{{name = "electronic-circuit", count = math_random(100,200)}, weight = 3, evolution_min = 0.0, evolution_max = 0.4},
		{{name = "processing-unit", count = math_random(100,200)}, weight = 3, evolution_min = 0.7, evolution_max = 1},
		{{name = "explosives", count = math_random(25,50)}, weight = 1, evolution_min = 0.2, evolution_max = 0.6},
		{{name = "lubricant-barrel", count = math_random(4,10)}, weight = 1, evolution_min = 0.3, evolution_max = 0.5},
		{{name = "rocket-fuel", count = math_random(4,10)}, weight = 2, evolution_min = 0.3, evolution_max = 0.7},
		--{{name = "computer", count = 1}, weight = 2, evolution_min = 0, evolution_max = 1},
		{{name = "steel-plate", count = math_random(50,100)}, weight = 2, evolution_min = 0.1, evolution_max = 0.3},
		{{name = "nuclear-fuel", count = 1}, weight = 2, evolution_min = 0.7, evolution_max = 1},
				
		{{name = "burner-inserter", count = math_random(16,32)}, weight = 3, evolution_min = 0.0, evolution_max = 0.1},
		{{name = "inserter", count = math_random(16,32)}, weight = 3, evolution_min = 0.0, evolution_max = 0.4},
		{{name = "long-handed-inserter", count = math_random(16,32)}, weight = 3, evolution_min = 0.0, evolution_max = 0.4},		
		{{name = "fast-inserter", count = math_random(16,32)}, weight = 3, evolution_min = 0.1, evolution_max = 1},
		{{name = "filter-inserter", count = math_random(16,32)}, weight = 1, evolution_min = 0.2, evolution_max = 1},		
		{{name = "stack-filter-inserter", count = math_random(4,8)}, weight = 1, evolution_min = 0.4, evolution_max = 1},
		{{name = "stack-inserter", count = math_random(4,8)}, weight = 3, evolution_min = 0.3, evolution_max = 1},				
		{{name = "small-electric-pole", count = math_random(8,16)}, weight = 3, evolution_min = 0.0, evolution_max = 0.3},
		{{name = "medium-electric-pole", count = math_random(8,16)}, weight = 3, evolution_min = 0.2, evolution_max = 1},
		{{name = "big-electric-pole", count = math_random(8,16)}, weight = 3, evolution_min = 0.3, evolution_max = 1},
		{{name = "substation", count = math_random(4,8)}, weight = 3, evolution_min = 0.5, evolution_max = 1},
		{{name = "wooden-chest", count = math_random(8,16)}, weight = 3, evolution_min = 0.0, evolution_max = 0.2},
		{{name = "iron-chest", count = math_random(8,16)}, weight = 3, evolution_min = 0.1, evolution_max = 0.4},
		{{name = "steel-chest", count = math_random(8,16)}, weight = 3, evolution_min = 0.3, evolution_max = 1},		
		{{name = "small-lamp", count = math_random(8,16)}, weight = 3, evolution_min = 0.1, evolution_max = 0.3},
		{{name = "rail", count = math_random(50,100)}, weight = 3, evolution_min = 0.1, evolution_max = 0.6},
		{{name = "assembling-machine-1", count = math_random(2,4)}, weight = 3, evolution_min = 0.0, evolution_max = 0.3},
		{{name = "assembling-machine-2", count = math_random(2,4)}, weight = 3, evolution_min = 0.2, evolution_max = 0.8},
		{{name = "assembling-machine-3", count = math_random(2,4)}, weight = 3, evolution_min = 0.5, evolution_max = 1},
		{{name = "accumulator", count = math_random(4,8)}, weight = 3, evolution_min = 0.4, evolution_max = 1},
		{{name = "offshore-pump", count = math_random(2,4)}, weight = 2, evolution_min = 0.0, evolution_max = 0.1},
		{{name = "beacon", count = math_random(2,4)}, weight = 3, evolution_min = 0.7, evolution_max = 1},
		{{name = "boiler", count = math_random(4,8)}, weight = 3, evolution_min = 0.0, evolution_max = 0.3},
		{{name = "steam-engine", count = math_random(4,8)}, weight = 3, evolution_min = 0.0, evolution_max = 0.5},
		{{name = "steam-turbine", count = math_random(2,4)}, weight = 2, evolution_min = 0.5, evolution_max = 1},
		{{name = "nuclear-reactor", count = 1}, weight = 1, evolution_min = 0.5, evolution_max = 1},
		{{name = "centrifuge", count = math_random(1,2)}, weight = 2, evolution_min = 0.5, evolution_max = 1},
		{{name = "heat-pipe", count = math_random(8,16)}, weight = 2, evolution_min = 0.5, evolution_max = 1},
		{{name = "heat-exchanger", count = math_random(4,8)}, weight = 2, evolution_min = 0.5, evolution_max = 1},
		{{name = "arithmetic-combinator", count = math_random(25,50)}, weight = 1, evolution_min = 0.1, evolution_max = 1},
		{{name = "constant-combinator", count = math_random(25,50)}, weight = 1, evolution_min = 0.1, evolution_max = 1},
		{{name = "decider-combinator", count = math_random(25,50)}, weight = 1, evolution_min = 0.1, evolution_max = 1},
		{{name = "power-switch", count = math_random(8,16)}, weight = 1, evolution_min = 0.1, evolution_max = 1},		
		{{name = "programmable-speaker", count = math_random(8,16)}, weight = 1, evolution_min = 0.1, evolution_max = 1},
		{{name = "green-wire", count = math_random(100,200)}, weight = 1, evolution_min = 0.1, evolution_max = 1},
		{{name = "red-wire", count = math_random(100,200)}, weight = 1, evolution_min = 0.1, evolution_max = 1},
		{{name = "chemical-plant", count = math_random(2,4)}, weight = 3, evolution_min = 0.3, evolution_max = 1},
		{{name = "burner-mining-drill", count = math_random(8,16)}, weight = 3, evolution_min = 0.0, evolution_max = 0.2},
		{{name = "electric-mining-drill", count = math_random(4,8)}, weight = 3, evolution_min = 0.2, evolution_max = 0.6},		
		{{name = "express-transport-belt", count = math_random(50,100)}, weight = 3, evolution_min = 0.5, evolution_max = 1},
		{{name = "express-underground-belt", count = math_random(4,16)}, weight = 3, evolution_min = 0.5, evolution_max = 1},		
		{{name = "express-splitter", count = math_random(8,16)}, weight = 3, evolution_min = 0.5, evolution_max = 1},
		{{name = "fast-transport-belt", count = math_random(50,100)}, weight = 3, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "fast-underground-belt", count = math_random(4,16)}, weight = 3, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "fast-splitter", count = math_random(8,16)}, weight = 3, evolution_min = 0.2, evolution_max = 0.3},
		{{name = "transport-belt", count = math_random(50,100)}, weight = 3, evolution_min = 0, evolution_max = 0.3},
		{{name = "underground-belt", count = math_random(4,16)}, weight = 3, evolution_min = 0, evolution_max = 0.3},
		{{name = "splitter", count = math_random(8,16)}, weight = 3, evolution_min = 0, evolution_max = 0.3},		
		{{name = "oil-refinery", count = math_random(1,2)}, weight = 2, evolution_min = 0.3, evolution_max = 1},
		{{name = "pipe", count = math_random(40,50)}, weight = 3, evolution_min = 0.0, evolution_max = 0.3},
		{{name = "pipe-to-ground", count = math_random(25,50)}, weight = 1, evolution_min = 0.2, evolution_max = 0.5},
		{{name = "pumpjack", count = math_random(2,4)}, weight = 1, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "pump", count = math_random(2,4)}, weight = 1, evolution_min = 0.3, evolution_max = 0.8},
		{{name = "solar-panel", count = math_random(4,8)}, weight = 3, evolution_min = 0.4, evolution_max = 0.9},
		{{name = "electric-furnace", count = math_random(2,4)}, weight = 3, evolution_min = 0.5, evolution_max = 1},
		{{name = "steel-furnace", count = math_random(4,8)}, weight = 3, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "stone-furnace", count = math_random(8,16)}, weight = 3, evolution_min = 0.0, evolution_max = 0.1},		
		{{name = "radar", count = math_random(1,2)}, weight = 1, evolution_min = 0.1, evolution_max = 0.3},
		{{name = "rail-signal", count = math_random(8,16)}, weight = 2, evolution_min = 0.2, evolution_max = 0.8},
		{{name = "rail-chain-signal", count = math_random(8,16)}, weight = 2, evolution_min = 0.2, evolution_max = 0.8},		
		{{name = "stone-wall", count = math_random(50,100)}, weight = 1, evolution_min = 0.1, evolution_max = 0.5},
		{{name = "gate", count = math_random(8,16)}, weight = 1, evolution_min = 0.1, evolution_max = 0.5},
		{{name = "storage-tank", count = math_random(4,8)}, weight = 3, evolution_min = 0.3, evolution_max = 0.6},
		{{name = "train-stop", count = math_random(2,4)}, weight = 1, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "express-loader", count = math_random(1,2)}, weight = 1, evolution_min = 0.5, evolution_max = 1},
		{{name = "fast-loader", count = math_random(1,2)}, weight = 1, evolution_min = 0.2, evolution_max = 0.7},
		{{name = "loader", count = math_random(1,2)}, weight = 1, evolution_min = 0.0, evolution_max = 0.5},
		{{name = "lab", count = math_random(2,4)}, weight = 2, evolution_min = 0.0, evolution_max = 0.1},
	}	
	
	local level = global.spiral_troopers_level / 40	
	if level > 1 then level = 1 end
	for _, t in pairs (chest_loot) do
		for x = 1, t.weight, 1 do
			if t.evolution_min <= level and t.evolution_max >= level then
				table.insert(chest_raffle, t[1])
			end
		end			
	end
	local chest_type_raffle = {"steel-chest", "iron-chest", "wooden-chest"}
	local e = surface.create_entity {name = chest_type_raffle[math_random(1,#chest_type_raffle)], position = position, force = "player"}
	e.destructible = false
	local i = e.get_inventory(defines.inventory.chest)
	for x = 1, math_random(3,4), 1 do
		local loot = chest_raffle[math_random(1,#chest_raffle)]
		i.insert(loot)
	end		
end

local function level_finished()
	local spiral_cords = {
	{x = 0, y = -1},
	{x = -1, y = 0},
	{x = 0, y = 1},
	{x = 1, y = 0}
	}
	local entities = {}
	local surface = game.surfaces["spiral_troopers"]
	if not global.spiral_troopers_beaten_level then
		global.spiral_troopers_beaten_level = 1
	else
		global.spiral_troopers_beaten_level = global.spiral_troopers_beaten_level + 1
	end
	
	local evolution = global.spiral_troopers_beaten_level / 40
	if evolution > 1 then evolution = 1 end
	game.forces.enemy.evolution_factor = evolution
	
	for _, e in pairs(entities) do
		surface.create_entity(e)
	end
	for _, player in pairs(game.connected_players) do
		player.play_sound{path="utility/new_objective", volume_modifier=0.6}
	end
	game.print("Level " .. global.spiral_troopers_beaten_level .. " finished. Area Unlocked!")	
	if not global.current_beaten_chunk then global.current_beaten_chunk = {x = 0, y = -1} end
	if global.spiral_troopers_beaten_level == 1 then return end
	local current_growth_direction = global.spiral_troopers_beaten_level % 4
	if current_growth_direction == 0 then current_growth_direction = 4 end
	local old_growth_direction = (global.spiral_troopers_beaten_level - 1) % 4
	if old_growth_direction == 0 then old_growth_direction = 4 end	
	for levelsize = 1, global.spiral_troopers_beaten_level, 1 do
		if levelsize == 1 then
			global.current_beaten_chunk = {
				x = global.current_beaten_chunk.x + spiral_cords[old_growth_direction].x,
				y = global.current_beaten_chunk.y + spiral_cords[old_growth_direction].y
				}
		else
			global.current_beaten_chunk = {
				x = global.current_beaten_chunk.x + spiral_cords[current_growth_direction].x,
				y = global.current_beaten_chunk.y + spiral_cords[current_growth_direction].y
				}
		end
		local tiles = {}
		for x = 0, 31, 1 do
			for y = 0, 31, 1 do
				local pos = {x = global.current_beaten_chunk.x * 32 + x, y = global.current_beaten_chunk.y * 32 + y}
				table.insert(tiles,{name = "water", position = pos})
				if math.random(1,80) == 1 then table.insert(entities,{name = "fish", position = pos}) end
			end
		end
		surface.set_tiles(tiles, true)		
	end
	local radius = global.current_beaten_chunk.x * 32
	if radius < 0 then radius = radius * -1 end
	radius = radius + 160
	game.forces.player.chart(surface,{{x = -1 * radius, y = -1 * radius}, {x = radius, y = radius}})
end

local rock_raffle = {"sand-rock-big","rock-big","rock-big","rock-big","rock-huge"}
local ore_rotation = {"iron-ore", "copper-ore", "coal", "stone"}

local function get_furthest_chunk()
	local surface = game.surfaces["spiral_troopers"]
	local x = 1
	while true do
		if not surface.is_chunk_generated({0 + x, 0}) then break end
		x = x + 1
	end
	x = x - 1
	local y = 1
	while true do
		if not surface.is_chunk_generated({0, 0 + y}) then break end
		y = y + 1
	end
	y = y - 1
	return x, y
end

local function clear_chunk_of_enemies(chunk, surface)
	local a = {
		left_top = {x = chunk.y * 32, y = chunk.y * 32},
		right_bottom = {x = (chunk.y * 32) + 31, y = (chunk.y * 32) + 31}
		}
	local enemies = surface.find_entities_filtered({force = "enemy", area = a})
	if enemies[1] then		
		for i = 1, #enemies, 1 do				
			enemies[i].destroy()
		end		
	end
end

local function grow_level()	
	if not global.current_chunk then global.current_chunk = {x = 0, y = -1} end	
	local surface = game.surfaces["spiral_troopers"]
	local entities = {}
	local spiral_cords = {
	{x = 0, y = -1},
	{x = -1, y = 0},
	{x = 0, y = 1},
	{x = 1, y = 0}
	}
	if not global.spiral_troopers_level then 
		global.spiral_troopers_level = 1			
	else
		global.spiral_troopers_level = global.spiral_troopers_level + 1
	end	
	if not global.checkpoint_barriers then global.checkpoint_barriers = {} end
	global.checkpoint_barriers[global.spiral_troopers_level] = {}	
	local current_growth_direction = global.spiral_troopers_level % 4
	if current_growth_direction == 0 then current_growth_direction = 4 end
		
	for levelsize = 1, global.spiral_troopers_level, 1 do
		global.current_chunk = {
			x = global.current_chunk.x + spiral_cords[current_growth_direction].x,
			y = global.current_chunk.y + spiral_cords[current_growth_direction].y
			}
		
		if levelsize == global.spiral_troopers_level then
			local tiles = {}
			
			local checkpoint_chunk = {
			x = global.current_chunk.x + spiral_cords[current_growth_direction].x,
			y = global.current_chunk.y + spiral_cords[current_growth_direction].y
			}
			
			local reward_chunk_offset = (global.spiral_troopers_level - 1) % 4
			if reward_chunk_offset == 0 then reward_chunk_offset = 4 end
			local reward_chunk = {
			x = checkpoint_chunk.x + spiral_cords[reward_chunk_offset].x,
			y = checkpoint_chunk.y + spiral_cords[reward_chunk_offset].y
			}
			
			clear_chunk_of_enemies(checkpoint_chunk, surface)
			clear_chunk_of_enemies(reward_chunk, surface)
			
			for x = -1, 32, 1 do
				for y = -1, 32, 1 do
					local pos = {x = checkpoint_chunk.x * 32 + x, y = checkpoint_chunk.y * 32 + y}					
					if math.random(1,2) == 1 then
						table.insert(entities,{name = rock_raffle[math.random(1,#rock_raffle)], position = pos})
					end
				end
			end
						
			for x = 0, 31, 1 do
				for y = 0, 31, 1 do
					local pos = {x = reward_chunk.x * 32 + x, y = reward_chunk.y * 32 + y}					
					if x == 16 and y == 16 then
						map_functions.draw_smoothed_out_ore_circle(pos, ore_rotation[current_growth_direction], surface, 14, 500 * global.spiral_troopers_level)
						local unlocker = surface.create_entity({name = "burner-inserter", position = pos, force = "player"})
						unlocker.destructible = false
						unlocker.minable = false
					end
					
					if x >= 4 and x <= 5 and y >= 4 and y <= 5 then if math.random(1,3) ~= 1 then treasure_chest(pos, surface) end end
					if x >= 26 and x <= 27 and y >= 26 and y <= 27 then if math.random(1,3) ~= 1 then treasure_chest(pos, surface) end end
					if x >= 26 and x <= 27 and y >= 4 and y <= 5 then if math.random(1,3) ~= 1 then treasure_chest(pos, surface) end end
					if x >= 4 and x <= 5 and y >= 26 and y <= 27 then if math.random(1,3) ~= 1 then treasure_chest(pos, surface) end end
					
					if x >= 3 and x <= 6 and y >= 3 and y <= 6 then table.insert(tiles,{name = "concrete", position = pos}) end
					if x >= 25 and x <= 28 and y >= 25 and y <= 28 then table.insert(tiles,{name = "concrete", position = pos}) end
					if x >= 25 and x <= 28 and y >= 3 and y <= 6 then table.insert(tiles,{name = "concrete", position = pos}) end
					if x >= 3 and x <= 6 and y >= 25 and y <= 28 then table.insert(tiles,{name = "concrete", position = pos}) end
					
				end
			end
			surface.set_tiles(tiles, true)			
		end						
		local tiles = {}
		for x = 0, 31, 1 do
			for y = 0, 31, 1 do
				local pos = {x = global.current_chunk.x * 32 + x, y = global.current_chunk.y * 32 + y}
				table.insert(tiles,{name = "out-of-map", position = pos})				
			end
		end			
		surface.set_tiles(tiles, true)		
	end
	for x, e in pairs(entities) do
		local entity = surface.create_entity(e)
		entity.destructible = false
		entity.minable = false
		table.insert(global.checkpoint_barriers[global.spiral_troopers_level], entity)
	end
	global.checkpoint_barriers[global.spiral_troopers_level] = shuffle(global.checkpoint_barriers[global.spiral_troopers_level])
end

local worm_raffle = {}
worm_raffle[1] = {"small-worm-turret", "small-worm-turret", "small-worm-turret", "small-worm-turret", "small-worm-turret", "small-worm-turret"}
worm_raffle[2] = {"small-worm-turret", "small-worm-turret", "small-worm-turret", "small-worm-turret", "small-worm-turret", "medium-worm-turret"}
worm_raffle[3] = {"small-worm-turret", "small-worm-turret", "small-worm-turret", "small-worm-turret", "medium-worm-turret", "medium-worm-turret"}
worm_raffle[4] = {"small-worm-turret", "small-worm-turret", "small-worm-turret", "medium-worm-turret", "medium-worm-turret", "medium-worm-turret"}
worm_raffle[5] = {"small-worm-turret", "small-worm-turret", "medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "big-worm-turret"}
worm_raffle[6] = {"small-worm-turret", "medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "big-worm-turret"}
worm_raffle[7] = {"medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "big-worm-turret", "big-worm-turret"}
worm_raffle[8] = {"medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "big-worm-turret", "big-worm-turret"}
worm_raffle[9] = {"medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "big-worm-turret", "big-worm-turret", "big-worm-turret"}
worm_raffle[10] = {"medium-worm-turret", "medium-worm-turret", "medium-worm-turret", "big-worm-turret", "big-worm-turret", "big-worm-turret"}

local function on_chunk_generated(event)
	local surface = game.surfaces["spiral_troopers"]
	if event.surface.name ~= surface.name then return end
	
	if not global.spiral_troopers_spawn_ores then
		if get_furthest_chunk() > 2 then
			map_functions.draw_smoothed_out_ore_circle({x = -16, y = 16}, "iron-ore", surface, 16, 500)
			map_functions.draw_smoothed_out_ore_circle({x = 16, y = 16}, "coal", surface, 16, 500)
			map_functions.draw_smoothed_out_ore_circle({x = 48, y = 16}, "copper-ore", surface, 16, 500)
			global.spiral_troopers_spawn_ores = true
		end
	end		
	
	for x = 0, 31, 1 do
		for y = 0, 31, 1 do
			local pos = {x = event.area.left_top.x + x, y = event.area.left_top.y + y}	
			if pos.x > 64 or pos.x < -64 or pos.y > 64 or pos.y < -48 then
				if surface.can_place_entity({name = "spitter-spawner", position = pos}) and math.random(1,20) == 1 then
					if math.random(1,3) == 1 then
						surface.create_entity({name = "spitter-spawner", position = pos})
					else
						surface.create_entity({name = "biter-spawner", position = pos})
					end
				end
				if surface.can_place_entity({name = "big-worm-turret", position = pos}) and math.random(1,1500) == 1 then
					local level = 0.1
					if global.spiral_troopers_level then level = global.spiral_troopers_level / 40 end	
					if level > 1 then level = 1 end
					local index = math.ceil(level * 10, 0)
					if index < 1 then index = 1 end
					if index > 10 then index = 10 end					
					local name = worm_raffle[index][math.random(1, #worm_raffle[index])]
					surface.create_entity({name = name, position = pos})
				end
			end
		end
	end
	
	local chunk_position_x = event.area.left_top.x / 32
	local chunk_position_y = event.area.left_top.y / 32
	if chunk_position_x < 0 then chunk_position_x = chunk_position_x * -1 end
	if chunk_position_y < 0 then chunk_position_y = chunk_position_y * -1 end
	local level = 1
	if global.spiral_troopers_level then level = (global.spiral_troopers_level / 2) + 3 end	
	if chunk_position_x > level and chunk_position_y > level then grow_level() end	
end

local function on_player_joined_game(event)
	local player = game.players[event.player_index]	
	if not global.map_init_done then			
		local map_gen_settings = {}
		map_gen_settings.water = "none"
		map_gen_settings.cliff_settings = {cliff_elevation_interval = 50, cliff_elevation_0 = 50}
		map_gen_settings.autoplace_controls = {
			["coal"] = {frequency = "none", size = "none", richness = "none"},
			["stone"] = {frequency = "none", size = "none", richness = "none"},
			["copper-ore"] = {frequency = "none", size = "none", richness = "none"},
			["iron-ore"] = {frequency = "none", size = "none", richness = "none"},
			["uranium-ore"] = {frequency = "none", size = "none", richness = "none"},
			["crude-oil"] = {frequency = "none", size = "none", richness = "none"},
			["trees"] = {frequency = "none", size = "none", richness = "none"},
			["enemy-base"] = {frequency = "none", size = "none", richness = "none"},
			["grass"] = {frequency = "normal", size = "normal", richness = "normal"},
			["sand"] = {frequency = "none", size = "none", richness = "none"},
			["desert"] = {frequency = "none", size = "none", richness = "none"},
			["dirt"] = {frequency = "none", size = "none", richness = "none"}
		}
		game.create_surface("spiral_troopers", map_gen_settings)		
		game.forces["player"].set_spawn_position({0,0},game.surfaces["spiral_troopers"])
		game.forces["player"].technologies["artillery-shell-range-1"].enabled = false			
		game.forces["player"].technologies["artillery-shell-speed-1"].enabled = false
		game.forces["player"].technologies["artillery"].enabled = false
		local surface = game.surfaces["spiral_troopers"]
		local radius = 256
		game.forces.player.chart(surface,{{x = -1 * radius, y = -1 * radius}, {x = radius, y = radius}})
		global.map_init_done = true						
	end	
	local surface = game.surfaces["spiral_troopers"]
	if player.online_time < 5 and surface.is_chunk_generated({0,0}) then 
		player.teleport(surface.find_non_colliding_position("player", {0,0}, 2, 1), "spiral_troopers")
	else
		if player.online_time < 5 then
			player.teleport({0,0}, "spiral_troopers")
		end
	end	
	if player.online_time < 10 then				
		player.insert {name = 'iron-axe', count = 1}
		player.insert {name = 'iron-plate', count = 32}
		player.insert {name = 'pistol', count = 1}
		player.insert {name = 'firearm-magazine', count = 64}
	end
end

local function on_player_rotated_entity(event)
	if event.entity.name == "burner-inserter" and event.entity.destructible == false then
		game.surfaces["spiral_troopers"].create_entity{name = "big-explosion", position = event.entity.position}
		event.entity.destroy()		
		level_finished()
	end
end

local disabled_entities = {"gun-turret", "laser-turret", "flamethrower-turret"}
local function on_built_entity(event)
	for _, e in pairs(disabled_entities) do
		if e == event.created_entity.name then
			event.created_entity.die("enemy")
			if event.player_index then
				--local player = game.players[event.player_index]
				--player.print("Turrets outside of conquered zones are disabled.", {r=0.75, g=0.0, b=0.0})
			end
		end
	end
end

local function on_robot_built_entity(event)
	on_built_entity(event)
end

local biter_building_inhabitants = {}
biter_building_inhabitants[1] = {{"small-biter",8,16}}
biter_building_inhabitants[2] = {{"small-biter",12,24}}
biter_building_inhabitants[3] = {{"small-biter",8,16},{"medium-biter",1,2}}
biter_building_inhabitants[4] = {{"small-biter",4,8},{"medium-biter",4,8}}
biter_building_inhabitants[5] = {{"small-biter",3,5},{"medium-biter",8,12}}
biter_building_inhabitants[6] = {{"small-biter",3,5},{"medium-biter",5,7},{"big-biter",1,2}}
biter_building_inhabitants[7] = {{"medium-biter",6,8},{"big-biter",3,5}}
biter_building_inhabitants[8] = {{"medium-biter",2,4},{"big-biter",6,8}}
biter_building_inhabitants[9] = {{"medium-biter",2,3},{"big-biter",7,9}}
biter_building_inhabitants[10] = {{"big-biter",4,8},{"behemoth-biter",3,4}}
local entity_drop_amount = {
    ['small-biter'] = {low = 10, high = 20},
    ['small-spitter'] = {low = 10, high = 20},
    ['medium-spitter'] = {low = 15, high = 30},
    ['big-spitter'] = {low = 20, high = 40},
    ['behemoth-spitter'] = {low = 30, high = 50},
	['biter-spawner'] = {low = 50, high = 100},
	['spitter-spawner'] = {low = 50, high = 100}
}
local ore_spill_raffle = {"iron-ore","iron-ore","iron-ore","iron-ore","iron-ore","copper-ore","copper-ore","copper-ore","coal","coal","stone","uranium-ore", "landfill", "landfill", "landfill"}

local function on_entity_died(event)
    if event.entity.name == "biter-spawner" or event.entity.name == "spitter-spawner" then
        local e = math.ceil(game.forces.enemy.evolution_factor*10, 0)
        for _, t in pairs (biter_building_inhabitants[e]) do
            for x = 1, math.random(t[2],t[3]), 1 do
                local p = event.entity.surface.find_non_colliding_position(t[1] , event.entity.position, 6, 1)
                if p then event.entity.surface.create_entity {name=t[1], position=p} end
            end
        end	 
		if math.random(1,50) == 1 then
			local amount = 100000 * (1 + (game.forces.enemy.evolution_factor * 20))
			event.entity.surface.create_entity({name = "crude-oil", position = event.entity.position, amount = amount})
		end
    end
	if entity_drop_amount[event.entity.name] then
		if game.forces.enemy.evolution_factor < 0.5 then
			local amount = math.ceil(math.random(entity_drop_amount[event.entity.name].low, entity_drop_amount[event.entity.name].high) * (0.5 - game.forces.enemy.evolution_factor) * 2, 0)		
			event.entity.surface.spill_item_stack(event.entity.position,{name = ore_spill_raffle[math.random(1,#ore_spill_raffle)], count = amount},true)
		end		
	end
end

local kabooms = {"big-artillery-explosion", "big-explosion", "explosion"}
local function on_tick(event)
	if not global.spiral_troopers_beaten_level then return end
	if not global.checkpoint_barriers[global.spiral_troopers_beaten_level] then return end	
	if game.tick % 2 == 1 then
		if global.checkpoint_barriers[global.spiral_troopers_beaten_level][#global.checkpoint_barriers[global.spiral_troopers_beaten_level]].valid == true then
			game.surfaces["spiral_troopers"].create_entity{name = kabooms[math.random(1,#kabooms)], position = global.checkpoint_barriers[global.spiral_troopers_beaten_level][#global.checkpoint_barriers[global.spiral_troopers_beaten_level]].position}
			global.checkpoint_barriers[global.spiral_troopers_beaten_level][#global.checkpoint_barriers[global.spiral_troopers_beaten_level]].destroy()
		end
		global.checkpoint_barriers[global.spiral_troopers_beaten_level][#global.checkpoint_barriers[global.spiral_troopers_beaten_level]] = nil
		if #global.checkpoint_barriers[global.spiral_troopers_beaten_level] == 0 then global.checkpoint_barriers[global.spiral_troopers_beaten_level] = nil end
	end	
end

event.add(defines.events.on_tick, on_tick)
event.add(defines.events.on_entity_died, on_entity_died)
event.add(defines.events.on_player_rotated_entity, on_player_rotated_entity)
event.add(defines.events.on_robot_built_entity, on_robot_built_entity)
event.add(defines.events.on_built_entity, on_built_entity)
event.add(defines.events.on_chunk_generated, on_chunk_generated)
event.add(defines.events.on_player_joined_game, on_player_joined_game)