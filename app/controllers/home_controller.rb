#encoding: utf-8
class HomeController < ApplicationController

  def index
    if current_user.is_a? Admin
      redirect_to admins_path
    elsif  current_user.is_a? Secretary
      redirect_to pacients_path
    elsif current_user.is_a? Doctor
      redirect_to day_index_appointments_path
    end
  end

end
