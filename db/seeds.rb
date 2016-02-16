# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ----------------------------------------
# Seed Config Vars
# ----------------------------------------

MULTIPLIER = 3
NUM_USERS = 10
NUM_SONGS = 50
NUM_PLAYLISTS = 100
NUM_PLAYLIST_SELECTIONS = 200
NUM_BOOKMARKS = 100
NUM_FOLLOWINGS = 5


# ----------------------------------------
# Helper Functions
# ----------------------------------------

require './spec/support/model_helper'


# ----------------------------------------
# Clean Database
# ----------------------------------------

if Rails.env == 'development'
  puts 'Reseting database'

  Rake::Task['db:migrate:reset'].invoke
end


# ----------------------------------------
# Artists
# ----------------------------------------

puts 'Creating Artists'

artists = []
ModelHelper::ARTIST_NAMES.each do |artist_name|
  artists << {
    :name => artist_name
  }
end
Artist.create(artists)
artists = Artist.all


# ----------------------------------------
# Create Users
# ----------------------------------------

puts 'Creating Users'

users = [
  {
    :first_name => 'foo',
    :last_name => 'bar',
    :email => 'foo@bar.com',
    password: 'password'
  }
]
(MULTIPLIER * NUM_USERS).times do
  first_name = ModelHelper.first_name
  last_name = ModelHelper.last_name
  email = ModelHelper.email("#{first_name} #{last_name}")
  password = "password"
  password_confirmation = "password"

  users << {
    :first_name => first_name,
    :last_name => last_name,
    :email => email,
    password: password,
    password_confirmation: password_confirmation
  }
end
User.create(users)
users = User.all


# ----------------------------------------
# Create Songs
# ----------------------------------------

puts 'Creating Songs'

songs = []
(MULTIPLIER * NUM_SONGS).times do
  songs << {
    :name => ModelHelper.song_name,
    :artist_id => artists.sample.id
  }
end
Song.create(songs)
songs = Song.all


# ----------------------------------------
# Create Playlists
# ----------------------------------------

puts 'Creating Playlists'

playlists = []
(MULTIPLIER * NUM_PLAYLISTS).times do
  user = users.sample

  playlists << {
    :name => ModelHelper.playlist_name,
    :user_id => user.id
  }
end
Playlist.create(playlists)
playlists = Playlist.all


# ----------------------------------------
# Create PlaylistSelections
# ----------------------------------------

puts 'Creating PlaylistSelections'

playlist_selections = []
(MULTIPLIER * NUM_PLAYLIST_SELECTIONS).times do
  playlist = playlists.sample
  song = songs.sample

  playlist_selections << {
    :playlist_id => playlist.id,
    :song_id => song.id
  }
end
PlaylistSelection.create(playlist_selections)
playlist_selections = PlaylistSelection.all


# ----------------------------------------
# Bookmarks
# ----------------------------------------

puts 'Creating Bookmarks'

bookmarks = []
(MULTIPLIER * NUM_BOOKMARKS).times do
  bookmarkable = [
    playlists.sample,
    songs.sample,
    artists.sample
  ].sample

  bookmark_attributes = {
    :user_id => users.sample.id,
    :bookmarkable_type => bookmarkable.class.to_s,
    :bookmarkable_id => bookmarkable.id
  }

  bookmarks << bookmark_attributes unless bookmarks.include?(bookmark_attributes)
end
Bookmark.create(bookmarks)
bookmarks = Bookmark.all



# ----------------------------------------
# Followings
# ----------------------------------------

puts 'Creating Followings'

followings = []
already_followed_ids = []
(MULTIPLIER * NUM_FOLLOWINGS).times do
  if already_followed_ids.empty?
    followed = users.sample
  else
    followed = users.where('id NOT IN (?)', already_followed_ids).sample
  end

  possible_followers = users.where('id != ?', followed.id).to_a
  already_followed_ids << followed.id

  NUM_FOLLOWINGS.times do
    follower = possible_followers.pop
    followings << {
      :follower_id => follower.id,
      :followed_id => followed.id
    }
  end
end
Following.create(followings)
followings = Following.all


# ----------------------------------------
# Finished Seeding
# ----------------------------------------

puts 'Done!'
