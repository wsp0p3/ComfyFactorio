local Public_trainhelp = {}

function Public_trainhelp.find_prev_wagon(current_wagon)
    local train = current_wagon.train
    if train ~= nil then
        local last
        for key, value in pairs(train.carriages) do
            if value == current_wagon then
                if last ~= nil then
                    if last.type == "locomotive" then
                        local tmp_wagon = {}
                        tmp_wagon["vehicle"] = last
                        return tmp_wagon
                    end
                    for key, wagon in pairs(global.wagons) do
                        if wagon["vehicle"] == last then
                            return wagon
                        end
                    end
                end
            end
            last = value
        end
    end
end

function Public_trainhelp.find_next_wagon(current_wagon)
    local train = current_wagon.train
    if train ~= nil then
        local last
        for key, value in pairs(train.carriages) do
            if last == current_wagon then
                if value.type == "locomotive" then
                    local tmp_wagon = {}
                    tmp_wagon["vehicle"] = value
                    return tmp_wagon
                end
                for key, wagon in pairs(global.wagons) do
                    if wagon["vehicle"] == value then
                        return wagon
                    end
                end
            end

            last = value
        end
        end
end

function Public_trainhelp.get_wagon_orientation(current_wagon)
    local vector = { x = 0, y = 0 }

    local prev_wagon = Public_trainhelp.find_prev_wagon(current_wagon)
    local next_wagon = Public_trainhelp.find_next_wagon(current_wagon)

    if prev_wagon ~= nil then
         vector.x = vector.x + prev_wagon["vehicle"].position.x - current_wagon.position.x
         vector.y = vector.y + prev_wagon["vehicle"].position.y - current_wagon.position.y
    end

    if next_wagon ~= nil then
        vector.x = vector.x + current_wagon.position.x - next_wagon["vehicle"].position.x
        vector.y = vector.y + current_wagon.position.y - next_wagon["vehicle"].position.y

        if prev_wagon ~= nil then
            vector.x = vector.x * 0.5
            vector.y = vector.y * 0.5
        end
    end

    if vector.x == 0 and vector.y == 0 then
        vector.y = 2
    end

    return vector
end

return Public_trainhelp
