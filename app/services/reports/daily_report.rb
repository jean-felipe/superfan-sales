module Reports
	class DailyReport
		class << self
			attr_reader :sales

			def generate(date, company)
				start_date = date.beginning_of_day
				end_date = date.end_of_day
				@sales = company.orders.where('created_at BETWEEN ? AND ?', start_date, end_date)

				{
					total_sales: sales.count,
					total_billing: sales.sum(:total_price).round(2),
					total_sales_by_products: load_sales_by_products,
					total_billing_by_products: load_billing_by_products,
					total_new_customers: load_by_user
				}
			end

			private

			def load_sales_by_products
				return 0 if sales.empty?

				products = []

				sales.each do |sale|
					sale.products.uniq.map do |product|
						products << {
							product: product.name,
							billing: sale.items.where(product_id: product.id).count
						}
					end
				end

				products
			end

			def load_billing_by_products
				return 0 if sales.empty?
				products = []

				sales.each do |sale|
					sale.products.uniq.map do |product|
						products << {
							product: product.name,
							billing: sale.items.where(product_id: product.id).sum(:price).round(2)
						}
					end
				end

				products
			end

			def load_by_user
				return 0 if sales.empty?

				sales.pluck(:user_id).uniq.map do |user_id|
					{
						user: User.find(user_id),
						total_items: sales.where(user_id: user_id).count,
						total_billing: sales.where(user_id: user_id).sum(:total_price).round(2)
					}
			  end
			end
		end
	end
end