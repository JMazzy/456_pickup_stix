class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  validates :user, presence: true
  validates :bookmarkable, presence: true
end
