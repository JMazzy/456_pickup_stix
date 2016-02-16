class SongsController < ApplicationController
  def show
    @song = Song.find(params[:id])
    @playlist_selection = PlaylistSelection.new
  end
end
