class ApplicationController < ActionController::Base
  include RedTokenAuth::Controllers::Authentication

  protect_from_forgery with: :exception
end
