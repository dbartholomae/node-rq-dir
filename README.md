# node-rq-dir@1.0.0
## !!! This package is no longer maintained !!!
**node-rq-dir** is a RequireJS plugin to recursively require files from a directory.
It is useful when using requirejs with node. Please note that although the examples are written in CoffeeScript,
the plugin currently only reads JavaScript files. Any other files in the folder will be ignored.

```coffeescript
define ['rq-dir!configDir', 'path'], (dir, path) ->
  config = {}
  for filename, content of dir
    config[path.basename filename, '.js'] = content
  return config
```

## Example

Assuming the following directory structure 

```
+-- example
|   +-- main.coffee
|   +-- config
|   |   +-- router.js
|   |   +-- database.js
|   |   +-- info.txt
|   |   +-- middleware
|   |   |   +-- security.js
```

and files `router.js`, `database.js`, and `security.js` all containing
```javascript
define({});
```

running the following code from inside example directory

```coffeescript
requirejs = require 'requirejs'

requirejs.config
  baseUrl = ''
  nodeRequire: require

requirejs ['rq-dir!configDir', 'path'], (dir, path) ->
  config = {}
  for filename, content of dir
    config[path.basename filename, '.js'] = content
  console.log config
```

will print (except for comments)

```javascript
{ database: {}, router: {},  security: {} }
```

## Todos

There should be an option to use another plugin for loading the files.
