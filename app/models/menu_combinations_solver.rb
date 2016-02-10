class MenuCombinationsSolver

	def initialize
		
	end
	# a standalone brute-force approach
	def brute_force menu_items, target_price
			menu_items.each do |item|
				current_price = item
				current_iteration = [item]
				while target_price >= current_price do
				end
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