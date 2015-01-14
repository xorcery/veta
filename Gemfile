source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.0'
# Use postgres as the database for Active Record
gem 'pg', '~> 0.17.1'
#Authentication / Authorization
gem 'devise', '~> 3.3.0'

# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'modernizr-rails', '~> 2.6.2'
gem 'bootstrap-sass', '~> 3.2.0.2'
gem 'autoprefixer-rails', '~> 3.1.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.0.4'
gem 'jquery-ui-rails', '~> 4.1.1'

#versioning of model changes
gem 'paper_trail', '~> 3.0.6'
gem 'aasm', '~> 4.0.0'

# Display utilities
gem 'simple_form', '~> 3.0.1'
gem 'best_in_place', '~> 3.0.0'

#Background processing
gem 'sidekiq', '~> 3.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.1.3'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

#Web Server
gem 'sinatra', require: false
gem 'slim'
gem 'unicorn'

#Charting
gem "highcharts-rails", "~> 4.0"

#Deployment
gem 'mina'
gem 'mina-sidekiq', :require => false
gem 'mina-unicorn', :require => false

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'bullet'
  gem "spring"
end

group :production do
  gem 'rails_12factor'
end

