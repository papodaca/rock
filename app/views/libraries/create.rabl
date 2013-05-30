object @library
attributes :id, :name, :progress

glue :data_file do
  attributes :path
end

node :songs do |library|
  library.songs.count
end