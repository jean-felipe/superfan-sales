class CreateServiceDefinitions < ActiveRecord::Migration[7.0]
  def change
    create_table :service_definitions do |t|
      t.references :product, null: false, foreign_key: true
      t.jsonb :definitions, default: {}
      t.integer :status, default: 0
      t.string :code

      t.timestamps
    end
  end
end
