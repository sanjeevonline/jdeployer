Simple JavaEE6 app to test deployment with Capistrano

#If you are a Java programmer

1. Install Ruby using RVM or RBENV (Ruby 1.9.3 is preferred)
2. Run "gem install capistrano"
3. Go to your Java project root directory and run "capify"
4. This will create the capistrano config file.
5. Copy the contents of this project's config/deploy.rb to your config/deploy.rb
6. Change the variables at the top of this deploy file according to your machine
7. Run "cap deploy"

__Note__

So far only the Maven build and war copy to Tomcat works.

We need to fix starting and stopping Tomcat from Capistrano.