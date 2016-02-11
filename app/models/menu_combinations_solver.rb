class MenuCombinationsSolver

	attr_reader :target_price, :menu_hash, :menu_items, :combinations, :menu_items_as_ints

	# store and format a lot of data so if we want to make changes quickly it is easy
	def initialize  menu_hash, target_price
		# @target_price = target_price
		# @menu_hash = menu_hash
		# @menu_items = @menu_hash.keys

		@menu_hash = sorted_menu(menu_hash)
		@menu_as_only_ints = menu_hash_as_integers(@menu_hash)
		@target_price = convert_number_to_integer(target_price)
		@combinations = []
		@solutions_that_dont_work = {}
	end

	def menu_items_as_ints menu
		menu.keys.map.with_index{|item,index| index}
	end

	def sorted_menu menu
		Hash[menu.sort_by {|item, price| price}]
	end

	def convert_number_to_integer number
		int = number.to_i
		float = number.to_f
		counter = 1
		until float == int
			float *= 10
			int = (number*(10**counter)).to_i
			counter +=1
		end
		int
	end

	def convert_prices_to_integers menu
		menu.values.map do |value|
			convert_number_to_integer(value)
		end
	end

	def menu_hash_as_integers menu
		Hash[menu_items_as_ints(menu).zip(convert_prices_to_integers(menu))]
	end

	# was used to shorten up the lenth of arrays and convert them to a single string, will be less effective with integers 
	def convert_iteration_to_key_string current_iteration
		current_iteration.sort!.join(", ")
	end

	# method written to avoid variable usage and avoid stack overflow
	def calculate_combinations_recursively current_iteration
		menu_items.each do |item|
			next if @solutions_that_dont_work[convert_iteration_to_key_string(current_iteration + [item])]
			current_iteration << item
			if target_price - current_iterations_price(current_iteration) == 0
				@combinations << current_iteration.sort
				current_iteration.delete(item)
				next
			elsif target_price - current_iterations_price(current_iteration) < 0
				@solutions_that_dont_work[convert_iteration_to_key_string(current_iteration)] = "nope"
				current_iteration.delete(item)
				next

			end
			calculate_combinations_recursively(current_iteration)
		end
		@combinations.uniq!
	end

	def calculate_combinations_recursively_using_ints current_iteration
		menu_items.each do |item|
			next if @solutions_that_dont_work[convert_iteration_to_key_string(current_iteration + [item])]
			current_iteration << item
			if target_price - current_iterations_price(current_iteration) == 0
				@combinations << current_iteration.sort
				current_iteration.delete(item)
				next
			elsif target_price - current_iterations_price(current_iteration) < 0
				@solutions_that_dont_work[convert_iteration_to_key_string(current_iteration)] = "nope"
				current_iteration.delete(item)
				next

			end
			calculate_combinations_recursively(current_iteration)
		end
		@combinations.uniq!
	end

	# helper method to return the price given a set a of items
	def current_iterations_price current_iteration
		total = 0
		current_iteration.each do |item|
			total += menu_hash[item]
		end
		total
	end

	# Pseudocode for attempt to go bottom up
	# Solve for smaller values of amount, starting with smallest amount of thing
	# Sort list by price
	# instantiate hash_of_possibilities
	# Starting with smallest amount, up to largest amount
	# for current_amount, other_coins
	# create array of each combination of current_amount and other_coins
	# add that array as the key of hash_of_possibilities, and the value of the combination as the value of hash_of_possibilities
	# hash_of_possibilites.select {|key,value| value == target_amount}

	# need to add some sort of test to see if we have gotten the answer for that before
	def bottom_up target_price, menu_hash
		# start by sorting the menu hash and initializing an empty hash that will be used to store combinations of dishes that are less than or equal to the target price
		sorted_hash = menu_hash.sort_by {|item, price| price}
		array_of_possibilities = []
		# go through each one of the items in the menu in ascending order by value
		sorted_hash.each do |current_item, current_items_price|
			# The current item by itself is surely not been added as possibility yet, so we start by adding that
			if current_items_price < target_price
				array_of_possibilities.push([[current_item], current_items_price])
			elsif current_items_price == target_price
				@combinations << current_item
			end
			# Since we are going through the list of items in ascending order, the only new combinations we can make are using the current_item in conjunction with previously used items. By dynamically adding values to the array_of_possibilities using new combinations, we ensure that we add every possible combination that is less than the target price
			array_of_possibilities.each do |array|
				key = array[0]
				value = array[1]
				# binding.pry
				# p "value: #{value}, current_items_price: #{current_items_price}"
				# p "array_of_possibilities"
				# p array_of_possibilities
				if value + current_items_price <= target_price
					new_possibility = key + [current_item]
					array_of_possibilities.push([new_possibility, (value + current_items_price)])
				end
			end
		end
		array_of_possibilities.select{|array| array[1] == target_price}
	end

	def bottom_up_using_ints target_price, menu_hash
		# start by sorting the menu hash and initializing an empty hash that will be used to store combinations of dishes that are less than or equal to the target price
		sorted_hash = menu_hash.sort_by {|item, price| price}
		array_of_possibilities = []
		# go through each one of the items in the menu in ascending order by value
		sorted_hash.each do |current_item, current_items_price|
			# The current item by itself is surely not been added as possibility yet, so we start by adding that
			if current_items_price < target_price
				array_of_possibilities.push([[current_item], current_items_price])
			elsif current_items_price == target_price
				@combinations << current_item
			end
			# Since we are going through the list of items in ascending order, the only new combinations we can make are using the current_item in conjunction with previously used items. By dynamically adding values to the array_of_possibilities using new combinations, we ensure that we add every possible combination that is less than the target price
			array_of_possibilities.each do |array|
				key = array[0]
				value = array[1]
				# binding.pry
				# p "value: #{value}, current_items_price: #{current_items_price}"
				# p "array_of_possibilities"
				# p array_of_possibilities
				if value + current_items_price <= target_price
					new_possibility = key + [current_item]
					array_of_possibilities.push([new_possibility, (value + current_items_price)])
				end
			end
		end
		array_of_possibilities.select{|array| array[1] == target_price}
	end




end