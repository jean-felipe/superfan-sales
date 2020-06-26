class CreateDefaultSegments < ActiveRecord::Migration[6.0]
  def change
    ['Restaurantes', 'Serviços', 'Mercados', 'Outro'].each do |name|
      Segment.create(name: name)
    end
  end
end
