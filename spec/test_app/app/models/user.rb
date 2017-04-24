class User
  include Mongoid::Document
  include RedTokenAuth

  field :email,                        type: String
  field :password_digest,              type: String
  field :reset_password_token,         type: String
  field :reset_password_token_sent_at, type: Time
  field :authentication_token,         type: String
end
