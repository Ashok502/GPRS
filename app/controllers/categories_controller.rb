class CategoriesController < ApplicationController
	before_action :get_category, only: ['edit', 'update', 'destroy']

	def index
		@categories = Category.page(params[:category_page]).per_page(5)
		ajax_submit?
	end

	def new
		@category = Category.new
		ajax_submit?
	end

	def create
		@category = Category.new(new_params.merge(user_id: current_user.id))
		@categories = Category.page(params[:category_page]).per_page(5)
		if @category.save
			ajax_submit?
		end
	end

	def edit
	end

	def update
		@categories = Category.page(params[:category_page]).per_page(5)
		if @category.update_attributes(new_params)
			ajax_submit?
		end
	end

	def destroy
		@category.destroy
		ajax_submit?
	end

	private

	def get_category
		@category = Category.find(params[:id])
	end

	def new_params
		params.require(:category).permit!
	end
end
