collection @genres
attributes :id, :name

node do |a|
  { :songs => a.songs.count }
end