server "localhost", :web, :app, :db, primary: true

set :application, "jdeployer"
set :user, "rockyj"
set :deploy_to, "/home/#{user}/Temp/#{application}"
#set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:rocky-jaiswal/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :tomcat do
  task :build_with_maven do
    puts "echo pwd"
    run "pwd > /home/rockyj/delme"
  end
end

after "deploy", "tomcat:build_with_maven" # keep only the last 5 releases
after "tomcat:build_with_maven", "deploy:cleanup" # keep only the last 5 releases