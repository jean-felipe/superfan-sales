class AddJoinTableCategoriesSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_sub_categories, :id => false do |t|
      t.integer :category_id
      t.integer :sub_category_id
    end 
  end
end
