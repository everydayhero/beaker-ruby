require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--format documentation --color'
end

task default: [:rubocop, :spec]
