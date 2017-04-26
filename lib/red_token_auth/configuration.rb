module RedTokenAuth
  class Configuration
    attr_accessor :email_regex
    attr_accessor :password_regex
    attr_accessor :password_length

    def initialize
      # Basically, just make sure there only one "@" in the email.
      @email_regex = /\A[^@\s]+@[^@\s]+\z/
      # Make sure there is at least one character and one number.
      @password_regex = /^(?=.*?[a-z])(?=.*?[0-9]).{0,}$/
      @password_length = 8..20
    end
  end
end
