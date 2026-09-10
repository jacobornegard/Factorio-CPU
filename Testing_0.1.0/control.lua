-- Loads the content of the specfied file in a variable upon loading of a save file
local bp_string = require("bp_in")

-- Custom in-game command to export String from BP in the player's cursor
-- Exports to file in game directory
commands.add_command("bpout", "Export the blueprint held in the cursor", function(command)
    if not command.player_index then
        game.print("This command must be run by a player.")
        return
    end

    local player = game.get_player(command.player_index)
    
    if player.cursor_stack.valid_for_read then
        helpers.write_file("bp_out.txt", player.cursor_stack.export_stack())
    else
        player.print("Your cursor is empty.")
    end
end)


-- Simple custom in-game command to update a file in a monitored folder, triggering the execution of a Powershell script
commands.add_command("encode", "Execute a script to encode the JSON to BP string", function(comand)
    helpers.write_file("request.txt", "", false)
end)


-- Custom in-game command to import a BP string to the player's cursor
commands.add_command("bpin", "Import a blueprint to the cursor", function(command)
    if not command.player_index then
        game.print("This command must be run by a player.")
        return
    end

    local player = game.get_player(command.player_index)

    local stack = player.cursor_stack
    if stack and stack.valid_for_read == false then
        stack.set_stack{name="blueprint", count=1}
        stack.import_stack(bp_string)
    else
        player.print("Your cursor must be empty.")
    end
    
end)

-- Custom in-game command to export wanted signals by type
-- Exports to file in game directory
commands.add_command("signals", "Exports the wanted signal categories to a file.", function(command)
    if not command.player_index then
        game.print("This command must be run by a player.")
        return
    end
    local player = game.get_player(command.player_index)

    local category_set = {
        ["item"] = false,
        ["fluid"] = false,
        ["entity"] = false,
        ["virtual"] = false,
        ["recipe"] = false
    }
    local input = command.parameter
    -- Setting boolean values for the signal types to be exported, based on parameters speciefied in command
    -- If no parameter given, all types exported, else, all types specified in paramater
    if input == nil then
        game.print("Exporting all signal types")
        for k in pairs(category_set) do
            category_set[k] = true
        end
    else
        for word in string.gmatch(input, "%S+") do
            game.print("Exporting singal type: " .. word)
            category_set[word] = true
        end
    end

    local list = {}
    -- Conditional selections for each signal type
    if category_set["item"] then
        for n,_ in pairs(prototypes.item) do  
            if not string.match(n, "^textplate") then
                list[#list+1] = {type="item", name=n}
            end    
        end 
    end
    if category_set["fluid"] then
        for n,_ in pairs(prototypes.fluid) do 
            list[#list+1] = {type="fluid", name=n}
        end 
    end
    if category_set["entity"] then
        for n,_ in pairs(prototypes.entity) do
            list[#list+1] = {type="entity", name=n}
        end
    end
    if category_set["virtual"] then
        for n,_ in pairs(prototypes.virtual_signal) do
            list[#list+1] = {type="virtual", name=n}
        end
    end
    if category_set["recipe"] then
        for n,_ in pairs(prototypes.recipe) do
            list[#list+1] = {type="recipe", name=n}
        end
    end

    -- Formats the data as JSON and exports to file
    local json = helpers.table_to_json(list)
    helpers.write_file("signals.json", json)
end)
