class ApplicationController < ActionController::API

  def render_error message,code=400
    render :json =>{
      code: code,
      message: message
    }
  end

  def render_success_response data, code=200
    render :json => {
      code: code,
      data: data
    }
  end
end
