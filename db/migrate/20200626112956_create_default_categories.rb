class CreateDefaultCategories < ActiveRecord::Migration[6.0]
  def change
    ['Bebidas', 'Pratos Prontos', 'Sobremesas', 'Fast Food', 'Serviços', 'Mercadoria'].each do |name|
      Category.create(name: name)
    end
end
