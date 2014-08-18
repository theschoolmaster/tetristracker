require 'bundler/capistrano'

set :application, "tetristracker"
set :repository,  "git@github.com:theschoolmaster/tetristracker.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "tetristracker.com"                          # Your HTTP server, Apache/etc
role :app, "tetristracker.com"                          # This may be the same as your `Web` server
role :db,  "tetristracker.com", :primary => true # This is where Rails migrations will run

set :scm, :git
set :deploy_via, :remote_cache
set :checkout, 'export'
set :keep_releases, 5
set :default_shell, "/bin/bash -l"
set :deploy_to, "/srv/#{application}_production"
b = self.variables[:branch] || "master" #enables the use of "cap deploy -S branch=branch-name" to set the branch for deployment.
set :branch, b
set :user, 'deploy'
set :use_sudo, false
set :bundle_without, [:development, :test]


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
after "deploy", "deploy:symlink_config_files"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
## namespace :deploy do
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared config files"
  task :symlink_config_files do
      run "ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
      run "ln -s #{ deploy_to }/shared/config/secrets.yml #{ current_path }/config/secrets.yml"
  end
end
