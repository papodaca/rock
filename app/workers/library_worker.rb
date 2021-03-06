require 'taglib'
require 'find'
require 'glutton_lastfm'
require 'fog'

TMP_FILE_LOCATION = $APP_CONFIG["temp_dir"] + "/rockTempAudio"

class LibraryWorker
	include Sidekiq::Worker
	include AwsHelper

	def perform(libraryId)
		library = Library.find(libraryId)
		rootPath = library.data_file.path

		if isS3Bucket?(rootPath)
			puts "scan S3 bucket"
			scanS3Bucket(rootPath, library)
		elsif File.directory?(rootPath)
			puts "scan local dir"
			scanLocalDir(rootPath, library)
		else
			return false
		end

		puts "finished"
		library.progress = nil
		library.save
	end

	def scanLocalDir(rootPath, library)
		totalFilesFound = Dir[File.join(rootPath, '**', '*')].count { |f| File.file?(f) }
		totalFilesProcessed = 0
		puts "found #{totalFilesFound} files."

		Find.find(rootPath) do |path|
			next if File.directory?(path)
			puts "not a directory"
			mediaType = getMediaType(path, :audio)
			next if mediaType == nil
			puts "mediatype found #{mediaType.extension}"
			next if songExists?(path)

			puts "scanning #{path}"

			data = getFileData(path)
			saveSong(data, path, mediaType.id, library.id)

			totalFilesProcessed += 1
			updateLibrary(library, totalFilesProcessed, totalFilesFound)
		end
	end

	def scanS3Bucket(rootPath, library)
		bucket = getS3Bucket(rootPath)

		puts "processing bucket: #{bucket.key}"

		totalFilesFound = bucket.files.count { |f| f.content_length>0 }
		totalFilesProcessed = 0

		bucket.files.each do |file|
			next if file.content_length <= 0
			puts "file: " + file.key
			mediaType = getMediaType(file.key, :audio)
			next if mediaType == nil
			path = "S3://#{bucket.key}/#{file.key}"
			next if songExists?(path)
			tmpFile = TMP_FILE_LOCATION + "." + mediaType.extension
			
			puts "downloading: #{file.key} > #{tmpFile}"
			localFile = File.open(tmpFile, "wb")
			localFile.write(file.body)
			localFile.close

			data = getFileData(tmpFile)
			saveSong(data, path, mediaType.id, library.id)

			File.delete(tmpFile)
			totalFilesProcessed += 1
			updateLibrary(library, totalFilesProcessed, totalFilesFound)
		end
	end

	def updateLibrary(library, totalFilesProcessed, totalFilesFound)
			library.progress = ((Float(totalFilesProcessed) / Float(totalFilesFound)) * 100).floor
			library.save
			puts "scanned #{library.progress}%"
	end

	def saveSong(data, path, mediaTypeId, libraryId)

		#get or create artist
		artist = Artist.where(:name => data[:artist]).first
		if artist == nil
			puts "creating album"
			artId =  getArt(data[:artist])
			artist = Artist.create(:name => data[:artist])
			artist.art_id = artId
			artist.save
		end
		puts "have artist: #{artist.id.to_s()}"

		#get or create album
		album = Album.where(:name => data[:album], :artist_id => artist.id).first
		if album == nil
			puts "creating album"
			artId = getArt(data[:artist], data[:album])
			album = Album.create(:name => data[:album])
			album.artist_id = artist.id
			album.art_id = artId
			album.save
		end
		puts "have album: #{album.id.to_s()}"

		#get or create genre
		genre = Genre.where(:name => data[:genre]).first
		if genre == nil
			genre = Genre.create(:name => data[:genre])
			genre.save
		end

		#create dataFile
		data_file = DataFile.create(:path => path)
		data_file.media_type_id = mediaTypeId
		data_file.save

		song = Song.create(:disk => 0, :length => data[:length], :title => data[:title], :track => data[:track])

		song.album_id = album.id
		song.artist_id = artist.id
		song.genre_id = genre.id
		song.data_file_id = data_file.id
		song.library_id = libraryId
		song.save
	end

	def getFileData(path)
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
		return data
	end

	def isS3Bucket?(path)
		/[s,S]3:\/\/.+$/.match(path) != nil
	end
	def getMediaType(path, selector)
		ext = getExtension(path)
		return nil if ext == nil or ext == ""
		return MediaType.where(selector => true, :extension => ext).first
	end
	def getExtension(path)
		matches = /\.([0-9a-zA-Z]+)$/.match(path)
		return matches.captures.first if matches != nil
		return nil
	end
	def getArt(artist, album = nil)
		begin
			lfm = GluttonLastfm.new($APP_CONFIG['lastfm_api_key'])
			images = nil
			if album != nil
				images = lfm.album_info(artist, album)['image']
			else
				images = lfm.artist_info(artist)['image']
			end
			art = images[images.index { |x| x['size'] == "large"}]['__content__']
			dataArt = DataFile.create(:path => art)
			mediaType = getMediaType(art, :image)
			return nil if mediaType == nil
			dataArt.media_type_id = mediaType.id
			dataArt.save
			art = Art.create(:data_file_id => dataArt.id)
			if art != nil
				return art.id
			else
				return nil
			end
		rescue GluttonLastfm::Unauthorized, GluttonLastfm::NotFound, GluttonLastfm::QueryStatusFail, GluttonLastfm::QueryArgumentFail, GluttonLastfm::UnknownFail, REXML::ParseException
			return nil
		end
	end
	def songExists?(path)
		return true if DataFile.where(:path => path).count > 0
		return false
	end
end