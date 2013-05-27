class LibrariesController < ApplicationController
	def index
		@libraries = Library.all
	end

	def create
		file = DataFile.create(:path => params[:path])
		newLibrary = Library.create(:name => params[:name], :data_file_id => file.id, :progress => 0)
		LibraryWorker.new.scan(newLibrary.id)
		@library = newLibrary
	end

	def show
		@library = Library.find(params[:id])
	end

	def update
		library = Library.find(params[:id])
		file = DataFile.find(library.data_file_id)
		file.path = params[:path]
		file.save
		library.name = params[:name]
		library.save
		@library = library
	end

	def destroy
		Library.destroy(params[:id])
		render :text => "OK"
	end


	def scan(libraryId)
		library = Library.find(libraryId)
		for k in 1..100 do 
			sleep(0.5)
			library.progress = k
			library.save
		end
		library.progress = nil
		library.save
	end
end
