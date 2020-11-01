# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  description    :text             not null
#  discount_price :float
#  ean            :string           not null
#  has_discount   :boolean          default(FALSE)
#  is_active      :boolean          default(TRUE)
#  name           :string           not null
#  price          :float
#  quantity       :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer          not null
#  company_id     :bigint           not null
#
# Indexes
#
#  index_products_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
