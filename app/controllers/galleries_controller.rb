class GalleriesController < ApplicationController
  def create
  	@gallery = Gallery.new(new_params.merge(user_id: current_user.id))
  	if @gallery.user.limit_galleries? <= 10 && @gallery.save
      render json: { message: "success" }, :status => 200
    else
      render json: { error: @gallery.errors.full_messages.join(',')}, :status => 400
    end
  end

  private
  def new_params
  	params.require(:gallery).permit!
  end
end
