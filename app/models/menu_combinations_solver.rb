class MenuCombinationsSolver

	attr_reader :target_price, :menu_data, :menu_hash, :menu_items, :combinations

	def initialize valid_menu_object
		@target_price = valid_menu_object.target_price
		@menu_data = valid_menu_object.menu_data
		@menu_hash = valid_menu_object.menu_item_hash
		@menu_items = @menu_hash.keys
		@combinations = []
		@solutions_that_dont_work = {}
	end

	# pseudocode
	# For each item in the items
	# combine it with each item in items, as long as the cost does not go over and is still under
	# We are now at point 2
	# Now for both the items in list, try to combine it with every single item in the list, as long as it does not go over
	# When you have gone over, the current solution is invalid, so add it to list of things that do not work
	# when you have hit the amount directly, you are good to go
	# While you are still under the amount, keep trying

	# a standalone brute-force approach
	# could replace keys as numbers to easily determine and track what you have used instead of sorting
	# what is the condition that causes you to know you are finished?


	def brute_force menu_items, target_price
		@solutions_that_dont_work = {}
		solutions = []
		possible_solutions_branch
		menu_hash.each do |item, price|
			current_price = price
			current_iteration = [item]
			if current_price > target_price
				@solutions_that_dont_work[convert_iteration_to_key_string(current_iteration)] = "nope"
			elsif current_price == target_price
			end
			while target_price >= current_price && @solutions_that_dont_work[convert_iteration_to_key_string(current_iteration)] == nil do

			end
		end
	end

	def convert_iteration_to_key_string current_iteration
		current_iteration.sort! #may not be necessary
		current_iteration.join(", ")
	end

	# to improve could substitute string values for integers in the menu hash, then in a separate method convert the combinations from the array of integers back into an array of strings
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

	# Pseudocode for attempt to go bottom up
	# Solve for smaller values of amount, starting with smallest amount of thing
	# Sort list by price
	# instantiate hash_of_possibilities
	# Starting with smallest amount, up to largest amount
	# for current_amount, other_coins
	# create array of each combination of current_amount and other_coins
	# add that array as the key of hash_of_possibilities, and the value of the combination as the value of hash_of_possibilities
	# hash_of_possibilites.select {|key,value| value == target_amount}


	def bottom_up target_price, menu_hash
		# start by sorting the menu hash and initialzing an empty hash that will be used to store combinations of dishes that are less than or equal to the target price
		sorted_hash = menu_hash.sort_by {|item, price| price}
		hash_of_possibilities = {}
		# go through each one of the items in the menu in ascending order by value
		sorted_hash.each do |current_item, current_items_price|
				# The current item by itself is surely not been added as possibility yet, so we start by adding that
				if current_items_price <= target_price
					hash_of_possibilities[[current_item]] = current_items_price
				end
				# Since we are going through the list of items in ascending order, the only new combinations we can make are using the current_item in conjunction with previously used items. By dynamically adding values to the hash_of_possibilities using new combinations, we ensure that we add every possible combination that is less than the target price
				hash_of_possibilities.each do |key,value|
					if value + current_items_price <= target_price
						new_possibilitiy = key.push(current_item)
						hash_of_possibilities[new_possibilitiy] = value + current_items_price
					end
				end
			# hash_of_current_options[item] = price #moved to end so that the option we are currently on is excluded from ones we have already used
		end
		hash_of_possibilities.select{|key,value| value == target_price}

	end



end