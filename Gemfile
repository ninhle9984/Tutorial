source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"
gem "sqlite3"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootstrap-sass", "3.3.7"
gem "config"
gem "bcrypt", "3.1.11"
gem "hirb"
gem "jquery-rails"
gem "faker"
gem "will_paginate", "3.1.6"
gem "bootstrap-will_paginate", "1.0.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "factory_bot_rails"
  gem "better_errors"
  gem "guard-rspec", require: false
  gem "database_cleaner"
  gem "brakeman", require: false
  gem "jshint"
  gem "bundler-audit"
  gem "rubocop", "~> 0.51.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "rails_best_practices"
  gem "reek"
  gem "railroady"
  gem "autoprefixer-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
