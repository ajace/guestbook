class EntriesController < ApplicationController
	def sign_in
		@name = params[:visitor_name]
		@entry = Entry.create({:name => @name})

		@entries = Entry.find(:all)
	end
end
