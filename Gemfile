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
gem 'faker'
gem 'populator'
gem "paperclip", "~> 4.3"
gem 'figaro'
gem 'aws-sdk', '< 2'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem "selenium-webdriver"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'quiet_assets'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'capybara'
  gem 'launchy'
  gem 'connection_pool'
end

