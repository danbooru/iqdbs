class Iqdb
  class Command
    attr_reader :database

    def initialize(database)
      @database = database
    end

    def process(&block)
      IO.popen("iqdb command #{database}", "w+", &block)
    end

    def add(post_id, file_path)
      hex = post_id.to_s(16)
      process do |io|
        io.puts "add 0 #{hex}:#{file_path}"
        io.puts "quit"
        io.read
      end
    end

    def remove(post_id)
      hex = post_id.to_s(16)
      process do |io|
        io.puts "remove 0 #{hex}"
        io.puts "quit"
        io.read
      end
    end
  end
end
