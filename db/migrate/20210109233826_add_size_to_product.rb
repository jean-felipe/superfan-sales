class AddSizeToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :measure, :float
    add_column :products, :measure_unit, :integer, default: 0
  end
end
