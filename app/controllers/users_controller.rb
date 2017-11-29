class UsersController < ApplicationController

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: {status: "User created successfully"}, status: :bad_request
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end

  def show
    user_id = params[:id]
    user = User.find_by(id: usert_id)
    render json: user.as_json
  end

end
