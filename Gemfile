source 'https://rubygems.org'

#Define the ruby version
ruby '1.9.3'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'config_reader', '0.0.8' #ENV specific configuration
gem 'backbone-on-rails'
gem 'google-analytics-rails'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem "less-rails"
  gem 'bootstrap-sass'
end

gem 'jquery-rails'

group :development do
  gem 'pry'
  gem 'mailcatcher'
  gem 'debugger'
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'rvm-capistrano'
end

group :development, :test do
	gem 'rspec'
	gem 'rspec-rails'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'front_end_static_page', :path => "vendor/engines/front_end_static_page"
gem 'back_end_static_page', :path => "vendor/engines/back_end_static_page"