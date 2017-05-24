# RedTokenAuth

### _This gem is currently under development._

Token based authentication gem for a Rails + Mongoid.

We decided to build this gem after trying to use some some other token authentication gems that needed Devise and it didn't work out well with Mongoid.

RedTokenAuth goal is to provide a simple authentication interface for Rails using Mongoid.




## Installation
Add this line to your application's Gemfile:

```ruby
gem 'red_token_auth'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install red_token_auth

```
## Usage
You'll be able to include the module in the model like so.

(Pay attention to the fields, because **ALL** of them are **REQUIRED** for the proper use of this gem.
```ruby
class User
  include Mongoid::Document
  include RedTokenAuth

  # Mandatory fields for this gem.
  field :email,                        type: String
  field :password_digest,              type: String
  field :reset_password_token,         type: String
  field :reset_password_token_sent_at, type: Time
  field :authentication_token,         type: String
end
```

And you must include other module in your controller:
```ruby
class ApplicationController < ActionController::API
  include RedTokenAuth::Controllers::Authentication
end
```

Authenticating the user:
```ruby
class UsersController < ApplicationController
  before_action only: [:update] { authenticate! :admin }
  before_action only: [:show]   { authenticate! :user }

  def update
    @admin = current_admin
    # Code ...
  end

  def show
    @user = current_user
  end
end
```
By using the `authenticate!(:user)` in your controller, you'll have access to `current_user`.

### Included methods
* `User#sign_in`

  It'll return `User#create_new_authentication_token` if `"password"` matches the user password and an `authentication_token` will be generated for the user. If it doesn't match, errors will be added to `User#errors` and `false` will be returned.

  ```ruby
  user.sign_in("password")
  ```

* `User#sign_out`

  The user's `authentication_token` will be set to `nil`. Returns `true` if the update is successful and `false` Otherwise.

  ```ruby
  user.sign_out
  ```

* `User#generate_password_token`

  A random token will be generated and stored in `User#reset_password_token`. You'll probably be sending this token to the user via email or push notifications so they can then change their password.

  ```ruby
  user.generate_password_token
  ```

* `User#update_password`

  This method is used when the user wants to update their password. If the current password doesn't match errors will be added to `User#errors` and false will be returned. Otherwise it'll return `true`.
  ```ruby
  user.update_password(current_password: "password", password: "new_password", password_confirmation: "new_password")
  ```

* `User#reset_password`

  This method is used after the `User#generate_password_token` and the `User#reset_password_token` now stores a token.
  ```ruby
  user.reset_password(reset_password_token: "token", password: "new_password", password_confirmation: "new_password")
  ```

* `User#create_new_authentication_token`

  This method will create new authentication token for the user and will return a hash that can be appended to the headers.
  ```ruby
    user.create_new_authentication_token
    #=> {"access-token" => "==wei2989896756-_", "uid" => "email@email.com", "token-type" => "Bearer"}

    # In controller scope:
    request.headers.merge!(user.create_new_authentication_token)
  ```

### Configuring
```ruby
RedTokenAuth.configure do |config|
  config.email_regex = /\A[^@\s]+@[^@\s]+\z/
  config.password_regex = /\A(?=.*?[a-z])(?=.*?[0-9]).{0,}\z/
  config.password_length = 8..20
end
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

