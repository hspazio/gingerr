class CreateGingerrSignals < ActiveRecord::Migration[5.0]
  def change
    create_table :gingerr_signals do |t|
      t.string :type
      t.integer :pid
      t.integer :app_id
      t.timestamp :created_at
    end

    add_index :gingerr_signals, :app_id
    add_index :gingerr_signals, :type
  end
end
