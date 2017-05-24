class UsersController < ApplicationController
  before_action only: [:show] { authenticate! :user }

  def index
    @users = User.all

    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])

    render json: @user, status: :ok
  end
end
