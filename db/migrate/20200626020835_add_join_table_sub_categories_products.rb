class AddJoinTableSubCategoriesProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products_sub_categories, :id => false do |t|
      t.integer :product_id
      t.integer :sub_category_id
    end 
  end
end
