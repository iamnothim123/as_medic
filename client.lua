enroute = false
print(enroute)
function comeMedic(source, args)
    if enroute then
        print("EMS is already enroute")
        return
    else
    local player = PlayerPedId()
    local playercoords = GetEntityCoords(player)
    local PlayerData = exports.qbx_core:GetPlayerData()
    enroute = true
    print(enroute)
    local isDead = false
    local ambulancehash = GetHashKey("ambulance")
    local medicHash = GetHashKey("s_m_m_paramedic_01")
    local victimcoords = GetEntityCoords(player, true)
    local heading = GetEntityHeading(player)

    local hospitalcoords = vector3(317.1169, -555.6258, 28.7438)


    if PlayerData and PlayerData.metadata then
        isDead = PlayerData.metadata.isdead or PlayerData.metadata.inlaststand
    end
    ---if isDead then

          
    

        print("EMS enroute")
        EnableDispatchService(
	    5, 
	    true
        )

        RequestModel(ambulancehash)
        while not HasModelLoaded(ambulancehash) do
            Wait(5)
        end

        local ambulance = 
        CreateVehicle(
		ambulancehash, 
		hospitalcoords.x, 
		hospitalcoords.y, 
		hospitalcoords.z, 
		276.5476,
        true,
        true
	    )
        
        print(ambulance)

        RequestModel(medicHash)
        while not HasModelLoaded(medicHash) do
            Wait(5)
        end

        local medic = CreatePedInsideVehicle(
		ambulance, 
		26, 
		medicHash, 
		-1, 
		true, 
		true
	    )
        SetEntityInvincible(medic, true)
        SetEntityInvincible(ambulance, true)
        local medicblip = AddBlipForEntity(medic)
        SetBlipSprite(medicblip, 42)
        AddTextEntry('MYBLIP', 'EMS ~a~!')
        BeginTextCommandSetBlipName('MYBLIP')
        EndTextCommandSetBlipName(medicblip)
        SetBlipPriority(medicblip, 1)
        SetVehicleSiren(ambulance, true)

        TaskVehicleDriveToCoordLongrange(
	medic, 
	ambulance, 
	victimcoords.x, 
	victimcoords.y, 
	victimcoords.z, 
	30.0, 
	4, 
	25.0)
        

        CreateThread(function()
    while true do
        Wait(100)
        local mediccoords = GetEntityCoords(medic)
        local victimcoords = GetEntityCoords(PlayerPedId())
        local dist = #(victimcoords - mediccoords)

        if dist <= 26.0 then
            BringVehicleToHalt(ambulance, 2.0, 1, true)
            TaskLeaveVehicle(medic, ambulance, 64)
            RequestAnimDict("missheistfbi3b_ig8_2")
while not HasAnimDictLoaded("missheistfbi3b_ig8_2") do
    Wait(10)
end

TaskPlayAnim(
    PlayerPedId(),
    "missheistfbi3b_ig8_2",
    "cpr_loop_victim",
    8.0,
    -8.0,
    -1,
    1,
    0.0,
    false,
    false,
    false
)
            break
        end

        Wait(500)
    end

    TaskGoStraightToCoord(
	medic, 
	victimcoords.x, 
	victimcoords.y, 
	victimcoords.z, 
	3.0, 
	-1, 
	targetHeading --[[ number ]], 
	distanceToSlide --[[ number ]]
)
end)
        local victimheading = GetEntityHeading(player)
        SetEntityHeading(medic, victimheading)
    CreateThread(function()
        while true do
            Wait(100)
                local mediccoords = GetEntityCoords(medic)
                local victimcoords = GetEntityCoords(PlayerPedId())
                local dist = #(victimcoords - mediccoords)

                if dist <= 2.0 then
                local animDict = "missheistfbi3b_ig8_2"
                local animName = "cpr_loop_paramedic"

                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                Wait(10)
                end

                TaskPlayAnimAdvanced(
                medic,
                animDict,
                animName,
                victimcoords.x,
                victimcoords.y,
                victimcoords.z,
                0.0,
                0.0,
                heading,
                8.0,
                -8.0,
                -1,
                1,
                0.0,
                false,
                false
                )
                Wait(10000)
        ClearPedTasks(medic)
        TriggerServerEvent('asrp:revivePlayer')
        ClearPedTasks(player)
        RemoveBlip(medicblip)
            break
        end

        
    end

    GetPedInVehicleSeat(ambulance, -1)
    StopBringVehicleToHalt(ambulance)
    SetVehicleSiren(ambulance, false)
    TaskVehicleDriveToCoordLongrange(
	medic, 
	ambulance, 
	hospitalcoords.x, 
	hospitalcoords.y, 
	hospitalcoords.z, 
	20.0, 
	1, 
	25.0)


    CreateThread(function()
        while true do
            Wait(100)
            local mediccoords = GetEntityCoords(medic)
            local dist = #(hospitalcoords - mediccoords)
            if dist <= 30.0 then
                DeleteEntity(medic)
                DeleteEntity(ambulance)
                enroute = false
                print(enroute)
                break
            end

        end
    end)

end)

end     ---else
        ---    print("you don't  need a medic")
        ---end


end

RegisterCommand("medic", comeMedic, false)