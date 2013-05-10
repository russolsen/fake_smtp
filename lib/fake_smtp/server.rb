require 'socket'


module FakeSmtp
  class Server
    def initialize(options={})
      @port = options[:port]
    end

    def run
      server = TCPServer.open(@port)
      puts "FakeSmtp: Listening on port #{@port}"
      loop {Thread.start(server.accept) {|socket| Session.new(socket).run}}
    end
  end

  class Session
    def initialize(socket)
      @socket = socket
    end

    def run
      respond_with '220 fake.example.com ESMTP FakeSmtp'

      while (cmd = read_line)
        break unless handle_command(cmd)
      end

      @socket.close
    end

    def handle_command(cmd)
      case cmd
      when /^HELO|^EHLO/
        words = cmd.split(' ')
        respond_with "Hello #{words[1]} I am glad to meet you"
      when /^DATA/
        respond_with '354 End data with <CR><LF>.<CR><LF>'
        read_data
        ok("queued as #{rand(1000)}")
      when /^QUIT/
        respond_with('221 Bye')
        false
      else
        ok
      end
    end

    def log(*args)
      puts args.join(' ')
    end

    def respond_with(msg)
      @socket.puts msg
      true
    end

    def ok(msg=nil)
      if msg
        respond_with "250 OK"
      else
        respond_with ": #{msg}" if msg
      end
    end

    def read_data
      while (data = @socket.gets)
        break if data == '.'
        log 'Data:', data
      end
    end

    def read_line
      (line = @socket.gets) ? line.ltrim : nil
      log('READ: ', line)
      line
    end
  end
end