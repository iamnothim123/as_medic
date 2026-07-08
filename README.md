# AS Medic

AS Medic is a simple AI medic resource for FiveM/Qbox servers. When a player uses `/medic`, an NPC ambulance is dispatched from the hospital, drives to the player, plays a CPR scene, revives the player through `qbx_medical`, charges a medical fee, sends a notification, and then cleans up the ambulance and medic NPC.

## Features

- `/medic` command to call an AI medic
- Spawns an ambulance and paramedic NPC
- Adds an EMS blip so the player can see the medic coming
- Enables siren while the ambulance is responding
- Plays CPR animations for the player and paramedic
- Revives the player using `qbx_medical`
- Removes a configurable medical fee from the player's bank
- Sends a Qbox notification after revive
- Deletes the ambulance and medic after the job is finished

## Dependencies

Make sure these resources are installed and started before AS Medic:

- `qbx_core`
- `qbx_medical`
- `ox_lib`

## Installation

1. Download or clone this resource.
2. Place the folder inside your server `resources` folder.
3. Rename the folder to something simple, for example:

```text
as_medic
```

4. Add this to your `server.cfg`:

```cfg
ensure ox_lib
ensure qbx_core
ensure qbx_medical
ensure as_medic
```

5. Restart your server or run:

```cfg
refresh
ensure as_medic
```

## Usage

In game, use:

```text
/medic
```

The ambulance will spawn at the hospital location set in `client.lua`, drive to the player, and the medic will perform CPR.

## Configuration

### Change the hospital spawn location

Open `client.lua` and edit:

```lua
local hospitalcoords = vector3(317.1169, -555.6258, 28.7438)
```

You can also change the ambulance heading here:

```lua
276.5476
```

### Change the medical fee

Open `server.lua` and edit this amount:

```lua
exports.qbx_core:RemoveMoney(src, 'bank', 5000, 'Medical Expenses')
```

Change `5000` to whatever price you want.

### Change the notification

Open `server.lua` and edit:

```lua
exports.qbx_core:Notify(src, 'You have been revived and your medical expenses have been deducted.', 'success', 5000, 'get scammed', 'top-right', 'default', 'check', 'green')
```

## Recommended `fxmanifest.lua`

Use this dependency block so the resource loads after everything it needs:

```lua
dependencies {
    'ox_lib',
    'qbx_core',
    'qbx_medical'
}
```

## Command

| Command | Description |
|---|---|
| `/medic` | Calls an AI EMS unit to revive the player. |

## Notes

- This script is made for Qbox/QBX servers.
- The script currently uses `qbx_medical` to revive the player.
- The script charges the player from their bank account after revive.
- Make sure your server has the ambulance vehicle and paramedic ped available.

## Credits

Created by Assassin Scriptz.

## License

All rights reserved. Do not resell, leak, or redistribute without permission.
