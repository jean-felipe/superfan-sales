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

  def details
    {
      name: user.name,
      birthdate: user.birthdate.strftime("%d/%m/%Y"),
      code: user.code,
      document: user.document,
      email: user.email,
      gender: user.gender,
      role: user.role,
      status: user.status
    }
  end

  def name
    user.name
  end
end
