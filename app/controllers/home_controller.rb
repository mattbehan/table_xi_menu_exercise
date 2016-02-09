require "csv"

class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
	end

    def upload

      if request.xhr?
        begin
          menu_items = []
          CSV.foreach(params[:file]) do |row|
         	menu_items << Menu.parse(row)
          end
          target_price = menu.shift
          @menu = Menu.new(target_price: target_price, menu_items: menu_items)
          # response to ajax call
          render inline: "File uploaded!"
        rescue Exception => e
          @error = e
          # response to ajax call
          render inline: "The upload failed.\n\nPlease contact admin.\n\nError details: <%= @error %>"
        end # end of error handling
      else
        render nothing: true

      end # end of xhr
    end # end of method
end
