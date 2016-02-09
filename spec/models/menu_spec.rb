require 'rails_helper'

describe Menu do
	describe "#initialize" do
		context "a valid menu has been passed to be initialized" do
			# set the test file to example.txt
			let (:test_file) {File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/example.txt")}
			before(:each) do
				@menu = Menu.new(test_file)
			end
			it "initializes a menu from the example.txt file" do
				expect(@menu.target_price).to eq(BigDecimal.new("15.05"))
				expect(@menu.menu_data[0]).to eq(["mixed fruit", BigDecimal.new("2.15")])
			end
			it "does not contain errors" do
				expect(@menu.errors.messages).to eq({})
			end
		end
		context "an invalid menu without a target price has been passed to be initialized" do
			# set the test file as invalid_example.txt, which is messing the target price line
			let (:test_file) {File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/invalid_example.txt")}
			before(:each) do
				@menu = Menu.new(test_file)
			end
			it "does not " do
				expect @menu.target_price 
			end
		end
		context "an invalid menu with extra information on one row has been passed to be initialized" do
			let (:test_file) {File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/example_with_extra_row_data.txt")}
			before(:each) do
				@menu = Menu.new(test_file)
			end
			it "returns errors on the menu object" do
				expect(@menu.errors.messages[:menu_data]).to include("Each row must only contain an item and a price")
			end
			it "does not set the target_price" do
				p @menu.inspect 
				expect(@menu.target_price).to eq(nil)
			end
		end
		context "an invalid menu with a blank line has been passed to be initialized" do
		end
		context "an invalid menu without a target price has been passed to be initialized" do
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