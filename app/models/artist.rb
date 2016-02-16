class Artist < ActiveRecord::Base
  has_many :songs
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  validates :name, presence: true
end
