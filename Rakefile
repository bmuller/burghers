require "bundler/gem_tasks"
require 'rdoc/task'
require 'rake/testtask'

RDoc::Task.new("doc") { |rdoc|
  rdoc.title = "Burghers - Yet another Open Calais gem"
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
}

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :test
