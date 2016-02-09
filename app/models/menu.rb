class Menu < ActiveRecord::Base

	def self.parse_row row
		if row[1]
			row[1] = BigDecimal.new(row[1].gsub(/(\$)(\w+)/, '\2'))
		else
			row[0] = BigDecimal.new(row[0].gsub(/(\$)(\w+)/, '\2') )
		end
		row
	end
end
