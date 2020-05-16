class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :fantasy_name, nul: false
      t.integer :category, nul: false
      t.string :document, nul: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
