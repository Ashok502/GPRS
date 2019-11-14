module ApplicationHelper

	def icon(icon)
		"<span class='glyphicon glyphicon-#{icon}'></span>"
	end

	def ajax_submit?
		respond_to do |format|
			format.js
		end
	end

	def filename(file)
		basename = File.basename file, File.extname(file)
	end

	def user_photo(user)
		image_tag user.avatar.url(:original), class: "img-circle", alt: "Avatar"
	end

	def user_profile_path(user)
		link_to user.username, profile_path(user), remote: true, id: "show_user"
	end

	def loader_button(btn)
		btn.button "Submit", class: 'btn btn-primary', data: {disable_with: "<i class='fa fa-spinner fa-spin'></i> Submit"}
	end
	
	def google_map(center)
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
  end
end
