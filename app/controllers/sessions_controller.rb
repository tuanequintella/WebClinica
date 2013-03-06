#encoding: utf-8 
class SessionsController < ApplicationController
  layout 'outside'
  skip_before_filter :require_login, :except => [:destroy]
  before_filter :require_no_login, :except => [:destroy]

  def new; end

  def create
    if @user = login(params[:user][:username],params[:user][:password],params[:remember])
      if(@user.active?)
        redirect_back_or_to root_path
      else
        flash.now[:error] = "Usuário desativado."
		    render :action => "new"
		  end
    else
		  flash.now[:error] = "Nome de usuário ou senha inválidos."
		  render :action => "new"
    end
  end

  def destroy
    logout
    redirect_to new_session_path
  end

end
