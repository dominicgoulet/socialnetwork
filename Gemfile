# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Core
gem 'pg', '1.5.3'
gem 'puma', '6.2.2'
gem 'rails', '7.0.6'
gem 'redis', '~> 4.0'

# Security
gem 'bcrypt', '3.1.18'
gem 'omniauth', '2.1.1'
gem 'omniauth-google-oauth2', '1.1.1'

# Frontend
gem 'importmap-rails', '1.1.6'
gem 'inline_svg', '1.9.0'
gem 'sprockets-rails', '3.4.2'
gem 'stimulus-rails', '1.2.1'
gem 'turbo-rails', '1.4.0'

# Sorbet
gem 'sorbet-rails', '0.7.34'
gem 'sorbet-runtime', '0.5.10801'

# Others
gem 'bootsnap', '1.16.0', require: false
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'annotate'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'guard'
  gem 'guard-minitest'
  gem 'rubocop', require: false
  gem 'sorbet'
  gem 'tapioca', require: false
end

group :development do
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem 'capybara'
  # gem 'selenium-webdriver'
  # gem 'webdrivers'
  gem 'database_cleaner-active_record'
  gem 'shoulda-context', '2.0.0'
  gem 'shoulda-matchers', '5.3.0'
  gem 'simplecov', require: false
end

gem 'tailwindcss-rails', '~> 2.0'

gem 'hotwire-livereload', '~> 1.2'
