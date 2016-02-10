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
		context "for long_example.txt" do
			let(:menu_3) {Menu.new(File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/long_example.txt"))}
			let(:menu_solver_3) {MenuCombinationsSolver.new(menu_3)}
			it "finds a couple solutions" do
				menu_solver_3.calculate_combinations_recursively([])
				p "second solution"
				p menu_solver_3.combinations
				p menu_solver_3.combinations.length
			end
		end
	end
	describe "#brute_force" do
	end
	describe "#current_iterations_price" do
	end

end