class WikiCollaborationsController < ApplicationController
before_filter :setup, only: [:create]  # Best way to accomplish this?
before_filter :authenticate_user!, only: [:create]

  def add_or_remove
  end

  ## TODO: If wiki already has some collaborations and no new values are selected, do not attempt
  ## a save and flash the correct notification
  ## TODO: Ajaxify
  def create
    @user_ids = params[:user_ids]
    @user_ids.each do |user_id| 
      next if @collaborator_ids.include?(user_id.to_i)
      @wiki_collaboration = @wiki.wiki_collaborations.new(wiki_id: @wiki, user_id: user_id)
      @wiki_collaboration.save
    end
    flash[:success] = "Collaborators added."
    redirect_to @wiki
  end

  ## TODO: Ajaxify

  def destroy
    @wiki_collaboration = WikiCollaboration.find(params[:id])
    if @wiki_collaboration.destroy
      flash[:notice] = "User removed."
      redirect_to :back
    end
  end

  private

  def setup
    @wiki = Wiki.find(params[:wiki_id]) # Should this be
                                        # @wiki = current_user.wikis.find(params[:wiki_id]) ?
    @wiki_collaborations = @wiki.wiki_collaborations
    @wiki_users = @wiki.users
    @collaborator_ids = []
    @wiki_users.each { |user| @collaborator_ids << user.id }
  end
end