class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    enable_extension('citext')

    create_table :campaigns do |t|
      t.citext :name, index: { unique: true }, null: false
      t.float :percentage_raised, default: 0.0, index: true, null: false
      t.float :target_amount, index: true, null: false
      t.string :sector, null: false
      t.string :country, index: true, null: false
      t.float :investment_multiple, default: 0.0, index: true, null: false

      t.timestamps
    end
  end
end
