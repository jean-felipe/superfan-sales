# == Schema Information
#
# Table name: sales
#
#  id               :bigint           not null, primary key
#  logged_user      :integer          not null
#  payment_method   :integer          not null
#  transaction_date :datetime         default(Tue, 27 Jun 2023 20:54:08.914599000 -03 -03:00), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :bigint           not null
#
# Indexes
#
#  index_sales_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require 'rails_helper'

RSpec.describe Sale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
