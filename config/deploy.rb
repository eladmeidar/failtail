set :application, "failtale"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :repository,  "git://github.com/mrhenry/failtale.git"
set :scm, "git"

set :deploy_via, :remote_cache
set :branch, "master"

role :app, "failtale.be"
role :web, "failtale.be"
role :db,  "failtale.be", :primary => true