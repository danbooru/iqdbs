set :rails_env, "production"

set :repo_url, 'git://github.com/evazion/iqdbs.git'
server "karasuma.donmai.us", :user => "danbooru", :roles => %w(web app db)
