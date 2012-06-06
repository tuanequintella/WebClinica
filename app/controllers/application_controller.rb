class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, :except => [:not_authenticated]

  protected

  def not_authenticated
    redirect_to new_session_path, :alert => "Voce precisa estar logado."
  end

  def require_no_login
    if logged_in?
      redirect_to '/'
    end
  end

end
