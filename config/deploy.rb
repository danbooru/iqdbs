set :application, 'iqdbs'
set :rbenv_type, :user
set :rbenv_ruby, "2.6.3"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids')
set :linked_files, fetch(:linked_files, []).push(".env")
