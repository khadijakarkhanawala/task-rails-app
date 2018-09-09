class CommonController < ApplicationController
  before_action :authenticate_request!

  # POST /search
  def search
    if params[:search].blank?
      render_error("Search Field can't be blank")
      return
    end

    search_result = SearchService.get_search_data(params)

    render_success_response(search_result)
  end

end
