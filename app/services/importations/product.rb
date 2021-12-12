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
          next if param['name'] == 'name'

          product = ::Product.new(param.except('category', 'measure_unit', 'ean'))
          product.measure_unit = map_measure_unit(param['measure_unit'])
          product.ean = map_ean(param['ean'])
          product.company = company
          product.categories << Category.find_or_create_by(name: param['category'].downcase)

          if product.save
            next
          else
            @errors << { line: param, error: product.errors.messages }
          end
        end

        return @errors unless @errors.empty?
      end

      def map_measure_unit(unit)
        case unit
        when 'Gramas' then 'grams'
        when 'Litros' then 'liters'
        when 'Kilos' then 'kg'
        when 'Kg' then 'kg'
        when 'KG' then 'kg'
        when 'Unidades' then 'unit'
        when 'Unidade' then 'unit'
        end
      end

      def map_ean(ean)
        case ean
        when 'NT' then "NT-#{SecureRandom.hex(4)}"
        else
          ean
        end
      end
    end
  end
end