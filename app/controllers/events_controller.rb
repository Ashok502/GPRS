class EventsController < ApplicationController

	def create
		@event = Event.new(new_params.merge(user_id: current_user.id))
		@events = current_user.events
		if @event.save
			ajax_submit?
		end
	end

	private

	def new_params
		params.require(:event).permit!
	end
end
