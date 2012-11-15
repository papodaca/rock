watch = require 'watch'
exec = require 'exec-sync'

watch.createMonitor 'webroot.src/', (monitor) ->
  monitor.on 'changed', (f, curr, prev) ->
    console.log '-----------------------------------------'
    console.log f
    console.log '-----------------------------------------'
    result = exec 'cake build:debug'
    console.log result
    