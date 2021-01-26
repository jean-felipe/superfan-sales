class CreateDefaultSegments < ActiveRecord::Migration[6.0]
  def change
    ['Restaurantes', 'Mercados'].each do |name|
      Segment.create(name: name)
    end
  end
end
