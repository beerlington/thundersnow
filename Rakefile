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
  gem.name = "thundersnow"
  gem.homepage = "http://github.com/beerlington/thundersnow"
  gem.license = "MIT"
  gem.summary = %Q{Ruby based command-line utility for viewing the weather}
  gem.description = %Q{Check the weather without leaving your terminal. Uses Google's weather API to provide current conditions and forecast weather information.}
  gem.email = "github@lette.us"
  gem.authors = ["Peter Brown"]
  gem.executables = ["thundersnow"]
  gem.add_runtime_dependency 'nokogiri', '~> 1.0'
  gem.add_runtime_dependency 'htmlentities'
  gem.add_development_dependency "rspec", "~> 2.3.0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "thundersnow #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
