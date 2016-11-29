module Gingerr
  class Error < ApplicationRecord
    belongs_to :signal, class_name: 'Gingerr::ErrorSignal'

    validates :name, presence: true
    validates :message, presence: true
    validates :file, presence: true
    validates :backtrace, presence: true
  end
end