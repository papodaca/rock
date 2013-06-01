object @song
attributes :id, :title, :track, :length

glue :artist do
  attributes :name => :artist
end

glue :album do
  attributes :name => :album
end

glue :genre do
  attributes :name => :genre
end