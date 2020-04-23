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

return Public_trainhelp
