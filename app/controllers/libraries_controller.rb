class LibrariesController < ApplicationController
	def index
		@libraries = Library.all
	end

	def create
		file = DataFile.create(:path => params[:path])
		result = Library.create(:name => params[:name], :data_file_id => file.id)
		render :json => result
	end

	def show
		@library = Library.find(params[:id])
	end

	def destroy
		Library.find(param[:id]).destroy
	end
end
