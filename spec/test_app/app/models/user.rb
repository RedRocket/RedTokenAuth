class User
  include Mongoid::Document
  include RedTokenAuth

  # Mandatory fields for this gem.
  field :email,                        type: String
  field :password_digest,              type: String
  field :reset_password_token,         type: String
  field :reset_password_token_sent_at, type: Time
  field :authentication_token,         type: String
  # You'll need these fields if you are working with Omniauth.
  field :uid,                          type: String
  # Default must be "email".
  field :provider,                     type: String, default: "email"
end
