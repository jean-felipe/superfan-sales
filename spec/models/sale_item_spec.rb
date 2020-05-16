# == Schema Information
#
# Table name: sale_items
#
#  id            :bigint           not null, primary key
#  price         :float            not null
#  quantity      :float            not null
#  quantity_unit :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :integer          not null
#  sale_id       :bigint           not null
#
# Indexes
#
#  index_sale_items_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
require 'rails_helper'

RSpec.describe SaleItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
