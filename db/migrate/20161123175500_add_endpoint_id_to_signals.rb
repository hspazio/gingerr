class AddEndpointIdToSignals < ActiveRecord::Migration[5.0]
  def change
    add_column :gingerr_signals, :endpoint_id, :integer
    add_index :gingerr_signals, :endpoint_id
  end
end
