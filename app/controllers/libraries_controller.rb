class LibrariesController < ApplicationController
	def index
		@libraries = Library.all
	end

	def create
		file = DataFile.create(:path => params[:path])
		newLibrary = Library.create(:name => params[:name], :data_file_id => file.id)
		worder_id = LibraryWorker.asynch_search(:library => newLibrary)
		newLibrary.set(:workder_id => worder_id)
		newLibrary.save
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
end
