module PaginateHelper
  def formPagenationResponce(collection, view)
    [paginate(collection), JSON.parse(Rabl.render(collection, view, :view_path => 'app/views', :format => :json))]
  end

  def paginate(collection)
    current_page = collection.current_page
    last_page = collection.total_pages
    per_page = collection.per_page
    collection_count = collection.count

    {
      :page => current_page,
      :total_entries => collection_count,
      :total_pages => last_page,
      :per_page => per_page
    }
  end
end