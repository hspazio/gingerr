class CreateGingerrErrors < ActiveRecord::Migration[5.0]
  def change
    create_table :gingerr_errors do |t|
      t.integer :signal_id
      t.string :name
      t.string :message
      t.string :file
      t.text :backtrace
      t.timestamps
    end

    add_index :gingerr_errors, :signal_id
  end
end
