class SessionsController < ApplicationController
  layout 'outside'
  skip_before_filter :require_login, :except => [:destroy]
  before_filter :require_no_login, :except => [:destroy]

  def new; end

  def create
    if @user = login(params[:user][:username],params[:user][:password],params[:remember])
      redirect_back_or_to root_path
    else
		  flash.now[:error] = "Login invalido."
		  render :action => "new"
    end
  end

  def destroy
    logout
    redirect_to new_session_path
  end

end
