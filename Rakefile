# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "kibali"
  gem.homepage = "http://github.com/dsaronin@gmail.com/kibali"
  gem.license = "MIT"
  gem.summary = %Q{rails role authentication}
  gem.description = %Q{simple Rails role authentication}
  gem.email = "dsaronin@gmail.com"
  gem.authors = ["Daudi Amani"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new

# ------------------------------------------------------------------------
# don't use normal Rake test routine because of double factory_girl
# ------------------------------------------------------------------------
task :test do
   ruby '-I test "test/test_kibali.rb"'
   ruby '-I test "test/test_access.rb"'
end # test task

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "kibali #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
