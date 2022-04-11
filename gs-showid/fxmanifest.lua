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
  'client/*.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/*.lua',
}

shared_scripts {
  'cfg.lua',
}