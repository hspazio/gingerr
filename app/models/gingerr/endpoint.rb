module Gingerr
  class Endpoint < ApplicationRecord
    validates :ip, presence: true
    validates :hostname, presence: true
    validates :login, presence: true
    validate :ip_has_ipv4_format, if: 'self.ip'

    def description
      "#{login}@#{hostname} (#{ip})"
    end

    private

    def ip_has_ipv4_format
      ip_tokens = self.ip.scan(/(\d+).(\d+).(\d+).(\d+)/).flatten

      unless ip_tokens.any? && ip_tokens.all?{ |d| (0..255).include?(d.to_i) }
        errors.add(:ip, 'is not a valid IPv4')
      end
    end
  end
end
