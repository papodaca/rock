require 'taglib'
require 'find'
require 'lastfm'

class LibraryWorker
	def scan(libraryId)
		library = Library.find(libraryId)
		rootPath = library.data_file.path
		return false unless File.directory?(rootPath)

		lfm = Lastfm.new(APP_CONFIG['lastfm_api_key'], APP_CONFIG['lastfm_api_secret'])

		totalFilesFound = Dir[File.join(rootPath, '**', '*')].count { |f| File.file?(f) }
		totalFilesProcessed = 0

		Find.find(rootPath) do |path|
			next if File.directory?(path)
			mediaType = getMediaType(path, :audio)
			next if mediaType == nil
			next if songExists?(path)

			data = {}

			TagLib::FileRef.open(path) do |file|
				t = file.tag
				p = file.audio_properties

				data = { :title => t.title.to_s(),
					:artist => t.artist.to_s(),
					:album => t.album.to_s(),
					:year => t.year.to_s(),
					:track => t.track.to_s(),
					:genre => t.genre.to_s(),
					:length => p.length.to_s()
				}
			end

			#get or create artist
			artist = Artist.where(:name => data[:artist]).first
			if artist == nil
				artId =  getArt(lfm.artist.get_info(:artist => data[:artist])['image'])
				artist = Artist.create(:name => data[:artist])
				artist.art_id = artId
				artist.save
			end

			#get or create album
			album = Album.where(:name => data[:album], :artist_id => artist.id).first
			if album == nil
				artId = getArt(lfm.album.get_info(:artist => data[:artist], :album => data[:album])['image'])
				album = Album.create(:name => data[:album])
				album.artist_id = artist.id
				album.art_id = artId
				album.save
			end

			#get or create genre
			genre = Genre.where(:name => data[:genre]).first
			if genre == nil
				genre = Genre.create(:name => data[:genre])
				genre.save
			end

			#create dataFile
			data_file = DataFile.create(:path => path)
			data_file.media_type_id = mediaType.id
			data_file.save

			song = Song.create(:disk => 0, :length => data[:length], :title => data[:title], :track => data[:track])

			song.album_id = album.id
			song.artist_id = artist.id
			song.genre_id = genre.id
			song.data_file_id = data_file.id
			song.library_id = library.id
			song.save

			totalFilesProcessed += 1
			library.progress = ((Float(totalFilesProcessed) / Float(totalFilesFound)) * 100).floor
			library.save
		end
		library.progress = nil
		library.save
	end
	handle_asynchronously :scan

	def getMediaType(path, selector)
		ext = getExtension(path)
		return nil if ext == nil or ext == ""
		return MediaType.where(selector => true, :extension => ext).first
	end
	def getExtension(path)
		return /\.([0-9a-zA-Z]+)$/.match(path).captures.first
	end
	def getArt(images)
		begin
			art = images[images.index { |x| x['size'] == "large"}]['content']
			dataArt = DataFile.create(:path => art)
			dataArt.media_type_id = getMediaType(art, :image).id
			dataArt.save
			art = Art.create(:data_file_id => dataArt.id)
			return art.id
		rescue Lastfm::ApiError
			return nil
		end
	end
	def songExists?(path)
		return true if DataFile.where(:path => path).count > 0
		return false
	end
end