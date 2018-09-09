class ApplicationController < ActionController::API

  attr_reader :current_user

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

  protected

    def authenticate_request!
      unless user_id_in_token?
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        return
      end
      @current_user = User.find(BSON::ObjectId.from_string(auth_token[:user_id]))
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end

  private

    def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    end

    def user_id_in_token?
      http_token && auth_token && auth_token[:user_id].to_i
    end
end
