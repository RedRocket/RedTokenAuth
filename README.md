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
You'll be able to include the module in the model like so:
```ruby
class User
  include Mongoid::Document
  include RedTokenAuth
end
```
### Included methods
* `User#sign_in`
  
  It'll return `true` if `"password"` matches the user password and an `authentication_token` will be generated for the user. If it doesn't match, errors will be added to `User#errors` and `false` will be returned.
  
  ```ruby
  user.sign_in("password")
  ```
  
* `User#sign_out`
  
  If the token matches the user `authentication_token`, it'll be set to `nil` and return `true`. If it doesn't match, errors will be added to `User#errors` and false will be returned.
  
  ```ruby
  user.sign_out("auth_token")
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
  user.update_password(reset_password_token: "token", password: "new_password", password_confirmation: "new_password")
  ```
  


## Contributing
To do.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

