class UsersController < ApplicationController
  # before_filter :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis.paginate(page: params[:page])
  end

end