class PlaylistSelectionsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @playlist_selection = PlaylistSelection.new( ps_params )
    if @playlist_selection.save
      flash[:success] = "Created Playlist Selection!"
    else
      flash[:error] = "Could not create!"
    end
    redirect_to :back
  end

  def destroy
    @playlist_selection = PlaylistSelection.find(params[:id])
    if @playlist_selection.destroy
      flash[:success] = "Destroyed Playlist Selection!"
    else
      flash[:error] = "Could not destroy!"
    end
    redirect_to :back
  end

  private

  def ps_params
    params.require(:playlist_selection).permit(:playlist_id, :song_id)
  end
end
