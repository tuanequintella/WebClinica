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
    if params[:appointment][:record_id].nil?
      pacient = Pacient.new(params[:pacient])
      pacient.record = Record.new(:status => Record::TEMP)
      pacient.save(:validate => false)
    else
      record = Record.find(params[:appointment][:record_id])
    end
    
    agenda = Agenda.find(params[:appointment][:agenda_id]) 
    @appointment = Appointment.new(:agenda => agenda, :record => record, :scheduled_at => params[:appointment][:scheduled_at])
    if @appointment.save
      redirect_to agenda_path(:id => @appointment.agenda, :date => @appointment.scheduled_at)
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

