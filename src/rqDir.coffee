((modules, factory) ->
  # Use define if amd compatible define function is defined
  if typeof define is 'function' && define.amd
    define modules, factory
  # Use node require if not
  else
    module.exports = factory (require m for m in modules)...
)( ['node-dir', 'path'], (dir, path) ->
  load: (name, require, onload) ->
    basePath = require.toUrl ''
    dirname = require.toUrl name
    try
      dir.files dirname, (err, paths) ->
        onload.error err if err
        onload.error new Error "Directory " + dirname + " is empty" if paths.length is 0
        require paths, (modules...) ->
          paths = paths.map (p) -> path.relative basePath, p
          moduleObject = {}
          for module, i in modules
            moduleObject[paths[i]] = module
          onload moduleObject
    catch err
      onload.error err
)