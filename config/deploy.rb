default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Setup (taken mostly from http://forum.webfaction.com/viewtopic.php?id=4906)
# cap deploy:setup
# cap deploy:check
# 

set :application, "rails"
set :webfaction_username, "yakimapress"
set :webfaction_port, "29299"

set :webfaction_db_type, "mysql"
set :webfaction_db, "yakimapress_stag"
set :webfaction_db_username, "yakimapress_stag"
# set :database_yml_template, "database.yml"

set :deploy_to, "/home/#{webfaction_username}/webapps-releases/#{application}"
 
set :scm, :git
set :scm_user, "younker"
set :scm_verbose, true
set :repository, "git@github.com:younker/yakimapress.git"
 


set :user, "#{webfaction_username}"
set :use_sudo, false 
 
set :domain, "#{webfaction_username}.webfactional.com"
 
role :app, domain
role :web, domain
role :db,  domain, :primary => true
 

# Basic Capistrano Deployment Steps:
#   deploy:update_code
#   deploy:symlink
#   deploy:restart
namespace :deploy do
  ##
  ## Overriden methods
  ##

  desc "Redefine deploy:start"
  task :start, :roles => :app do
    run "/home/#{webfaction_username}/webapps/#{application}/bin/start"
  end
 
  desc "Redefine deploy:stop"
  task :stop, :roles => :app do
    run "/home/#{webfaction_username}/webapps/#{application}/bin/stop"
  end

  desc "Redefine deploy:restart"
  task :restart, :roles => :app do
    run "/home/#{webfaction_username}/webapps/#{application}/bin/restart"
  end

  ##
  ## Custom Tasks wired into various stages of the basic deployment process
  ##
  desc "Symlink all the /shared assets to their new version-specific path"
  task :symlink do

    # run "ln -nfs #{release_path}/public /home/#{webfaction_username}/webapps/#{application}/"

    # release_path = /home/yakimapress/webapps-releases/rails/releases/20110407164415
    # deploy_to    = /home/yakimapress/webapps-releases/rails

    run "ln -nfs #{release_path} #{deploy_to}/current"

    # ln -nfs /home/younker/webapps-releases/psy/shared/config/database.yml /home/younker/webapps-releases/psy/releases/20100927224516/config/database.yml
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"



    # ln -nfs /home/younker/webapps-releases/psy/shared/config/keys.yml /home/younker/webapps-releases/psy/releases/20100927224516/config/keys.yml
    run "ln -nfs #{shared_path}/config/contact.yml #{release_path}/config/contact.yml"
    run "ln -nfs #{shared_path}/config/ecommerce.yml #{release_path}/config/ecommerce.yml"

    # ln -nfs /home/younker/webapps-releases/psy/shared/assets /home/younker/webapps-releases/psy/releases/20100927224516/public/
    run "ln -nfs #{shared_path}/assets #{release_path}/public/"

    # ln -nfs /home/younker/webapps-releases/psy/shared/certs /home/younker/webapps-releases/psy/releases/20100927224516/
    run "ln -nfs #{shared_path}/certs #{release_path}"
  end
  # after "deploy:update_code", "deploy:symlink"


  desc "bundle install the necessary prerequisites"
  task :bundle_install, :roles => :app do
    # run "export GEM_HOME=/home/yakimapress/webapps/rails/gems"
    run "cd #{deploy_to}/current/ && /home/yakimapress/webapps/rails/bin/bundle install"
  end
  # after "deploy:update_code", "deploy:bundle_install"



end



# task :staging do
#   role :web, 'staging.whoz.in'
#   role :app, 'staging.whoz.in'
#   role :db, 'staging.whoz.in', :primary => true
# end
# 
# task :production do
# end