class Image < ApplicationRecord
  has_attached_file :file
  validates_attachment_content_type :file,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]

end
