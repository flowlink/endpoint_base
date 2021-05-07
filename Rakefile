require 'bundler/gem_tasks'

# Need to run the Rails and Sinatra specs separately so
# their dependencies won't pollute each other.

task spec: [:spec_sinatra, :spec_rails]

task :spec_sinatra do
  puts 'Running Sinatra specs -------------------'
  system 'FROM_RAKE=1 bundle exec rspec spec/sinatra'
  unless exitcode = $?.exitstatus == 0
    exit exitcode
  end
end

task :spec_rails do
  puts 'Running Rails specs ---------------------'
  system 'FROM_RAKE=1 bundle exec rspec spec/rails'
  unless exitcode = $?.exitstatus == 0
    exit exitcode
  end
end
