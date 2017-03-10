class AddSignalFrequencyToGingerrApps < ActiveRecord::Migration[5.0]
  def change
    add_column :gingerr_apps, :signal_frequency, :integer
  end
end
