# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

gem "middleman", "~> 4.6.0"
gem "middleman-blog", "~> 4.0.1"

# For feed.xml.builder
gem "builder", "~> 3.0"
gem 'middleman-deploy', '~> 2.0.0.pre.alpha'
gem "middleman-sprockets", "~> 4.0.0"
gem 'nokogiri'

group :development do
  gem 'middleman-livereload'
end
gem "webrick", "~> 1.8"
# Temporary fix for https://github.com/middleman/middleman/issues/2569
gem 'haml', '~> 5.0'

gem 'sass', '~> 3.4' # fix errors running bundle exec middleman
gem "concurrent-ruby", "= 1.3.4" # pin per https://stackoverflow.com/a/79361221/1373987

gem "net-ftp", "~> 0.3.8"
