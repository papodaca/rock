module PaginateHelper
  def getPageValues
    page = params[:page].present? ? Integer(params[:page]) : 1
    count = params[:per_page].present? ? Integer(params[:per_page]) : Integer(APP_CONFIG['default_page_size'])
    return page, count
  end

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