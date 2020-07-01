class AddSegmentIdToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :segment_id, :integer
    add_column :companies, :description, :string
    add_column :companies, :legal_name, :string
    add_column :companies, :phone, :string

    remove_column :companies, :category, :integer
  end
end
