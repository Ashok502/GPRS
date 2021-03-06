class Gallery < ApplicationRecord
	belongs_to :user
	has_attached_file :image
	validates :image, presence: true
	validates_attachment_content_type :image,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]

    def to_file_upload
    {
      "url" => image.url
    }
  end
end
