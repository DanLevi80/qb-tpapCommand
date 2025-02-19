-- Store previous locations of players
local previousLocations = {}

RegisterCommand("tpap", function(source, args, rawCommand)
    -- Check if the player executing the command has TxAdmin permissions
    if IsPlayerAceAllowed(source, "command.tpap") then
        -- Check if a player ID is provided
        local targetPlayer = tonumber(args[1])
        if targetPlayer and GetPlayerName(targetPlayer) then
            -- Request the player's current position before teleporting
            TriggerClientEvent("tpap:saveLocation", targetPlayer)

            -- Define the teleport location (Modify this for your needs)
            local teleportLocation = vector3(-1024.5, -2745.6, 13.8) -- Change this to your preferred location

            -- Trigger the teleport event on the target player's client
            TriggerClientEvent("tpap:teleport", targetPlayer, teleportLocation)
            TriggerClientEvent("chatMessage", source, "[^2TPAP^0]", {255, 255, 255}, "Player ^2" .. GetPlayerName(targetPlayer) .. "^0 has been teleported!")
        else
            TriggerClientEvent("chatMessage", source, "[^1TPAP^0]", {255, 255, 255}, "Invalid Player ID!")
        end
    else
        TriggerClientEvent("chatMessage", source, "[^1TPAP^0]", {255, 255, 255}, "You do not have permission to use this command!")
    end
end, false)

RegisterCommand("tpapback", function(source, args, rawCommand)
    -- Check if the player executing the command has TxAdmin permissions
    if IsPlayerAceAllowed(source, "command.tpap") then
        -- Check if a player ID is provided
        local targetPlayer = tonumber(args[1])
        if targetPlayer and previousLocations[targetPlayer] then
            -- Get the saved location
            local originalLocation = previousLocations[targetPlayer]

            -- Teleport player back
            TriggerClientEvent("tpap:teleport", targetPlayer, originalLocation)
            TriggerClientEvent("chatMessage", source, "[^2TPAPBACK^0]", {255, 255, 255}, "Player ^2" .. GetPlayerName(targetPlayer) .. "^0 has been returned to their original position!")
            
            -- Clear saved location
            previousLocations[targetPlayer] = nil
        else
            TriggerClientEvent("chatMessage", source, "[^1TPAPBACK^0]", {255, 255, 255}, "No previous location found for this player!")
        end
    else
        TriggerClientEvent("chatMessage", source, "[^1TPAPBACK^0]", {255, 255, 255}, "You do not have permission to use this command!")
    end
end, false)

-- Save the player's location when requested by the client
RegisterNetEvent("tpap:storeLocation")
AddEventHandler("tpap:storeLocation", function(coords)
    local playerId = source
    previousLocations[playerId] = coords
end)

-- Add these permissions in your server.cfg:
-- add_ace group.admin command.tpap allow
-- add_ace group.admin command.tpapback allow
