require 'rails_helper'

describe Menu do
	describe "#initialize" do
		context "a valid menu has been passed to be initialized" do
			let (:test_file) {Tempfile.new("example","/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/example.txt")}
			it "initializes a menu with no errors" do
				@menu = Menu.new(test_file)
				expect(@menu).to eq("test")
			end
		end
		context "an invalid menu has been passed to be initialized" do
		end
	end
	describe "#self.parse_row" do
		context "a header row is passed" do
		end
		context "a body row is passed" do
		end

	end
	describe "#calculate_combinations" do
	end
	describe "#calculate_combinations_remaining" do
	end
	describe "#brute_force" do
	end
	describe "#current_iterations_price" do
	end

end