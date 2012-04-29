require "rspec/core/rake_task"

desc "Run rspec tests"
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*_spec.rb'
    t.rspec_opts = %w{--color --format documentation}
  end
end

task :default => :spec
