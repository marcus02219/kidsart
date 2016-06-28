source 'https://rubygems.org'
ruby '2.2.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'

gem 'thin'


gem 'omniauth-facebook'
gem 'haml-rails'
gem 'haml2slim'
gem 'html2haml'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
#Use Grape for API
gem 'grape'
gem 'hashie-forbidden_attributes'

#facebook message
gem 'xmpp4r_facebook'
gem 'fb_graph'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Use MongoID
gem 'mongoid', git: 'git://github.com/mongoid/mongoid.git'
gem 'delayed_job_mongoid', :github => 'shkbahmad/delayed_job_mongoid'
gem 'will_paginate_mongoid'
# Use carrierwave for upload document and image
gem 'carrierwave', :git => "git://github.com/jnicklas/carrierwave.git"
gem 'mini_magick'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

# Use amazon service for image uploader
gem 'aws-sdk'
gem 'aws-ses'
gem 'fog'
gem 'unf'
#gem 'rmagick'
gem 'mini_magick'
gem 'devise'
gem 'devise-bootstrap-views'
#gem 'devise-token_authenticatable'


gem 'simple_token_authentication'

gem 'redis'
gem 'resque'
gem 'figaro'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'letter_opener'
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

gem 'puma'
gem 'unicorn'
