class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.references :campaign, index: true, foreign_key: true, null: false
      t.float :amount, index: true, null: false

      t.timestamps
    end
  end
end
