class CreateGingerrApps < ActiveRecord::Migration[5.0]
  def change
    create_table :gingerr_apps do |t|
      t.string :name
      t.timestamps
    end
  end
end
