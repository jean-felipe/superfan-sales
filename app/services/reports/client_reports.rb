class Reports::ClientReports
  class << self
    def resume(company)
      today = Date.today

      {
        bithdates: company.users.where(
          'EXTRACT(month FROM birthdate) = ? AND EXTRACT(day FROM birthdate) = ?',
          today.month, today.day
        ).as_json,
        subscribers: Subscription.where(company_id: company.id)
                                .where('end_at BETWEEN ? AND ?', today, today + 5.days)
                                .as_json

      }
    end
  end
end
