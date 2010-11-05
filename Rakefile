begin
  require 'jeweler'
  require './lib/netzke/persistence/version'
  Jeweler::Tasks.new do |gem|
    gem.version = Netzke::Persistence::VERSION
    gem.name = "netzke-persistence"
    gem.summary = "Persistence subsystem for the Netzke framework"
    gem.description = "A drop-in gem to enable persistence in Netzke components"
    gem.email = "sergei@playcode.nl"
    gem.homepage = "http://netzke.org"
    gem.authors = ["Sergei Kozlov"]
    gem.post_install_message = <<-MESSAGE

========================================================================

           Thanks for installing netzke-persistence!

  Don't forget to run "rails generate netzke:persistence"

  Netzke home page:     http://netzke.org
  Netzke Google Groups: http://groups.google.com/group/netzke
  Netzke tutorials:     http://blog.writelesscode.com

========================================================================

    MESSAGE

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  require './lib/netzke/persistence/version'
  version = Netzke::Persistence::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "netzke-persistence #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('CHANGELOG*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :rdoc do
  desc "Publish rdocs"
  task :publish => :rdoc do
    `scp -r rdoc/* fl:www/api.netzke.org/persistence`
  end
end