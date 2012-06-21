server "localhost", :web, :app, :db, primary: true

set :user, "rockyj"
set :application, "jdeployer"

set :java_home, "/home/#{user}/jdk1.7.0_04"
set :tomcat_home, "/home/#{user}/Apps/apache-tomcat-7.0.23"
set :maven_home, "/home/#{user}/Apps/apache-maven-3.0.3"
set :deploy_to, "/home/#{user}/Temp/#{application}"

#set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:rocky-jaiswal/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :tomcat do
  task :build_deploy_restart do
    puts "==================Building with Maven======================"
    run "export JAVA_HOME=#{java_home} && cd #{deploy_to}/current && #{maven_home}/bin/mvn clean package"
    puts "==================Stop Tomcat======================"
    run "export JAVA_HOME=#{java_home} && #{tomcat_home}/bin/shutdown.sh"
    puts "==================Copy war to Tomcat======================"
    run "cp #{deploy_to}/current/target/#{application}*.war #{tomcat_home}/webapps/#{application}.war"
    puts "==================Start Tomcat======================"
    run "export JAVA_HOME=#{java_home} && #{tomcat_home}/bin/startup.sh"
    puts "==========================================================="
  end
end

after "deploy", "tomcat:build_deploy_restart" # keep only the last 5 releases
after "tomcat:build_deploy_restart", "deploy:cleanup" # keep only the last 5 releases