Rails.application.routes.draw do
  mount RedTokenAuth::Engine => "/red_token_auth"
end
