fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'src/client.lua'
}

server_scripts {
    'src/server.lua'
}

escrow_ignore {
    'config.lua'
}

lua54 'true'