class WikisController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  uses_markdown_preview

  def new
    @wiki = current_user.wikis.new
    authorize! :new, @wiki, message: "You need to be a premium user to create wikis."
  end

  def create
    @wiki = current_user.wikis.build(params[:wiki])
    if @wiki.save
      flash[:notice] = "Wiki created!"
      redirect_to @wiki
    else
      render :new
    end
  end

  def show
    @users = User.all # Why do I have to list all users here
                      # and am unable to do so in 
                      # wiki_collaborations controller?
    @wiki = Wiki.find(params[:id])
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
    authorize! :read, @wiki, message: "You need to be signed up to view wikis."
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize! :edit, @wiki, message: "You need to own the wiki to update it."
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize! :edit, @wiki, message: "You need to own the wiki to update it."
    if @wiki.update_attributes(params[:wiki])
      flash[:success] = "Your changes have been made."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
    end
  end

  def destroy
    @wiki.find(params[:id])
    authorize! :destroy, @wiki, message: "You need to own the wiki to delete it."
    if @wiki.destroy
      flash[:notice] = "Wiki deleted."
      redirect_to root_url
    else
      flash[:error] = "Error deleting wiki. Please try again."
      render :show
    end
  end
end
