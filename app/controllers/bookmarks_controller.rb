class BookmarksController < ApplicationController
  before_action :require_login

  def create
    @bookmark = Bookmark.new( bookmark_params )
    if @bookmark.save
      flash[:success] = "Created bookmark"
    else
      flash[:error] = "Could not create"
    end
    redirect_to :back
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:success] = "Destroyed bookmark"
    else
      flash[:error] = "Could not destroy"
    end
    redirect_to :back
  end

  private

  def bookmark_params
    params.permit(:user_id, :bookmarkable_type, :bookmarkable_id )
  end
end
