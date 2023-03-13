class UsersController < ApplicationController
  before_action :set_user, only: %i[show follow unfollow following update destroy]
  before_action :set_followed_user, only: %i[follow unfollow]

  # # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # # GET /users/1
  def show
    render json: @user
  end

  def follow
    @follow = Follow.new(from_user_id: @user.id, to_user_id: params[:user_id])
    if @follow.save
      render json: "#{@user.name} followed #{@followed_user.name}.", status: :created
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    render json: "#{@user.name} already follows #{@followed_user.name}.", status: :unprocessable_entity
  end

  def unfollow
    @follow = Follow.where(from_user_id: @user.id, to_user_id: params[:user_id])
    if @follow.exists?
      @follow.first.destroy
      render json: "#{@user.name} unfollowed #{@followed_user.name}."
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  rescue StandardError
    render json: "#{@user.name} does not follow #{@followed_user.name}.", status: :unprocessable_entity
  end

  def following
    @followed_user = User.find(params[:user_id])
    if @user.follows?(params[:user_id])
      render json: @followed_user, include: ['sleeps_last_week']
    else
      render json: "#{@user.name} is not following #{@followed_user.name}", status: :unprocessable_entity
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end

  def set_followed_user
    @followed_user = User.find(params[:user_id])
  end
end
