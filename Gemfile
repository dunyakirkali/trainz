source 'https://rubygems.org'

ruby '2.2.4'

gem 'rails', '4.0.13'
gem 'pg', '~> 0.17.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.1.0'
gem 'jquery-ui-rails', '~> 4.2.0'
gem 'jbuilder', '~> 1.2'
gem 'slim-rails', '~> 2.1.0'
gem 'compass-rails', '~> 2.0.4'
gem 'rack-google-analytics', '~> 1.2.0'
gem 'overpass-api-ruby', require: 'overpass_api_ruby'
gem 'countries', require: 'countries/global'

group :doc do
  gem 'sdoc', require: false
end

group :production, :staging do
  gem 'rails_12factor'
end

group :test do
  gem 'rspec-rails'
end

group :development do
  gem 'pry-rails'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-foundation', '~> 5.5.3'
  gem 'rails-assets-buzz', '~> 1.1.10'
  gem 'rails-assets-chosen', '~> 1.4.2'
  gem 'rails-assets-d3', '~> 3.5.12'
  gem 'rails-assets-angularjs', '~> 1.4.8'
end
