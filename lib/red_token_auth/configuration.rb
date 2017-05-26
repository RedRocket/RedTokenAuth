module RedTokenAuth
  class Configuration
    attr_accessor :email_regex
    attr_accessor :password_length

    def initialize
      # Basically, just make sure there only one "@" in the email.
      @email_regex = /\A[^@\s]+@[^@\s]+\z/
      @password_length = 8..20
    end
  end
end
