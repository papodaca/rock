#This build requires execSync and wrench get then this way:
# npm install -g coffee-script
# npm install exec-sync wrench rimraf watch
# node asyncness makes this really diffucult

exec = require 'exec-sync'
child_process = require 'child_process'
rimraf = require 'rimraf'
rm = rimraf.sync
fs = require 'fs'
wrench = require 'wrench'
watch = require 'watch'

bin = 'webroot'
src = bin + '.src'
tmp = bin + '.tmp'
rootFiles = [
  'index.html'
  'index.php'
  '.htaccess'
  '404.html'
  'test.php'
]
rootDirs = [
  'js/vendor'
  'css'
  'fonts'
  'js/template'
]

copy = (srcFile, destFile) ->
  BUF_LENGTH = 64*1024
  buff = new Buffer(BUF_LENGTH)
  fdr = fs.openSync(srcFile, 'r')
  fdw = fs.openSync(destFile, 'w')
  bytesRead = 1
  pos = 0
  while bytesRead > 0
    bytesRead = fs.readSync(fdr, buff, 0, BUF_LENGTH, pos)
    fs.writeSync(fdw,buff,0,bytesRead)
    pos += bytesRead
  fs.closeSync(fdr)
  fs.closeSync(fdw)

task 'watch:debug', 'Watch for file changes. Build on change', ->
  watch.createMonitor 'webroot.src/', (monitor) ->
    monitor.on 'changed', (f, curr, prev) ->
      console.log '-----------------------------------------'
      console.log f
      console.log '-----------------------------------------'
      result = exec 'cake build:debug'
      console.log result

task 'watch:release', 'Watch for file changes. Build on change', ->
  watch.createMonitor 'webroot.src/', (monitor) ->
    monitor.on 'changed', (f, curr, prev) ->
      console.log '-----------------------------------------'
      console.log f
      console.log '-----------------------------------------'
      result = exec 'cake build:release'
      console.log result

task 'build:release', 'Build a release of the web client', ->
  invoke 'clean'
  invoke 'coffee:compile'
  invoke 'static'
  invoke 'r'
  invoke 'cleanup:r'
  return 0

task 'build:debug', 'Build a debug release of the web client', ->
  invoke 'clean'
  invoke 'coffee:compile'
  invoke 'static'
  invoke 'copy'
  invoke 'cleanup:tmp'
  return 0


task 'clean', 'Clean the build directory', ->
  console.log 'Cleaning...'
  wrench.rmdirSyncRecursive bin, true
  wrench.rmdirSyncRecursive tmp, true
  wrench.mkdirSyncRecursive bin
  wrench.mkdirSyncRecursive tmp


task 'coffee:compile', 'Compile coffee scource', ->
  console.log 'Compiling Coffee source...'
  exec 'coffee -b -c -o ' + tmp + '/js ' + src + '/js'
  wrench.rmdirSyncRecursive '-p', true


task 'static', 'Copy static files into temp directory', ->
  console.log 'Copying static files...'
  
  rootDirs.forEach (dir, index) ->
    source = './' + src + '/' + dir
    target = './' + tmp + '/' + dir
    wrench.mkdirSyncRecursive target
    wrench.copyDirSyncRecursive source, target, (error) ->
      console.log 'ERROR: ' + error if error

  rootFiles.forEach (file, index) ->
    source = './' + src + '/' + file
    target = './' + tmp + '/' + file
    copy source, target


task 'cleanup:tmp', 'Clean up temp directory', ->
  console.log 'Remove temp directory'
  wrench.rmdirSyncRecursive tmp, true


task 'copy', 'Copy contents of temp directory to output directory', ->
  console.log 'Copy to target'
  wrench.copyDirSyncRecursive './' + tmp, './' + bin, (error) ->
    console.log 'ERROR: ' + error if error


task 'r', 'Run the r.js minification for release', ->
  console.log 'Runing r.js'
  exec 'r -o app.build.js'


task 'cleanup:r', 'Clean up after r.js', ->
  console.log 'Clean up after r.js'
  invoke 'cleanup:tmp'
  wrench.rmdirSyncRecursive bin + '/css/vendor', true
  wrench.rmdirSyncRecursive bin + '/js/template', true
  rm bin + '/css/fonts.css'
  rm bin + '/build.txt'

