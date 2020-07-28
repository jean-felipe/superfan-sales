# == Schema Information
#
# Table name: tables
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  places     :integer          default(0)
#  status     :integer          default("active")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_tables_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Table < ApplicationRecord
  STATUSES = %w(active inactive)

  belongs_to :company

  enum status: STATUSES
end
