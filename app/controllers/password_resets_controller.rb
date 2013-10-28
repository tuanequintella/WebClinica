#encoding: utf-8
class PasswordResetsController < ApplicationController
  layout 'outside'
  skip_before_filter :require_login

  def new
    redirect_to(new_session_path)
  end

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    flash[:warning] = "Instruções foram mandadas no seu e-mail."
    redirect_to new_session_path
  end


  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated if !@user
  end


  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if !@user

    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password!(params[:user][:password])
      auto_login(@user)
      flash[:success] = "Senha alterada com sucesso."
      redirect_to root_path
    else
      render :action => "edit"
    end
  end

end
