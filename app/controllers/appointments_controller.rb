#encoding: utf-8
class AppointmentsController < ApplicationController
  load_and_authorize_resource

  #def index
  #  @agenda = Agenda.new
  #  @agenda.doctor = Doctor.new
  #end

  def show
    @appointment = Appointment.find(params[:id])
    #@week = @agenda.week(params[:date])
    render :show, :layout => !request.xhr?
  end

  def new
    @appointment = Appointment.new
    @appointment.scheduled_at = params[:date]
    @appointment.agenda = Agenda.find(params[:agenda_id])
    render :new, :layout => !request.xhr?
  end

  def create
    @appointment = Appointment.new(params[:appointment])
    #TODO: tratar os outros parametros que vem (record, pacient...)
    if @appointment.save
      redirect_to agenda_path(@appointment.agenda)
    else
		  render :new
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @record = @appointment.record
    render :edit, :layout => !request.xhr?
  end

  def update
    #bla
  end

  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.deactivate!

    if(@agenda.save)
      flash[:success] = "Agenda desativada com sucesso"
    else
      flash[:error] = "Erro ao desativar agenda"
    end
    redirect_to edit_doctor_path(@agenda.doctor)
  end

  def recreate
    @agenda = Agenda.find(params[:agenda_id])
    @agenda.activate!

    if(@agenda.save)
      flash[:success] = "Agenda reativada com sucesso"
    else
      flash[:error] = "Erro ao reativar agenda"
    end
    redirect_to edit_doctor_path(@agenda.doctor)
  end

end

