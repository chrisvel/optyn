server "ec2-23-22-29-198.compute-1.amazonaws.com", :web, :app, :db, :messenger, primary: true
set :branch, "templates_formatting"
set :rails_env, 'integration'
set :local_app_url, 'http://localhost:3000/'
