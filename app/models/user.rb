class User < ActiveRecord::Base
  has_secure_password

  before_create :generate_token

  # Required
  has_many :bookmarks, dependent: :destroy
  has_many :playlists, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  # Optional
  has_many :initiated_followings, class_name: "Following", foreign_key: :followed_id
  has_many :received_followings, class_name: "Following", foreign_key: :follower_id
  has_many :followers, class_name: "User"
  has_many :followeds, class_name: "User"

  def generate_token
   begin
     self[:auth_token] = SecureRandom.urlsafe_base64
   end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
   self.auth_token = nil
   generate_token
   save!
  end

  def name
    first_name + " " + last_name
  end

  def playlist_count
    self.playlists.count(:id)
  end
end
