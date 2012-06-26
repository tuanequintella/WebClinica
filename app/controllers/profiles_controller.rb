class ProfilesController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    params[:user].delete :username
    @user.update_attributes(params[:user])
    if @user.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to root_path
    else
      render :edit
    end
  end
end
