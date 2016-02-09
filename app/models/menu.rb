class Menu < ActiveRecord::Base

	def self.parse line
		line.gsub(/($)(\w)/, '$2')
	end
end
