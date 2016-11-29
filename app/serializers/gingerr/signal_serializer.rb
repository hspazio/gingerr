module Gingerr
  class SignalSerializer < BaseSerializer
    attribute :id
    attribute :state, key: 'type'
    attribute :pid
    attribute :created_at

    belongs_to :app
    belongs_to :endpoint

    type 'gingerr/signal'
  end
end
