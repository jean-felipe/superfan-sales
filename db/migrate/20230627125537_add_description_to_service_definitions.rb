class AddDescriptionToServiceDefinitions < ActiveRecord::Migration[7.0]
  def change
    add_column :service_definitions, :description, :string
  end
end
