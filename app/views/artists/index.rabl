collection @artists
attributes :id, :name

node do |a|
  { :songs => a.songs.count }
end

node do |a|
  { :albums => a.albums.count }
end

node do |a|
  { :art => a.art.data_file.path }
end
