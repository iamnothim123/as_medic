fx_version 'cerulean'
game       'gta5'
lua54      'yes'

resource_type 'gametype ' {name = 'him!'}

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_script 'server.lua'



dependency {
    'ox_lib',
    'qbx_medical'
}

version '1.0.0'