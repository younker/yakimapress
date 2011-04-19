default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Setup (taken mostly from http://forum.webfaction.com/viewtopic.php?id=4906)
# cap deploy:setup
# cap deploy:check

set :application, "yakimapress"
set :webfaction_username, "yakimapress"
set :webfaction_port, "29299"

set :webfaction_db_type, "mysql"
set :webfaction_db, "yakimapress_prod"
set :webfaction_db_username, "yakimapress_prod"
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
 
default_environment['PATH']='/home/yakimapress/webapps/git/bin:/home/yakimapress/webapps/yakimapress/bin:/home/yakimapress/bin:/usr/local/bin:/usr/local/mysql/bin:/opt/local/apache2/bin:/opt/local/bin:/Users/younker/.rvm/gems/ruby-1.8.7-p302/bin:/usr/kerberos/bin:/bin:/usr/bin'
default_environment['GEM_HOME']='/home/yakimapress/webapps/yakimapress/gems'

# Basic Capistrano Deployment Steps:
#   deploy:update_code
#   deploy:symlink
#   deploy:restart
namespace :deploy do
  desc "Symlink all the /shared assets to their new version-specific path"
  task :symlink do
    # release_path = /home/yakimapress/webapps-releases/yakimapress/releases/20110407164415
    # deploy_to    = /home/yakimapress/webapps-releases/yakimapress
    run "ln -nfs #{release_path} #{deploy_to}/current"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/contact.yml #{release_path}/config/contact.yml"
    run "ln -nfs #{shared_path}/config/ecommerce.yml #{release_path}/config/ecommerce.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/"
    run "ln -nfs #{shared_path}/certs #{release_path}"
  end

  desc "Redefine deploy:restart"
  task :restart, :roles => :app do
    run "/home/#{webfaction_username}/webapps/#{application}/bin/restart"
  end
  # TODO younker [2011-04-19 10:05]
  # For some reasons, deploy:restart is NOT firing after deploy:symlink. Figure out why, but until then...
  after "deploy:bundle_install", "deploy:restart"

  desc "Redefine deploy:start"
  task :start, :roles => :app do
    run "/home/#{webfaction_username}/webapps/#{application}/bin/start"
  end
 
  desc "Redefine deploy:stop"
  task :stop, :roles => :app do
    run "/home/#{webfaction_username}/webapps/#{application}/bin/stop"
  end


  ##
  ## Custom Tasks
  ##
  desc "bundle install the necessary prerequisites"
  task :bundle_install, :roles => :app do
    run "cd #{deploy_to}/current/ && /home/yakimapress/webapps/#{application}/bin/bundle install"
  end
  after "deploy:symlink", "deploy:bundle_install"
end



# task :staging do
#   role :web, 'staging.whoz.in'
#   role :app, 'staging.whoz.in'
#   role :db, 'staging.whoz.in', :primary => true
# end
# 
# task :production do
# end