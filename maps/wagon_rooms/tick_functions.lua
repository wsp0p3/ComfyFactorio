local Train_help = require "maps.wagon_rooms.trainhelp"

local Public_tick = {}

local math_random = math.random
local math_floor = math.floor
local math_ceil = math.ceil
local math_min = math.min

local function move_all_from_to(from, to)
    for i = 1, #from, 1 do
        if from[i].valid_for_read then
            local count = to.insert(from[i])
            from[i].count = from[i].count - count
        end
    end
end


function Public_tick.move_items()
    if not global.wagons then return end

    for name, wagon in pairs(global.wagons) do
        local input_filter = global.wagons[name]["cfg"].get_merged_signals()

        local cargo = wagon["vehicle"].get_inventory(defines.inventory.cargo_wagon)
        local input = wagon["chests"]["in"].get_inventory(defines.inventory.chest)
        local out = wagon["chests"]["out"].get_inventory(defines.inventory.chest)
        cargo.sort_and_merge()
        input.sort_and_merge()
        out.sort_and_merge()

        if input_filter ~= nil then
            for i = 1, #cargo, 1 do
                for _, signal in pairs(input_filter) do
                    if cargo[i].valid_for_read then
                        if signal.signal.name == cargo[i].name then
                            local count = input.insert(cargo[i])
                            cargo[i].count = cargo[i].count - count
                        end
                    end
                end
            end
        end

        move_all_from_to(out, cargo)

        local prev = Train_help.find_prev_wagon(wagon["vehicle"])

        if prev ~= nil then
            local cur_out = wagon["chests"]["S"]["out"].get_inventory(defines.inventory.chest)
            local cur_in = wagon["chests"]["S"]["in"].get_inventory(defines.inventory.chest)

            local prev_out = prev["chests"]["N"]["out"].get_inventory(defines.inventory.chest)
            local prev_in = prev["chests"]["N"]["in"].get_inventory(defines.inventory.chest)

            move_all_from_to(cur_out, prev_in)
            move_all_from_to(prev_out, cur_in)
        end

        local next = Train_help.find_next_wagon(wagon["vehicle"])
        if next ~= nil then
            local cur_out = wagon["chests"]["N"]["out"].get_inventory(defines.inventory.chest)
            local cur_in = wagon["chests"]["N"]["in"].get_inventory(defines.inventory.chest)

            local next_out = next["chests"]["S"]["out"].get_inventory(defines.inventory.chest)
            local next_in = next["chests"]["S"]["in"].get_inventory(defines.inventory.chest)

            move_all_from_to(cur_out, next_in)
            move_all_from_to(next_out, cur_in)
        end
    end
end



return Public_tick
