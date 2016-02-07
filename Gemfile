source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password

gem 'awesome_print'
gem 'thin'
gem 'bootstrap-sass', '~> 3.3.6'
gem "font-awesome-rails"
gem 'stamp'
gem 'pg'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'sqlite3'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'quiet_assets'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

