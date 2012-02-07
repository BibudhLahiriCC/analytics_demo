#source 'http://rubygems.org'
source :rubygems

#gem 'rails', '3.1.1'
gem 'rails', '3.0.9'

gem 'haml'
gem 'json'
gem 'simple_form'
#gem 'pg'

platforms :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbc-adapter'
  gem 'jdbc-postgres'
  # gem 'activerecord-oracle_enhanced-adapter'
  gem 'mondrian-olap', :git => 'git://github.com/rsim/mondrian-olap.git'
  # gem 'mondrian-olap', :path => '/Users/bibudhlahiri/rails_projects/mondrian-olap'
  gem 'kirk', '~> 0.2.0.beta.7'
end

group :development, :test do
  gem 'awesome_print', :require => 'ap'
  gem "nifty-generators"
end
