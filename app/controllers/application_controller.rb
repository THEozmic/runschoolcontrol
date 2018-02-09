class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  before_action :authenticate_request
  attr_reader :current_school
  
  include ExceptionHandler


  # [...]
  private
  def authenticate_request
    @current_school = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_school
  end
end
