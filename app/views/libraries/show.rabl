object @library
attributes :id, :name, :progress

node do |library|
  path = /([s,S]3:\/\/\S+).+$/.match(library.data_file.path)
  { :path => path != nil ? path[1] : library.data_file.path }
end

node :songs do |library|
  library.songs.count
end