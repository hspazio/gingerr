class CreateGingerrEndpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :gingerr_endpoints do |t|
      t.string :ip
      t.string :hostname
      t.string :login

      t.timestamps
    end
  end
end
