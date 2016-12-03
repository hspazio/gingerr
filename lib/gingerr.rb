require "gingerr/engine"

module Gingerr
  module Example
    def self.app
      Gingerr::App.new(name: name)
    end

    def self.endpoint
      Gingerr::Endpoint.new(ip: ip, hostname: name, login: login)
    end

    def self.success_signal(app, endpoint)
      Gingerr::SuccessSignal.new(
          app: app,
          endpoint: endpoint,
          pid: rand(5000),
          created_at: timestamp)
    end

    def self.error_signal(app, endpoint, error)
      Gingerr::ErrorSignal.new(
          app: app,
          endpoint: endpoint,
          pid: rand(5000),
          created_at: timestamp)
    end

    def self.error
      Gingerr::Error.new(
          name: word(40),
          message: word(50),
          file: word(10) + '.rb',
          backtrace: 5.times.map{ word(100) }.join("\n"))
    end

    def self.name
      word(rand(17) + 3)
    end

    def self.timestamp(from = time_ago, to = Time.now)
      Time.at(from + rand * (to.to_f - from.to_f))
    end

    def self.ip
      4.times.map { rand(255) }.join('.')
    end

    def self.login
      word(10)
    end

    private

    def self.word(length)
      ch = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      (0...length).map { ch.sample }.join
    end

    def self.time_ago
      @time_from ||= Time.now - 60*60*24*31*2
    end
  end
end
