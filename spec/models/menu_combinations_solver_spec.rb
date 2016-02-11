require 'rails_helper'

describe MenuCombinationsSolver do
	let(:menu) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/example.txt"))}
	let(:menu_solver) {MenuCombinationsSolver.new( menu.menu_item_hash, menu.target_price)}
	describe "#initialize" do
		context "a valid menu has been passed to be initialized" do
			it "has all the properties of the menu" do
				expect(menu_solver.menu_hash).to eq(menu.menu_item_hash)
			end
		end
	end

	describe "#calculate_combinations_recursively" do
		context "for example.txt" do
			it "finds a couple solutions" do
				menu_solver.calculate_combinations_recursively([])
				expect(menu_solver.combinations.length).to eq(2)
			end
		end
		context "for simple_example.txt" do
			let(:menu_2) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/simple_example_1.txt"))}
			let(:menu_solver_2) {MenuCombinationsSolver.new(menu_2.menu_item_hash, menu_2.target_price)}
			it "finds a couple solutions" do
				menu_solver_2.calculate_combinations_recursively([])
				expect(menu_solver_2.combinations.length).to be > 3
			end
		end
		context "for long_example.txt" do
			let(:menu_3) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/long_example.txt"))}
			let(:menu_solver_3) {MenuCombinationsSolver.new(menu_3.menu_item_hash, menu_3.target_price)}
			it "finds a couple solutions" do
				menu_solver_3.calculate_combinations_recursively([])
				expect(menu_solver_3.combinations.length).to be > 100
			end
		end

	end

	describe "#bottom_up" do
		context "for example.txt" do
			it "finds some solutions" do
				results = menu_solver.bottom_up
				expect(menu_solver.combinations).to eq([["mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit"],["mixed fruit", "hot wings", "hot wings", "sampler plate"]])
				results.each do |array|
					p array[0]
				end
			end
		end
		context "for simple_example_1.txt" do
			let(:menu_2) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/simple_example_1.txt"))}
			let(:menu_solver_2) {MenuCombinationsSolver.new(menu_2.menu_item_hash, menu_2.target_price)}
			it "finds reasonable solutions" do
				menu_solver_2.bottom_up
				expect(menu_solver_2.combinations.length).to be > 3
			end
		end
		context "for long_example.txt" do
			let(:menu_3) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/long_example.txt"))}
			let(:menu_solver_3) {MenuCombinationsSolver.new(menu_3.menu_item_hash, menu_3.target_price)}
			it "finds reasonable" do
				menu_solver_3.bottom_up
				expect(menu_solver_3.combinations.length).to be > 100
			end
		end
	end
	describe "#bottom_up_using_ints" do
		context "for example.txt" do
			it "finds some solutions" do
				menu_solver.bottom_up_using_ints
				expect(menu_solver.combinations).to eq([["mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit"],["mixed fruit", "hot wings", "hot wings", "sampler plate"]])
			end
		end
		context "for long_example.txt" do
			let(:menu_2) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/long_example.txt"))}
			let(:menu_solver_2) {MenuCombinationsSolver.new(menu_2.menu_item_hash, menu_2.target_price)}
			it "finds reasonable" do
				menu_solver_2.bottom_up_using_ints
				expect(menu_solver_2.combinations.length).to be > 100
			end
		end
	end

	describe "#sorted_menu" do
		it "returns a menu sorted ascendingly by price" do
			sorted_values_of_menu = menu.menu_item_hash.values.sort
			expect(menu_solver.sorted_menu(menu.menu_item_hash).values).to eq(sorted_values_of_menu)
		end
	end

	describe "#menu_items_as_ints" do
		it "takes returns the menu items of a menu as integers, assuming the array is sorted" do
			sorted_menu = Hash[menu.menu_item_hash.sort_by {|item, price| price}]
			expect(menu_solver.menu_items_as_ints(sorted_menu)).to eq([0, 1, 2, 3, 4, 5])
		end
	end
	describe "#menu_hash_as_integers" do
		it "returns a hash that contains only integers" do 
			expect(menu_solver.menu_hash_as_integers(menu_solver.menu_hash)).to eq({0=>215, 1=>275, 2=>335, 3=>355, 4=>420, 5=>580})
		end
	end

end