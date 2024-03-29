# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  belongs_to :company, optional: true
  has_and_belongs_to_many :categories

  validates :name, uniqueness: true
end
