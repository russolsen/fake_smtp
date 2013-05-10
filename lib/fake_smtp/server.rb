require 'socket'
require 'active_support/core_ext'

Thread::abort_on_exception = true

module FakeSmtp
  class Server
    def initialize(options={})
      @port = options[:port]
    end

    def run
      server = TCPServer.open(@port)
      puts "FakeSmtp: Listening on port #{@port}"
      loop {Thread.start(server.accept) {|socket| SmtpSession.new(socket).run}}
    end
  end

  class Session
    attr_accessor :done
    attr_accessor :cmd

    class_attribute :handlers

    self.handlers = {}

    def initialize(socket)
      @done = false
      @socket = socket
    end

    def self.on(regular_expression, &action)
      handlers[regular_expression] = action
    end

    def run
      log("New session: #{@socket}")

      handlers[:start].call if handlers[:start]
      until done
        break unless cmd = read_line
        handle_command cmd
        puts "done: #{done}"
      end
      handlers[:end].call if handlers[:end]

      @socket.close
      log("Session finished: #{@socket}")
    end

    def handle_command(command)
      self.cmd = command
      handlers.keys.each do |re|
        next unless re.kind_of? Regexp
        if re =~ command
          instance_eval &handlers[re]
          break
        end
      end
    end

    def log(*args)
      puts args.join(' ')
    end

    def respond_with(msg)
      @socket.puts msg
    end

    def read_line
      line = @socket.gets
      line = line ? line.rstrip : line
      log('READ: ', line)
      line
    end
  end

  class SmtpSession < Session
    on /^HELO|^EHLO/ do
      words = cmd.split(' ')
      respond_with "Hello #{words[1]} I am glad to meet you"
    end

    on /^QUIT/ do
      respond_with('221 Bye')
      self.done = true
    end

    on /^DATA/ do
      respond_with '354 End data with <CR><LF>.<CR><LF>'
      while line = read_line
        break if line == '.'
      end
      respond_with("250 OK: queued as #{rand(1000)}")
    end

    on /.*/ do
      respond_with("250 OK")
    end
 end
end
