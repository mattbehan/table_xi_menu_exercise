require "csv"

class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
	end

    def upload

      if request.xhr?
        begin # response to ajax call
          @menu = Menu.new(params[:file])
          unless @menu.errors.messages.empty?
            "______________here______________"
            # content_type :json
            puts @menu.errors.messages
            raise ArgumentError
          else
          render :"/home/_menu_viewer", layout: false, locals: { menu_items: @menu_items, combinations: @combinations }
        end
        rescue Exception => e #if error occurs during upload
          @error = e
          puts "________________________________________________________"
          puts @error
          status 422
          render inline: "The upload failed.\n\nError details: <%= @error %>"
        end # end of error handling
      else
        render nothing: true #render nothing if it is not a JS request, as this requires JS
      end # end of xhr
    end # end of method
end
