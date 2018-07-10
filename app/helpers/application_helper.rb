module ApplicationHelper

	def icon
		"<span class='glyphicon glyphicon-arrow-right'></span>"
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
		image_tag user.avatar.url, class: "img-circle", alt: "Avatar"
	end

	def messageid(message, user)
		(message.user == user) ? "message-right" : ""
	end
end
