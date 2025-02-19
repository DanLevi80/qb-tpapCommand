RegisterNetEvent("tpap:teleport")
AddEventHandler("tpap:teleport", function(coords)
    local ped = PlayerPedId()
    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, true)
end)

RegisterNetEvent("tpap:saveLocation")
AddEventHandler("tpap:saveLocation", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Send the coordinates back to the server to store
    TriggerServerEvent("tpap:storeLocation", coords)
end)
