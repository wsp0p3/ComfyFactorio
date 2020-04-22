local event = require 'utils.event'
local Tick_functions = require "maps.wagon_rooms.tick_functions"
local Locomotive = require "maps.wagon_rooms.locomotive"

local starting_items = {['iron-plate'] = 400, ['copper-plate'] = 200, ['stone'] = 50, ['locomotive'] = 1, ['cargo-wagon'] = 3, ['rail'] = 100, ['train-stop'] = 2, ['wood'] = 50}

local function on_player_joined_game(event)
	local player = game.players[event.player_index]
    player.force.recipes.loader.enabled=true
    player.force.recipes["fast-loader"].enabled = true
    player.force.recipes["express-loader"].enabled = true
	player.force = "player"
    if player.online_time == 0 then
        for item, amount in pairs(starting_items) do
            player.insert({name = item, count = amount})
        end
	end

    if global.wagons == nil then
        return
    end

	for name, wagon in pairs(global.wagons) do
	    if player.surface == wagon.surface then
            if not wagon["vehicle"].valid then
                player.teleport(game.surfaces[1].find_non_colliding_position("character", {x = 0, y = 0}, 128, -0.5), game.surfaces[1])
            end
	    end
	end
end

local function tick()
    local tick = game.tick
    if tick % 120 == 0 then
        Tick_functions.move_items()
    end
end

local function on_player_driving_changed_state(event)
	local player = game.players[event.player_index]
	local vehicle = event.entity
    Locomotive.enter_cargo_wagon(player, vehicle)
end


local function on_entity_died(event)
	if event.entity.type == "cargo-wagon" then
	    for name, wagon in pairs(global.wagons) do
	        if wagon["vehicle"] == event.entity then
                for index, player in pairs(game.connected_players) do
                    if player.surface == wagon.surface then
                        player.teleport(game.surfaces[1].find_non_colliding_position("character", {x = 0, y = 0}, 128, -0.5), game.surfaces[1])
                        player.character.die()
                    end
                end
            end
	    end
	end
end

event.on_nth_tick(2, tick)
event.add(defines.events.on_player_joined_game, on_player_joined_game)
event.add(defines.events.on_player_driving_changed_state, on_player_driving_changed_state)
event.add(defines.events.on_entity_died, on_entity_died)

