class PlaylistsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new( playlist_params )
    if @playlist.save
      flash[:success] = "Playlist created!"
      redirect_to playlist_path(@playlist)
    else
      flash[:error] = "Playlist NOT created due to errors!"
      render :new
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
    if  @playlist.update( playlist_params )
      flash[:success] = "Playlist updated!"
      redirect_to playlist_path(@playlist)
    else
      flash[:error] = "Playlist not updated due to errors!"
      render :edit
    end
  end

  def destroy
    playlist = Playlist.find(params[:id])
    if playlist.destroy
      flash[:success] = "Successfully deleted playlist."
      redirect_to current_user
    else
      flash[:error] = "Could not delete playlist"
      redirect_to current_user
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
