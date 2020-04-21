local event = require 'utils.event'
local Tick_functions = require "maps.wagon_rooms.tick_functions"
local Locomotive = require "maps.wagon_rooms.locomotive"

local starting_items = {['locomotive'] = 1, ['cargo-wagon'] = 5, ['rail'] = 50, ['wood'] = 16}

local function on_player_joined_game(event)
	local player = game.players[event.player_index]
	player.force = "player"
    if player.online_time == 0 then
        for item, amount in pairs(starting_items) do
            player.insert({name = item, count = amount})
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

event.on_nth_tick(2, tick)
event.add(defines.events.on_player_joined_game, on_player_joined_game)
event.add(defines.events.on_player_driving_changed_state, on_player_driving_changed_state)
