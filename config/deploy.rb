require 'bundler/capistrano'
#require 'mongrel_cluster/recipes'

set :user, 'root'
set :domain, '127.0.0.1'
set :application, "earchive"
set :applicationdir, "/usr/deploy/earchive"
set :applicationdir_link, "/u/apps/earchive"
 
 set :scm, 'git'
 set :repository,  "ssh://root@localhost/usr/deploy/earchive.git"
 set :git_enable_submodules, 1 # if you have vendored rails
 set :branch, 'master'
 set :git_shallow_clone, 1
 set :scm_verbose, true
 set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
 set :runner, nil
 set :port_number, "6400"
  
  # roles (servers)
  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
   
   # deploy config
   set :deploy_to, applicationdir
   set :deploy_to_link, applicationdir_link
   set :deploy_via, :export
   set :use_sudo, false
    
    # additional settings
    default_run_options[:pty] = true  # Forgo errors when deploying from windows
    #ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false
     
     # Passenger
#     namespace :deploy do
#       task :start do ; end
#         task :stop do ; end
#           task :restart, :roles => :app, :except => { :no_release => true } do
#               run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#               restart_mongrel_cluster
#    	    end
#     end

# =============================================================================
# TASKS
# =============================================================================
namespace :deploy do
    
      task :start, :roles => :app do
	    run "cd #{deploy_to_link}/current; "	    
	    run "/rails s mongrel -d  -p 3000 -P \'/tmp/pids/server.3000.pid\'"
	    
	    run "rails s mongrel -d  -p 3001 -P /tmp/pids/server.3001.pid"
      end
    
      task :stop, :roles => :app do
	run "cd #{deploy_to_link}/current;"
	run "kill -9 $(cat /tmp/pids/server.3000.pid)"
	run "kill -9 $(cat /tmp/pids/server.3001.pid)"
      end

      task :restart, :roles => :app do
	run "kill -9 $(cat /tmp/pids/server.3000.pid)"
	run "kill -9 $(cat /tmp/pids/server.3001.pid)"
        run "rails s mongrel -d  -p 3000 -P '/tmp/pids/server.3000.pid'"
        run "rails s mongrel -d  -p 3001 -P '/tmp/pids/server.3001.pid'"
	run "echo \"EARCHIVE HAS BEEN DEPLOYED\""
      end
                                
                                  after "deploy:update_code", :link_production_db
                                  end
                                  
                                  # database.yml task
                                  desc "Link in the production database.yml"
                                  task :link_production_db do
                                    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
                                    end
                 
                 


#require 'mongrel_cluster/recipes'
#set :application, "earchive"
#set :deploy_to, "LibraODry/Rails/#{application}"
#set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
#role :web, "localhost"
#role :app, "localhost"
#role :db,  "localhost", :primary => true
