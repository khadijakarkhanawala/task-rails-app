class SearchService

  def self.get_search_data params
    
    data = Hash.new
    data[:books] = Book.get_search_data(params[:search])
    data[:authors] = Author.get_search_data(params[:search])

    return data
  end

end