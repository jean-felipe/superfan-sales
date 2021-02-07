module Api::V1
  class ReportsController < Api::BaseController
    def daily_report
      render json: Reports::DailyReport.generate(Date.today, current_company)
    end
  end
end