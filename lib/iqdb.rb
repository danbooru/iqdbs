require "fileutils"
require "iqdb/server"
require "iqdb/command"

class Iqdb
  attr_reader :server, :command, :lockfile

  def initialize(iqdb_hostname: "localhost", iqdb_port: 8001, iqdb_database_file: "iqdb.db")
    @server = Iqdb::Server.new(iqdb_hostname, iqdb_port)
    @command = Iqdb::Command.new(iqdb_database_file)
    @lockfile = "#{iqdb_database_file}.lock"
  end

  def search(file, limit)
    server.query(limit, file.path)
  end

  def add(post_id, file)
    lock do
      server.add(post_id, file.path)
      command.add(post_id, file.path)
      LOGGER.debug("added #{image_url} for #{post_id}")
    end
  end

  def remove(post_id)
    lock do
      server.remove(post_id)
      command.remove(post_id)
      LOGGER.debug("removed #{post_id}")
    end
  end

  private

  def lock(&block)
    File.open(lockfile, File::RDWR|File::CREAT, 0644) do |file|
      Timeout.timeout(60) { file.flock(File::LOCK_EX) }
      yield
    end
  end
end
