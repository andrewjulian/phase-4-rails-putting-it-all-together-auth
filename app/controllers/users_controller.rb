class UsersController < ApplicationController

  skip_before_action :authorize, only: [:create]
  
  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: session[:user_id])
    render json: user, status: :created
  end

  private

  def user_params()
    params.permit(:id, :username, :password, :password_confirmation, :bio, :image_url)
  end

end

