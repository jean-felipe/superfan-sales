require 'roo'
# require '/app/models/product'

module Importations
  class Product
    attr_reader :errors

    class << self
      def import(file, company)
        xlsx = Roo::Spreadsheet.open(file)

        data = xlsx.parse(headers: true)
        @errors = []

        data.map do |param|
          next if param["name"] == "name"

          product = ::Product.new(param.except("category"))
          product.company = company
          product.categories << Category.find_or_create_by(name: param["category"])

          if product.save
            next
          else
            @errors << { line: param, error: product.errors.messages }
          end
        end

        return @errors unless @errors.empty?
      end
    end
  end
end