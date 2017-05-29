class User
  include Mongoid::Document
  include RedTokenAuth

  # Mandatory fields for this gem.
  field :email,                        type: String
  field :password_digest,              type: String
  field :reset_password_token,         type: String
  field :reset_password_token_sent_at, type: Time
  field :authentication_token,         type: String
  field :uid,                          type: String
  field :provider,                     type: String, default: "email"
end
