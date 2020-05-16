# == Schema Information
#
# Table name: sales
#
#  id               :bigint           not null, primary key
#  logged_user      :integer          not null
#  payment_method   :integer          not null
#  transaction_date :datetime         default(Sat, 16 May 2020 01:17:33 UTC +00:00), not null
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
class Sale < ApplicationRecord
end
