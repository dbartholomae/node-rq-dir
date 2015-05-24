requirejs = require 'requirejs'

requirejs.config
  baseUrl: ''
  nodeRequire: require

requirejs ['../lib/rqDir!config', 'path'], (dir, path) ->
  config = {}
  for filename, content of dir
    config[path.basename filename, '.js'] = content
  console.log config
