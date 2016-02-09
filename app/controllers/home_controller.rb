require "csv"

class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
	end

    def upload

      if request.xhr?
        begin # response to ajax call
          @menu_items = []
          CSV.foreach(params[:file].path) do |row|
          	@menu_items << Menu.parse_row(row)
          end
          @target_price = @menu_items.shift
          @combinations = nil
          render :"/home/_menu_viewer", layout: false, locals: { menu_items: @menu_items, combinations: @combinations }
        rescue Exception => e #if error occurs during upload
          @error = e
          render inline: "The upload failed.\n\nError details: <%= @error %>"
        end # end of error handling
      else
        render nothing: true #render nothing if it is not a JS request, as this requires JS
      end # end of xhr
    end # end of method
end
