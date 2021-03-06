require "csv"
class Menu
	include ActiveModel::Model

	# The main responsiblity of this class is to parse and validify the data from the input file. Most of the validations are run during the processing of the file in order to save having to run over the data again

	attr_reader :target_price, :menu_data, :menu_item_hash, :parse_row, :printed_menu

	validates :menu_data, presence: true
	validates :target_price, presence: true
	validates :menu_item_hash, presence: true

	def initialize file
		parsed_data = parse_file(file)
		if self.errors.messages.empty?
			@menu_data = parsed_data[0]
			@target_price = parsed_data[1]
			@menu_item_hash = Hash[*@menu_data.flatten] #assumes only a 2 level deep array
			check_for_duplicates
		else
			puts "in initialize"
			raise self.errors.full_messages.join(", ")
		end
	end

	def printed_menu
		printable_menu_items = Hash[menu_item_hash.keys.zip(reformat_prices_to_print(menu_item_hash.values))]
		reformatted_target_price = reformat_price_to_print(target_price)
		{"Target price" => reformatted_target_price}.merge(printable_menu_items)
	end

	def reformat_prices_to_print prices
		prices.map do |price|
			reformat_price_to_print(price)
		end
	end

	def reformat_price_to_print price
		"$" + sprintf("%.2f", (price.to_f/100) )
	end

	# run through the file and read the data while ensuring consistency of the data
	# if the input is not as expected, errors will be added to the menu object however it will try 
	# returns the menu items and corresponding prices as a nested array, as well as the target price
	def parse_file file
		menu_data = []
		reader = CSV.open(file.path)
		first_line = valid_target_price?(reader.shift)
		reader.each do |row|
			if valid_row_lengths?(row.length) && valid_row_data?(row)
				menu_data << parse_row(row)
			else
				return
			end
		end
		[menu_data,first_line]
	end


	#ensure that row lengths are 
	def valid_row_lengths? row_length
		if row_length > 2
			self.errors.add(:menu_data, "Each row must only contain an item and a price") 
			false
		elsif row_length == 0
			self.errors.add(:menu_data, "Each row must contain data") 
			false
		else
			true
		end
	end

	# ensure price is > 0
	# ensure first part is not blank
	# called within parse_row in the case that it is not the first line
	def valid_row_data? row
		if row[0] == "" || row[0] == nil || row[1] == "" || row[1] == nil || format_monetary_input_as_int(row[1]) <= 0
			self.errors.add(:menu_data, "Invalid data within row")
		else
			true
		end
	end

	# ensure that the row in which the target price came from only has one value
	# ensure that the the target price is greater than 0 
	def valid_target_price? first_line
		if first_line.length != 1
			self.errors.add(:target_price, "Invalid information for target price")
			return nil
		else
			target_price = format_monetary_input_as_int(first_line[0])
			if target_price <= 0
				self.errors.add(:target_price, "Invalid information for target price")
				return nil
			else
				target_price
			end
		end
	end

	def check_for_duplicates
		if menu_item_hash.keys.uniq! != nil
			self.errors.add(:menu_data, "Cannot have duplicate menu items")
			# raise "you can't have duplicates"
		end
	end

	def parse_row row
		row[1] = format_monetary_input_as_int(row[1])
		row
	end

	def format_monetary_input_as_int data
		data = data.gsub(/(\$)(\w+)/, '\2').to_f
		data*100.to_i
	end

end
