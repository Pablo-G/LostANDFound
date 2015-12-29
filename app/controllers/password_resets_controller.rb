class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(perishable_token: params[:id])
    if !@user
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(perishable_token: params[:id])

    if @user.update_attributes(password_reset_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def password_reset_params
    params.permit(:password,:password_confirmation)
  end
  
end
