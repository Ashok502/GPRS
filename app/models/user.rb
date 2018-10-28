class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_attached_file :avatar, default_url: "/assets/avatar.png"
  validates_attachment_content_type :avatar,
  :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  
  has_many :posts, dependent: :destroy
  has_many :intrests, dependent: :destroy
  has_many :ads, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :sent_requests, foreign_key: :sender_id, class_name: "Friend"
  has_many :received_requests, foreign_key: :receiver_id, class_name: "Friend"
  has_many :comments, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :username, presence: true, uniqueness: true, on: :update

  validates :country, :state, :city, :pincode, :address, presence: true, on: :update

  before_save :limit_intrests?, :limit_ads?
  geocoded_by :address?
  after_validation :geocode, :if => :city_changed?
  after_update_commit {AppearanceBroadcastJob.perform_later self}

  scope :search, -> (search, user) { where("username ilike (?) AND id NOT IN (?)", "#{search}%", user)}

  def limit_intrests?
  	self.intrests.count
  end

  def address?
    "#{self.city}, #{self.state}, #{self.country}"
  end

  def limit_galleries?
    self.galleries.count
  end

  def limit_ads?
    self.ads.count
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
    end
  end
end
