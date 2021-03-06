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
				expect(@menu.target_price).to eq(1505)
				expect(@menu.menu_data[0]).to eq(["mixed fruit", 215])
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
			it "does not set a target price" do
				expect(@menu.target_price).to eq(nil)
			end
			it "contains errors on the menu model" do
				expect(@menu.errors.messages.empty?).to eq(false)
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
				expect(@menu.target_price).to eq(nil)
			end
		end
		context "an invalid menu with a blank line has been passed to be initialized" do
			let (:test_file) {File.new("/Users/mattbehan/Documents/github_stuff/table_xi_menu_exercise/invalid_menu_with_blank_line.txt")}
			before(:each) do
				@menu = Menu.new(test_file)
			end
			it "does not set the target_price" do
				expect(@menu.target_price).to eq(nil)
			end
			it "returns errors on the menu object" do
				expect(@menu.errors.messages[:menu_data]).to include("Each row must contain data")
			end
		end
	end

	describe "#parse_row" do
		context "a header row is passed" do
		end
		context "a body row is passed" do
		end
	end

end