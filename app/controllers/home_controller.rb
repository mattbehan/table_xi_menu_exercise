require "csv"

class HomeController < ApplicationController

	before_action :authenticate_user!

  respond_to :html, :js, :json

	def index
	end

    def upload

      if request.xhr?
        begin # response to ajax call
          @menu = Menu.new(params[:file])
          unless @menu.errors.messages.empty?
            raise @menu.errors.full_messages.join(", ")
          else
            @menu_solver = MenuCombinationsSolver.new(@menu.menu_item_hash, @menu.target_price)
            @menu_solver.bottom_up #included other methods for easy access
            # @menu_solver.calculate_combinations_recursively([])
            # @menu_solver.bottom_up_using_ints
            render :"/home/_menu_viewer", layout: false, locals: { menu_items: @menu.printed_menu, combinations: @menu_solver.combinations }
          end
        rescue Exception => e #if error occurs during upload
          @error = e
          render inline: "Upload failed.\n\nError details: <%=@error%>", status: 422
        end # end of error handling
      else
        render nothing: true #render nothing if it is not a JS request, as this requires JS
      end # end of xhr
    end # end of method
end
