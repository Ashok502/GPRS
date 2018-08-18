class EventsController < ApplicationController
	before_action :set_id, only: [:edit, :update, :destroy]

	def new
		@event = Event.new
		@page = "New Event"
		ajax_submit?
	end

	def create
		@event = Event.new(new_params.merge(user_id: current_user.id))
		@events = current_user.events
		@page = "New Event"
		if @event.save
			ajax_submit?
		end
	end

	def edit
		@page = "Edit Event"
		ajax_submit?
	end

	def my_events
		@events = Event.where(start_date: params[:start], end_date: params[:end])
		ajax_submit?
	end

	def update
		@page = "Edit Event"
		@events = current_user.events
		if @event.update_attributes(new_params)
			ajax_submit?
		end
	end

	def destroy
		@event.destroy
		@events = current_user.events
		ajax_submit?
	end

	private

	def new_params
		params.require(:event).permit!
	end

	def set_id
		@event = Event.find(params[:id])
	end
end
