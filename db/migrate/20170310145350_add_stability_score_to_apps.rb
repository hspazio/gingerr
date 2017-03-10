class AddStabilityScoreToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :gingerr_apps, :stability_score, :integer
  end
end
