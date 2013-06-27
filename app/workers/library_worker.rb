require 'taglib'
require 'find'
require 'lastfm'
require 'fog'

TMP_FILE_LOCATION = APP_CONFIG["temp_dir"] + "/rockTempAudio"

class LibraryWorker
	def scan(libraryId)
		library = Library.find(libraryId)
		rootPath = library.data_file.path

		if isS3Bucket?(rootPath)
			puts "scan S3 bucket"
			scanS3Bucket(rootPath, library)
		elsif File.directory?(rootPath)
			pust "scan local dir"
			scanLocalDir(rootPath, library)
		else
			return false
		end

		puts "finished"
		library.progress = nil
		library.save
	end
	##handle_asynchronously :scan

	def scanLocalDir(rootPath, library)
		totalFilesFound = Dir[File.join(rootPath, '**', '*')].count { |f| File.file?(f) }
		totalFilesProcessed = 0

		Find.find(rootPath) do |path|
			next if File.directory?(path)
			mediaType = getMediaType(path, :audio)
			next if mediaType == nil
			next if songExists?(path)

			data = getFileData(path)
			saveSong(path, mediaType.id, library.id)

			totalFilesProcessed += 1
			updateLibrary(library, totalFilesProcessed, totalFilesFound)
		end
	end

	def scanS3Bucket(rootPath, library)
		captures = /[S,s]3:\/\/([^\s]+)\/([^\s]+)\ ([^\s]+)\ ([^\s]+)$/.match(rootPath).captures

		connection = Fog::Storage.new(
			:provider => 'AWS',
			:aws_access_key_id => captures[2],
			:aws_secret_access_key => captures[3],
			:region => captures[0])

		bucket = captures[1]

		puts "processing bucket: " + bucket

		totalFilesFound = connection.directories.get(bucket).files.count { |f| f.content_length>0 }
		totalFilesProcessed = 0

		connection.directories.get(bucket).files.each do |file|
			next if file.content_length <= 0
			puts "file: " + file.key
			mediaType = getMediaType(file.key, :audio)
			next if mediaType == nil
			path = "S3://#{bucket}/#{file.key}"
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
	end

	def saveSong(data, path, mediaTypeId, libraryId)
		lfm = Lastfm.new(APP_CONFIG['lastfm_api_key'], APP_CONFIG['lastfm_api_secret'])

		#get or create artist
		artist = Artist.where(:name => data[:artist]).first
		if artist == nil
			puts "creating album"
			artId =  getArt(lfm.artist.get_info(:artist => data[:artist])['image'])
			artist = Artist.create(:name => data[:artist])
			artist.art_id = artId
			artist.save
		end
		puts "have artist: #{artist.id.to_s()}"

		#get or create album
		album = Album.where(:name => data[:album], :artist_id => artist.id).first
		if album == nil
			puts "creating album"
			artId = getArt(lfm.album.get_info(:artist => data[:artist], :album => data[:album])['image'])
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
	def getArt(images)
		begin
			art = images[images.index { |x| x['size'] == "large"}]['content']
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
		rescue Lastfm::ApiError
			return nil
		end
	end
	def songExists?(path)
		return true if DataFile.where(:path => path).count > 0
		return false
	end
end