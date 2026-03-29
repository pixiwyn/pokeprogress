class V1::Auth::AuthController < ApplicationController
  skip_before_action :authenticate_user,  only: [:signup, :login]

  def signup
    user = User.new(auth_params)

    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, user: { id: user.id, email: user.email, username: user.username } }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, user: { id: user.id, email: user.email, username: user.username } }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    head :no_content
  end

  private

  def auth_params
    params.permit(:email, :username, :password, :password_confirmation)
  end
end
