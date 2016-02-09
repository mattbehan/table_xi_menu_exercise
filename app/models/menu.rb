class Menu
	include ActiveModel::Model

	def initialize file
		menu_data = parse_file(file)
		@target_price = menu_data.shift
		@menu_data = menu_data
		@combinations = []
		@menu_item_hash = Hash[*@menu_data.flatten]
	end

	def parse_file file
		menu_data = []
		CSV.foreach(file.path) do |row|
          	menu_data << Menu.parse_row(row)
        end
        menu_data
	end

	def self.parse_row row
		if row[1]
			row[1] = BigDecimal.new(row[1].gsub(/(\$)(\w+)/, '\2'))
		else
			row[0] = BigDecimal.new(row[0].gsub(/(\$)(\w+)/, '\2') )
		end
		row
	end

	def calculate_combinations menu_items, target_price
		if menu_items==[]
			return nil
		else
			calculate_remaining_combinations(menu_items, target_price, [])
		end
	end

	# a standalone brute-force approach
	def brute_force menu_items, target_price
			menu_items.each do |item|
				current_price = item
				current_iteration = [item]
				while target_price >= current_price
			end
	end

	def calculate_remaining_combinations items_left, amount_left, current_iteration
		if amount_left == 0
			@combinations << current_iteration 
			return
		end
		return if amount_left < 0
		return if items_left
		puts "checking for possible combo with #{items_left} and #{amount_left}"
		items_left.each do |item|
			current_iteration << item
			amount_left = current_iterations_price(current_iteration)
			amount_left
			calculate_remaining_combinations(items_left)
		end
	end

	# helper method to return the price given a set a of items
	def current_iterations_price current_iteration
		current_iteration.reduce {}
	end
end
