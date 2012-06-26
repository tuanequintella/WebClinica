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

  def reset_password
    @user = current_user
    @user.deliver_reset_password_instructions! if @user
    redirect_to(profile_path, :notice => "Instrucoes foram mandadas no seu e-mail.")
  end

end
