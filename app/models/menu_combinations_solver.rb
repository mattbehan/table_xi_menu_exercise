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

	# recursively, you can determine you are finished. the point is when you have started with eaach item, and as long as it is not in the current solution, you're good, but if it is you return and another recursive call is thus not made, and the branch will die
	def calculate_remaining_combinations current_iteration
		# if current_iteration == [] then puts "current iteration #{current_iteration}" end
		menu_items.each do |item|
			next if @solutions_that_dont_work[convert_iteration_to_key_string(current_iteration + [item])]
			current_iteration << item
			if target_price - current_iterations_price(current_iteration) == 0
				@combinations << current_iteration.sort
				# puts "DING DING DING: #{current_iteration}"
				current_iteration.delete(item)
				next
			elsif target_price - current_iterations_price(current_iteration) < 0
				# puts "current iteration #{current_iteration}"
				@solutions_that_dont_work[convert_iteration_to_key_string(current_iteration)] = "nope"
				# puts "overshot it with iteration: #{current_iteration}"
				current_iteration.delete(item)
				next
			else

			end
		
			# break if target_price - current_iterations_price(current_iteration) <= 0
			puts "adding #{item} to current_iteration: #{current_iteration}. price before add: #{current_iterations_price(current_iteration)}"
			
			
			# puts "checking for possible combo with #{current_iteration} and amount left:#{amount_left} current price: #{current_iterations_price(current_iteration).to_s}"
			calculate_remaining_combinations(current_iteration)
		end
	end

	# helper method to return the price given a set a of items
	def current_iterations_price current_iteration
		total = 0
		current_iteration.each do |item|
			total += menu_hash[item]
		end
		total
	end

end