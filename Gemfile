source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'bcrypt'
gem 'rails', '~> 5.1.4'     # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg'                    # Use postgresql as the database for Active Record
gem 'puma', '~> 3.7'        # Use Puma as the app server
gem 'sass-rails', '~> 5.0'  # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'  # Use Uglifier as compressor for JavaScript assets# See https://github.com/rails/execjs#readme for more supported runtimes# gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'# Use CoffeeScript for .coffee assets and views
gem 'turbolinks', '~> 5'    # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jbuilder', '~> 2.5'    # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder# Use Redis adapter to run Action Cable in production# gem 'redis', '~> 3.0'# Use ActiveModel has_secure_password# gem 'bcrypt', '~> 3.1.7'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'httparty'
gem 'nokogiri'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap', '~> 4.0.0.beta'
gem 'twilio-ruby', '~> 5.4.0'

group :production do
  gem 'rails_12factor'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
end


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'capybara', '~> 2.13'                           # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver'
  gem 'hirb'
  gem 'pry-rails'
  gem 'rails-erd'
end

group :development do
  gem 'web-console', '>= 3.3.0'       # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'spring'                        # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

