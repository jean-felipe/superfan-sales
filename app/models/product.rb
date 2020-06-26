# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  ean         :string           not null
#  is_active   :boolean          default(TRUE)
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  company_id  :bigint           not null
#
# Indexes
#
#  index_products_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Product < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :sub_categories
  has_and_belongs_to_many :categories
end
