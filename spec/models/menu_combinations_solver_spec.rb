require 'rails_helper'

describe MenuCombinationsSolver do
	let(:menu) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/example.txt"))}
	let(:menu_solver) {MenuCombinationsSolver.new(menu)}
	describe "#initialize" do
		context "a valid menu has been passed to be initialized" do
			it "has all the properties of the menu" do
				expect(menu_solver.menu_hash).to eq(menu.menu_item_hash)
				expect(menu_solver.menu_hash["mixed fruit"]).to eq( BigDecimal.new("2.15"))
				expect(menu_solver.target_price).to eq(BigDecimal.new("15.05"))
				expect(menu_solver.menu_data[0]).to eq(["mixed fruit", BigDecimal.new("2.15")])
			end
		end
	end

	describe "#calculate_combinations_recursively" do
		context "for example.txt" do
			it "finds a couple solutions" do
				menu_solver.calculate_combinations_recursively([])
				p menu_solver.combinations
			end
		end
		context "for simple_example.txt" do
			let(:menu_2) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/simple_example_1.txt"))}
			let(:menu_solver_2) {MenuCombinationsSolver.new(menu_2)}
			it "finds a couple solutions" do
				menu_solver_2.calculate_combinations_recursively([])
				p "second solution"
				p menu_solver_2.combinations
				p menu_solver_2.combinations.length
			end
		end
	end
	describe "#current_iterations_price" do
	end
	describe "#bottom_up" do
		context "for example.txt" do
			it "finds some solutions" do
				results = menu_solver.bottom_up(menu.target_price, menu.menu_item_hash)
				results.each do |array|
					p array[0]
				end
			end
		end
		context "for simple_example_1.txt" do
			let(:menu_2) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/simple_example_1.txt"))}
			let(:menu_solver_2) {MenuCombinationsSolver.new(menu_2)}
			it "finds reasonable solutions" do
				results = menu_solver.bottom_up(menu_2.target_price, menu_2.menu_item_hash)
				results.each do |array|
					p array[0]
				end
				p results.count
				p menu_solver_2.menu_hash
				p menu_solver_2.menu_items
			end
		end
	end

end