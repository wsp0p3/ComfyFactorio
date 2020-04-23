local Train_help = require "maps.wagon_rooms.trainhelp"

local Public_tick = {}

local math_random = math.random
local math_floor = math.floor
local math_ceil = math.ceil
local math_min = math.min

local function move_all_from_to(from_inv, to_inv)
    if from_inv == nil or to_inv == nil then
        return
    end

    for i = 1, #from_inv, 1 do
        if from_inv[i].valid_for_read then
            local count = to_inv.insert(from_inv[i])
            from_inv[i].count = from_inv[i].count - count
        end
    end
end


function Public_tick.move_items()
    if not global.wagons then return end

    for name, wagon in pairs(global.wagons) do
        if wagon["vehicle"].valid then
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
                                -- TODO: take input value as max count
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
                local cur_out = wagon["chests"]["N"]["out"].get_inventory(defines.inventory.chest)
                local cur_in = wagon["chests"]["N"]["in"].get_inventory(defines.inventory.chest)

                if prev["vehicle"].type ~= "locomotive" then
                    local prev_out = prev["chests"]["S"]["out"].get_inventory(defines.inventory.chest)
                    local prev_in = prev["chests"]["S"]["in"].get_inventory(defines.inventory.chest)

                    move_all_from_to(cur_out, prev_in)
                    move_all_from_to(prev_out, cur_in)
                else
                    local prev_in = prev["vehicle"].get_inventory(defines.inventory.fuel)
                    move_all_from_to(cur_out, prev_in)
                end
            end

            local next = Train_help.find_next_wagon(wagon["vehicle"])
            if next ~= nil then
                local cur_out = wagon["chests"]["S"]["out"].get_inventory(defines.inventory.chest)
                local cur_in = wagon["chests"]["S"]["in"].get_inventory(defines.inventory.chest)
                if next["vehicle"].type ~= "locomotive" then
                    local next_out = next["chests"]["N"]["out"].get_inventory(defines.inventory.chest)
                    local next_in = next["chests"]["N"]["in"].get_inventory(defines.inventory.chest)

                    move_all_from_to(cur_out, next_in)
                    move_all_from_to(next_out, cur_in)
                else
                    local next_in = next["vehicle"].get_inventory(defines.inventory.fuel)
                    move_all_from_to(cur_out, next_in)
                end
            end
        end
    end
end



return Public_tick
