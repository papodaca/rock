class LibrariesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @libraries = Library.all
  end

  def create
    file = DataFile.create(:path => params[:path])
    newLibrary = Library.create(:name => params[:name], :data_file_id => file.id, :progress => 0)
    LibraryWorker.perform_async(newLibrary.id)
    @library = newLibrary
  end

  def scan
    library = Library.find(params[:id])
    library.progress = 0
    library.save
    LibraryWorker.perform_async(library.id)
    @library = library
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
