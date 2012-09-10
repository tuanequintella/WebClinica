class AgendasController < ApplicationController
  load_and_authorize_resource

  def index
    @agenda = Agenda.new
    @agenda.doctor = Doctor.new
  end

  def show
    @agenda = Agenda.find_by_id(params[:id])
    @week = @agenda.week(params[:date])
    render :show, :layout => !request.xhr?
  end

  def edit
    @agenda = Agenda.find_by_id(params[:id])
  end

  def update
    #bla
  end

end
