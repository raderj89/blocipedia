class WikisController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def new
    @wiki = current_user.wikis.new
    authorize! :new, @wiki, message: "You need to be a premium user to create wikis."
  end

  def create
    @wiki = current_user.wikis.build(params[:wiki])
    if @wiki.save
      flash[:success] = "Wiki created!"
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
    authorize! :read, @wiki, message: "You need to be signed up to view wikis."
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
