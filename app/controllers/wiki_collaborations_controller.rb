class WikiCollaborationsController < ApplicationController

before_filter :authenticate_user!, only: [:new]

  def create
    @users = User.all

    # @wiki = Wiki.find(params[:id])
    # #@user = 
    # @wiki_collaboration = @wiki.wiki_collaborations.new(user_id: @user.id)
    # if @wiki_collaboration.save
    #   flash[:success] = "Added collaborators to wikis."
    #   redirect_to @wiki
    # else
    #   flash[:notice] = "Error adding collaborators."
    #   redirect_to :back
    # end
  end

  def new
    @wiki_collaboration = WikiCollaborations.new
    
  end
end