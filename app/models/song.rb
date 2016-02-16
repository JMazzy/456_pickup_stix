class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :playlist_selections, dependent: :destroy
  has_many :playlists, through: :playlist_selections

  validates :artist, presence: true
  validates :name, presence: true
end
