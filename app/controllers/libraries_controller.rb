class LibrariesController < ApplicationController
	def index
		result = Library.all()
		result.each do |lib|
			lib[:data_file] = DataFile.find(lib[:data_file_id])
		end
		render :json => result
	end

	def page
		count = params[:count] ? params[:count].to_i : 50
		page = count * (params[:page].to_i - 1)
		result = Library.limit(count).offset(page)
		result.each do |lib|
			lib[:data_file] = DataFile.find(lib[:data_file_id])
		end
		render :json => result
	end

	def create
		file = DataFile.create(:path => params[:path])
		result = Library.create(:name => params[:name], :data_file_id => file.id)
		render :json => result
	end

	def show
		
	end

	def update

	end

	def destroy

	end
end
