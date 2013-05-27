class LibraryWorker
	def scan(libraryId)
		library = Library.find(libraryId)
		for k in 1..100 do 
			sleep(0.1)
			library.progress = k
			library.save
		end
		library.progress = nil
		library.save
	end
	handle_asynchronously :scan
end