# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_clients_on_company_id  (company_id)
#  index_clients_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
class Client < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :user_id, uniqueness: { scope: :company_id }

  def name
    user.name
  end
end
