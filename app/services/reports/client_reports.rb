class Reports::ClientReports
  class << self
    def resume(company)
      {
        birthdates: handle_birthdates_response(find_users_birthdate(company)),
        subscribers: handle_subscribers_response(find_subscriptions_getting_end(company))
      }
    end

    private

    def find_users_birthdate(company)
      company.users.where(
        'EXTRACT(month FROM birthdate) = ? AND EXTRACT(day FROM birthdate) = ?',
        Date.today.month, Date.today.day
      )
    end

    def find_subscriptions_getting_end(company)
       Subscription.includes(:client, :service_definition)
                   .where(company_id: company.id)
                   .where('end_at BETWEEN ? AND ?', Date.today, Date.today + 5.days)
    end

    def handle_birthdates_response(users)
      return [] if users.empty?

      users.map do |user|
        {
          id: user.id,
          name: user.name,
          email: user.email,
          gender: user.gender,
          document: user.document,
          birthdate: user.birthdate.strftime('%Y-%m-%d')
        }
      end
    end

    def handle_subscribers_response(subscribers)
      return [] if subscribers.empty?

      subscribers.map do |sub|
        {
          id: sub.id,
          service: sub.service_definition.name,
          client: sub.client.name,
          end_at: sub.end_at.strftime('%Y-%m-%d')
        }
      end
    end
  end
end
