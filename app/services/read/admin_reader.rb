module Read
  class AdminReader
    class << self
      def list_clients
        Company.all.map{ |company| company_info(company) }
      end

      def get_company(id)
        company = Company.find(id)
        company_info(company)
      end

      def company_info(company)
        {
          id: company.id,
          description: company.description,
          document: company.document,
          fantasy_name: company.fantasy_name,
          legal_name: company.legal_name,
          phone: company.phone,
          created_at: company.created_at.strftime('%d/%m/%Y'),
          user: {
            id: company.user.id,
            code: company.user.code,
            document: company.user.document,
            email: company.user.email,
            gender: company.user.gender,
            name: company.user.name,
            role: company.user.role,
            status: company.user.status,
          }
        }
      end
    end
  end
end
