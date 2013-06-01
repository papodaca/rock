object @playlist
attributes :id, :name, :length

node do |a|
  { :songs => a.songs.count }
end