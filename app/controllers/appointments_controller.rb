#encoding: utf-8
class AppointmentsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.is_a? Doctor
      agenda = Agenda.where(doctor_id: current_user.id).first
      @appointments = agenda.appointments.select{ |ap| ap.scheduled_at.to_date == Date.today }
      render :doctor_index
    else
      @doctors = Doctor.active
      render :secretary_index
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    render :show, :layout => !request.xhr?
  end

  def new
    @appointment = Appointment.new
    @appointment.scheduled_at = params[:date]
    @appointment.agenda = Agenda.find(params[:agenda_id])
    render :new, :layout => !request.xhr?
  end

  def create
    if params[:appointment][:record_id].blank?
      pacient = Pacient.new(params[:pacient])
      record = Record.create(:status => Record::TEMP)
      pacient.record = record
      pacient.save(:validate => false)
    else
      record = Record.find(params[:appointment][:record_id])
    end
    
    agenda = Agenda.find(params[:appointment][:agenda_id]) 
    @appointment = Appointment.new(:agenda => agenda, :record => record, :scheduled_at => params[:appointment][:scheduled_at])
    if @appointment.save
      redirect_to agendas_path(:id => @appointment.agenda, :date => @appointment.scheduled_at)
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
    @appointment = Appointment.find(params[:id])
    agenda = @appointment.agenda
    date = @appointment.scheduled_at
    @appointment.destroy

    redirect_to agendas_path(:id => agenda, :date => date)
  end

end

