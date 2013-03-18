root = "/srv/apps/optyn/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.optyn.sock"
worker_processes 2
timeout 300
listen 3000

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
   defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end