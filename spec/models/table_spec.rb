# == Schema Information
#
# Table name: tables
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  places     :integer          default(0)
#  status     :integer          default(0)
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
require 'rails_helper'

RSpec.describe Table, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
