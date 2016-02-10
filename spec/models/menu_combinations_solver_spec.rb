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

	describe "#calculate_combinations" do
		context "for example.txt" do
			it "finds a couple solutions" do
				menu_solver.calculate_remaining_combinations([])
				p menu_solver.combinations
			end
		end
	end
	describe "#calculate_remaining_combinations" do
	end
	describe "#brute_force" do
	end
	describe "#current_iterations_price" do
	end

end