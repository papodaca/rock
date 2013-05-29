object @songs
attributes :id, :title, :track

glue :artist do
	attributes :name => :artist
end

glue :album do
	attributes :name => :album
end