class MenuCombinationsSolver

	attr_reader :target_price, :menu_hash, :menu_items, :combinations, :menu_as_only_ints, :menu_items_ints

	# store and format a lot of data so if we want to make changes quickly it is easy
	def initialize menu_hash, target_price
		@menu_hash = sorted_menu(menu_hash)
		@menu_items_ints = menu_items_as_ints(@menu_hash)
		@menu_as_only_ints = menu_hash_as_integers(@menu_hash)
		@menu_items = menu_hash.keys
		@target_price = target_price
		@combinations = []
		@solutions_that_dont_work = {}
	end

	def menu_items_as_ints menu
		menu.keys.map.with_index{|item,index| index}
	end

	# sort menu by price ascending to make it so that we start with the smallest combinations
	def sorted_menu menu
		Hash[menu.sort_by {|item, price| price}]
	end

	# convert menu data to ints in order to use less memory space
	def menu_hash_as_integers menu
		Hash[menu_items_ints.zip(menu_hash.values)]
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

	# helper method to return the price given a set a of items
	def current_iterations_price current_iteration
		total = 0
		current_iteration.each do |item|
			total += menu_hash[item]
		end
		total
	end

	def bottom_up
		# array where we will store combinations of items which are <= target price
		array_of_possibilities = []
		# go through each one of the items in the menu in ascending order by value
		menu_hash.each do |current_item, current_items_price|
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
				if value + current_items_price <= target_price
					new_possibility = key + [current_item]
					array_of_possibilities.push([new_possibility, (value + current_items_price)])
				end
			end
		end
		# find and collect the successful combinations in the array of possibilities
		@combinations = array_of_possibilities.select{|array| array[1] == target_price}.collect{|array| array[0]}
	end

	# kept this as a separate method to make it easy to compare and show differences between keeping the items as an array of strings and an array of integers. In the end, it was pretty much determined that converting the items to integers and then converting back was actually less efficient than just keeping the items as strings
	def bottom_up_using_ints
		array_of_possibilities = []
		menu_as_only_ints.each do |current_item, current_items_price|
			if current_items_price < target_price
				array_of_possibilities.push([[current_item], current_items_price])
			elsif current_items_price == target_price
				@combinations << current_item
			end
			array_of_possibilities.each do |array|
				key = array[0]
				value = array[1]
				if value + current_items_price <= target_price
					new_possibility = key + [current_item]
					array_of_possibilities.push([new_possibility, (value + current_items_price)])
				end
			end
		end
		solutions = array_of_possibilities.select{|array| array[1] == target_price}.collect{|array| array[0]}
		@combinations = convert_integer_solutions_back_to_items(solutions)
	end

	def convert_integer_solutions_back_to_items solutions
		solutions.each do |solution|
			solution.map! do |key|
				menu_items[key]
			end
		end
	end

end