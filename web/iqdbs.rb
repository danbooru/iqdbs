$:.unshift(File.expand_path("../../lib", __FILE__))

require "dotenv"
Dotenv.load

require "sinatra"
require "json"
require "iqdb"

configure do
  set :default_content_type, :json
end

iqdb = Iqdb.new(
  iqdb_hostname: ENV.fetch("IQDB_HOSTNAME", "localhost"),
  iqdb_port: ENV.fetch("IQDB_PORT", 8001),
  iqdb_database_file: ENV.fetch("IQDB_DATABASE_FILE", "iqdb.db"),
)

post "/similar" do
  limit = params.fetch(:limit, 3).to_i
  file = params[:file][:tempfile]
  results = iqdb.query(file, limit)

  results.to_json
rescue Iqdb::Responses::Error => e
  { error: e.to_s }.to_json
end

post "/posts/:id" do
  post_id = params[:id].to_i
  file = params[:file][:tempfile]
  iqdb.add(post_id, file)
  200
end

delete "/posts/:id" do
  post_id = params[:id].to_i
  iqdb.remove(post_id)
  200
end

not_found do
end

error do
  error = env["sinatra.error"]
  response = { message: error.message, backtrace: error.backtrace }
  [500, JSON.pretty_generate(response)]
end
