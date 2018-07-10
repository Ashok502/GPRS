class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, default_url: "/assets/avatar.png"
  validates_attachment_content_type :avatar,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]

  has_many :posts, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :intrests, dependent: :destroy
  has_many :ads, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :username, presence: true, uniqueness: true, on: :update

  before_save :limit_intrests?, :limit_ads?


  def limit_intrests?
  	self.intrests.count
  end

  def limit_ads?
    self.ads.count
  end

end
