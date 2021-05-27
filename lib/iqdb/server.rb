require "iqdb/responses/collection"

class Iqdb
  class Server
    attr_reader :hostname, :port

    def initialize(hostname, port)
      @hostname = hostname
      @port = port
    end

    def request(&block)
      Socket.tcp(hostname, port, &block)
    end

    def add(post_id, file_path)
      request do |socket|
        hex = post_id.to_s(16)
        socket.puts "add 0 #{hex}:#{file_path}"
        socket.puts "done"
        socket.read
      end
    end

    def remove(post_id)
      request do |socket|
        hex = post_id.to_s(16)
        socket.puts "remove 0 #{hex}"
        socket.puts "done"
        socket.read
      end
    end

    def query(file, limit, flags: 0)
      request do |socket|
        size = File.size(file)
        socket.puts "query 0 #{flags} #{limit} :#{size}"
        IO.copy_stream(file, socket)
        socket.puts "done"
        responses = Responses::Collection.new(socket.read)
      end
    end
  end
end
