module Reports
	class DailyReport
		class << self
			attr_reader :sales, :start_date, :end_date, :company

			def generate(date, company)
				@start_date = date.beginning_of_day
				@end_date = date.end_of_day
				@sales = company.orders.where('created_at BETWEEN ? AND ?', start_date, end_date)
				@company = company

				{
					total_sales: sales.count,
					total_billing: sales.sum(:total_price).round(2),
					total_sales_by_products: load_sales_by_products,
					total_billing_by_products: load_billing_by_products,
					total_new_customers: load_by_user,
					total_by_payment_types: total_by_payment_types,
					total_billing_by_payment_types: total_billing_by_payment_types
				}
			end

			private

			def load_sales_by_products
				return 0 if sales.empty?

				products = []
				product_ids = OrderItem.where('created_at BETWEEN ? AND ?', start_date, end_date).pluck(:product_id).uniq

				product_ids.map do |id|
					product = company.products.find(id)
					products << {
						name: product.name + ' - ' + product.description,
						billing: Order.includes(:items)
							.where('orders.created_at BETWEEN ? AND ?', start_date, end_date)
							.where(items: { product_id: id })
							.sum(:quantity)
					}
				end
				products.sort_by { |hsh| hsh[:billing] }.reverse
			end

			def load_billing_by_products
				return 0 if sales.empty?
				products = []
				product_ids = OrderItem.where('created_at BETWEEN ? AND ?', start_date, end_date).pluck(:product_id).uniq

				product_ids.map do |id|
					product = company.products.find(id)
					products << {
						name: product.name + ' - ' + product.description,
						billing: Order.includes(:items)
							.where('orders.created_at BETWEEN ? AND ?', start_date, end_date)
							.where(items: { product_id: id })
							.sum(:total_price).round(2)
					}
				end

				products.sort_by { |hsh| hsh[:billing] }.reverse
			end

			def load_by_user
				return 0 if sales.empty?

				sales.pluck(:user_id).uniq.map do |user_id|
					user = User.find(user_id)
					{
						user: user,
						total_items: user.items.where('orders.created_at BETWEEN ? AND ?', start_date, end_date).count,
						total_billing: sales.where(user_id: user_id).sum(:total_price).round(2)
					}
			  end.sort_by { |hsh| hsh[:total_billing] }.reverse
			end

			def total_by_payment_types
				return 0 if sales.empty?

				payments = OrderPayment
					.where('company_id = ? AND created_at BETWEEN ? AND ?', company.id, start_date, end_date)

				[
					{
						name: 'Débito',
						value: payments.where(payment_type: 'debit').count
					},
					{
						name: 'Crédito',
						value: payments.where(payment_type: 'credit').count
					},
					{
						name: 'Dinheiro',
						value: payments.where(payment_type: 'money').count
					},
					{
						name: 'Pix',
						value: payments.where(payment_type: 'pix').count
					}
				]
			end

			def total_billing_by_payment_types
				return 0 if sales.empty?

				payments = OrderPayment
					.where('company_id = ? AND created_at BETWEEN ? AND ?', company.id, start_date, end_date)

				[
					{
						name: 'Débito',
						value: payments.where(payment_type: 'debit').sum(:value).round(2)
					},
					{
						name: 'Crédito',
						value: payments.where(payment_type: 'credit').sum(:value).round(2)
					},
					{
						name: 'Dinheiro',
						value: payments.where(payment_type: 'money').sum(:value).round(2)
					},
					{
						name: 'Pix',
						value: payments.where(payment_type: 'pix').sum(:value).round(2)
					}
				]

			end
		end
	end
end
