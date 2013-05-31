object @album
attributes :id, :name, :length

node do |a|
  { :tracks => a.songs.count }
end

node do |a|
  { :art => a.art.data_file.path }
end

node do |a|
  { :artist => a.artist.name }
end