require "bundler/gem_tasks"
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rake/clean'

CLEAN.include('pkg')

RSpec::Core::RakeTask.new('spec')

task :default => :build
