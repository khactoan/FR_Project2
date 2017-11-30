source "https://rubygems.org"

git_source :github do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include? "/"
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.6"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "devise"
gem "paperclip", "~> 4.1"
gem "will_paginate", "~> 3.1.0"
gem "config"
gem "bootstrap-sass", "~> 3.3.7"
gem "omniauth-facebook", "~> 4.0"
gem "activerecord-session_store", "~> 1.0"
gem "omniauth-google-oauth2", "~> 0.4.1"
gem "acts-as-taggable-on", "~> 4.0"
gem "rubyzip", "~> 1.1.0"
gem "axlsx", "2.1.0.pre"
gem "axlsx_rails"
gem "social-share-button", "~> 0.1.6"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec"
  gem "rspec-rails"
  gem "rspec-collection_matchers"
  gem "factory_bot_rails"
  gem "better_errors"
  gem "guard-rspec", require: false
  gem "database_cleaner"
  gem "brakeman", require: false
  gem "jshint"
  gem "bundler-audit"
  gem "rubocop", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "rails_best_practices"
  gem "reek"
  gem "railroady"
  gem "autoprefixer-rails"
  gem "sqlite3"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "dotenv", "~> 2.2.1"
end

group :test do
  gem "simplecov", require: false
  gem "simplecov-rcov", require: false
  gem "simplecov-json"
  gem "shoulda-matchers"
end

group :production do
  gem "pg", "0.20.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
