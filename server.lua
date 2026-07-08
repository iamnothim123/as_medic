RegisterNetEvent('asrp:revivePlayer', function()
    local src = source

    print("ASRP revive event triggered for player:", src)

    exports['qbx_medical']:Revive(src)
    Wait(5500)
    exports.qbx_core:RemoveMoney(src, 'bank', 5000, 'Medical Expenses')
    exports.qbx_core:Notify(src, 'You have been revived and your medical expenses have been deducted.', 'success', 5000, 'get scammed', 'top-right', 'default', 'check', 'green')



end)