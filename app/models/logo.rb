class Logo < ApplicationRecord
  belongs_to :logable, polymorphic: true
  has_attached_file :logo 
  validates :logo, presence: true
  validates_attachment_content_type :logo,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
end
