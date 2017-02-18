module Gingerr
  class Error < ApplicationRecord
    belongs_to :signal, class_name: 'Gingerr::ErrorSignal'

    validates :name, presence: true
    validates :message, presence: true
    validates :file, presence: true
    validates :backtrace, presence: true

    scope :by_name, ->(name) { where(name: name).order(:created_at) }

    def self.first_seen_by_name(name)
      by_name(name).pluck(:created_at).first
    end

    def self.last_seen_by_name(name)
      by_name(name).pluck(:created_at).last
    end

    def self.count_by_name(name)
      by_name(name).count
    end
  end
end
