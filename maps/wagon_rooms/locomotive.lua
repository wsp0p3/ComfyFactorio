local Train_help = require "maps.wagon_rooms.trainhelp"
local Public = {}

local function len(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function create_chest(surface, position)
    local chest = surface.create_entity({name = "steel-chest", position = position, force = "player", create_build_effect_smoke = false})
    chest.destructible = false
    chest.minable = false
    return chest
end

function create_exit_car(surface, position, name, direction)
    local e = surface.create_entity({name = "car", position = position, force = "player", create_build_effect_smoke = false})
    e.get_inventory(defines.inventory.fuel).insert({name = "wood", count = 16})
    e.destructible = false
    e.minable = false
    e.operable = false

    for i = -1, 1, 1 do
        for j = -1, 1, 1 do
            surface.set_tiles({{name = "tutorial-grid", position = {x = e.position.x + i, y = e.position.y + j }}})
        end
    end
    global.wagons[name]["exits"][direction] = e
end


local function create_wagon_room(name)
	local width = 16
	local height = 32

	local map_gen_settings = {
		["width"] = width,
		["height"] = height,
		["water"] = 0,
		["starting_area"] = 1,
		["cliff_settings"] = {cliff_elevation_interval = 0, cliff_elevation_0 = 0},
		["default_enable_all_autoplace_controls"] = true,
		["autoplace_settings"] = {
			["entity"] = {treat_missing_as_default = false},
			["tile"] = {treat_missing_as_default = true},
			["decorative"] = {treat_missing_as_default = false},
		},
	}


	if not game.surfaces[name] then
	    global.wagons[name].surface = game.create_surface(name, map_gen_settings)
	end

	local surface = global.wagons[name].surface


	surface.freeze_daytime = true
	surface.daytime = 0.1
	surface.request_to_generate_chunks({0,0}, 1)
	surface.force_generate_chunk_requests()

	for i = map_gen_settings.width * -0.5, map_gen_settings.width * 0.5, 1 do
        for j = map_gen_settings.height * -0.5, map_gen_settings.height * 0.5, 1 do
	        surface.set_tiles({{name = "refined-concrete", position = {x = i, y = j }}})
        end
    end

    surface.set_tiles({{name = "water", position = {x = -8, y = -16 }}})
    surface.set_tiles({{name = "water", position = {x = -8, y = -15 }}})
    surface.set_tiles({{name = "water", position = {x = -7, y = -16 }}})
    surface.set_tiles({{name = "water", position = {x = -7, y = -15 }}})
    surface.set_tiles({{name = "water", position = {x = -6, y = -16 }}})
    surface.set_tiles({{name = "water", position = {x = -6, y = -15 }}})

    surface.set_tiles({{name = "water", position = {x = -8, y = 16 }}})
    surface.set_tiles({{name = "water", position = {x = -8, y = 15 }}})
    surface.set_tiles({{name = "water", position = {x = -7, y = 16 }}})
    surface.set_tiles({{name = "water", position = {x = -7, y = 15 }}})
    surface.set_tiles({{name = "water", position = {x = -6, y = 16 }}})
    surface.set_tiles({{name = "water", position = {x = -6, y = 15 }}})


    global.wagons[name]["exits"] = {}

    create_exit_car(surface, { x = 0, y = height * 0.5 + 1}, name, "N")
    create_exit_car(surface, { x = 0, y = height * -0.5 - 1}, name, "S")
    create_exit_car(surface, { x = width * 0.5 + 1.4, y = 0 }, name, "E")
    create_exit_car(surface, { x = width * -0.5 - 1.4, y = 0 }, name, "W")

    global.wagons[name]["chests"] = {}

    surface.create_entity({name = "flying-text", position = {x = 10, y = 8}, text = "IN", color = {r = 255, g = 255, b = 255}})
    global.wagons[name]["chests"]["in"] = create_chest(surface, {x = 8, y = 10})
    surface.create_entity({name = "flying-text", position = {x = 14, y = 10}, text = "cfg", color = {r = 255, g = 255, b = 255}})
    global.wagons[name]["cfg"] = surface.create_entity({name = "constant-combinator", position = {x = 10, y = 10}, force = "player", create_build_effect_smoke = false})
    pole = surface.create_entity({name = "medium-electric-pole", position = {x = 12, y = 10}, force = "player", create_build_effect_smoke = false})
    pole.destructible = false
    pole.minable = false
    pole.operable = false
    pole.connect_neighbour({wire = defines.wire_type.green, target_entity = global.wagons[name]["cfg"], source_circuit_id = 1, target_circuit_id = 1})

    surface.create_entity({name = "flying-text", position = {x = 10, y = -12}, text = "IN", color = {r = 255, g = 255, b = 255}})
    global.wagons[name]["chests"]["out"] = create_chest(surface, {x = 8, y = -10})

    global.wagons[name]["chests"]["N"] = {}

    surface.create_entity({name = "flying-text", position = {x = 5, y = -19}, text = "IN", color = {r = 255, g = 255, b = 255}})
    global.wagons[name]["chests"]["N"]["in"] = create_chest(surface, {x = 5, y = -17})
    surface.create_entity({name = "flying-text", position = {x = -5, y = -19}, text = "OUT", color = {r = 255, g = 255, b = 255}})
    global.wagons[name]["chests"]["N"]["out"] = create_chest(surface, {x = -5, y = -17})

    global.wagons[name]["chests"]["S"] = {}
    global.wagons[name]["chests"]["S"]["in"] = create_chest(surface, {x = -5, y = 16})
    surface.create_entity({name = "flying-text", position = {x = 5, y = 18}, text = "IN", color = {r = 255, g = 255, b = 255}})
    global.wagons[name]["chests"]["S"]["out"] = create_chest(surface, {x = 5, y = 16})
    surface.create_entity({name = "flying-text", position = {x = -5, y = 18}, text = "OUT", color = {r = 255, g = 255, b = 255}})
end

function Public.enter_cargo_wagon(player, vehicle)
	if not vehicle then log("no vehicle") return end
	if not vehicle.valid then log("vehicle invalid") return end
    if global.wagons == nil then
        global.wagons = {}
    end

	local current_wagon = global.wagons[player.surface.name]

    if current_wagon ~= nil then
        current_wagon = current_wagon["vehicle"]
        if not current_wagon.valid then
            player.teleport(game.surfaces[1].find_non_colliding_position("character", {x = 0, y = 0}, 128, -0.5), game.surfaces[1])
            return
        end

        if vehicle.type == "car" then
            local surface = current_wagon.surface
            if global.wagons[player.surface.name]["exits"]["N"] == vehicle then
                local prev_wagon = Train_help.find_prev_wagon(current_wagon)
                if prev_wagon ~= nil then
                    position = { x = 0, y = prev_wagon.surface.map_gen_settings.height * - 0.5}
                    player.teleport(prev_wagon.surface.find_non_colliding_position("character", position, 128, -0.5), prev_wagon.surface)
                else
                    player.teleport(surface.find_non_colliding_position("character", {x = current_wagon.position.x, y = current_wagon.position.y + 4}, 128, 0.5), surface)
                end
            elseif global.wagons[player.surface.name]["exits"]["S"] == vehicle then
                local next_wagon = Train_help.find_next_wagon(current_wagon)
                if next_wagon ~= nil then
                    position = {x = 0, y = next_wagon.surface.map_gen_settings.height * 0.5}
                    player.teleport(next_wagon.surface.find_non_colliding_position("character", position, 128, 0.5), next_wagon.surface)
                else
                   player.teleport(surface.find_non_colliding_position("character", {x = current_wagon.position.x, y = current_wagon.position.y - 4}, 128, 0.5), surface)
                end
            elseif global.wagons[player.surface.name]["exits"]["E"] == vehicle then
                player.teleport(surface.find_non_colliding_position("character", {x = current_wagon.position.x + 2, y = current_wagon.position.y}, 128, 0.5), surface)
            elseif global.wagons[player.surface.name]["exits"]["W"] == vehicle then
                player.teleport(surface.find_non_colliding_position("character", {x = current_wagon.position.x - 2, y = current_wagon.position.y}, 128, 0.5), surface)
            end
        end
    elseif vehicle.type == "cargo-wagon" then
        local contains = false
        local name

        for n, v in pairs(global.wagons) do
            if vehicle == v["vehicle"] then
                contains = true
                name = n
             end
         end

        if contains == false then
            name = tostring(len(global.wagons))
            global.wagons[name] = {}
            global.wagons[name]["vehicle"] = vehicle
            vehicle.minable = false
            create_wagon_room(name)
        end

        local wagon_surface = global.wagons[name].surface

        local x_vector = vehicle.position.x - player.position.x
        local y_vector = vehicle.position.y - player.position.y

        local position
        if math.abs(x_vector) > math.abs(y_vector) then
            if x_vector > 0 then
                position = {wagon_surface.map_gen_settings.width * -0.5, 0}
            else
                position = {wagon_surface.map_gen_settings.width * 0.5, 0}
            end
        else
            if y_vector > 0 then
                position = {0, wagon_surface.map_gen_settings.height * - 0.5}
            else
                position = {0, wagon_surface.map_gen_settings.height * 0.5}
            end
        end

        player.teleport(wagon_surface.find_non_colliding_position("character", position, 128, 0.5), wagon_surface)
	end
end

return Public
