fx_version 'adamant'
game 'common'

ui_page 'web/index.html'

files {
  'web/index.html',
  'web/bg.jpg',
  'web/js/*.js',
  'web/css/*.css',
}

client_scripts {
  'c_cfg.lua',
  'client/*.lua',
  'addons/**/client/*.lua'
}

server_scripts {
  's_cfg.lua',
  '@mysql-async/lib/MySQL.lua',
  'server/*.lua',
  'addons/**/server/*.lua'
}

shared_scripts {
  'addons/**/cfg.lua'
}