#encoding: utf-8
class AppointmentsController < ApplicationController
  authorize_resource
  respond_to :html, :json
  
  def index
    if current_user.is_a? Doctor
      agenda = Agenda.where(doctor_id: current_user.id).first
      @appointments = agenda.appointments.select{ |ap| ap.scheduled_at <= 2.hours.from_now && ap.scheduled_at >= 2.hours.ago }
      render :doctor_index
    else
      @doctors = Doctor.active
      render :secretary_index
    end
  end

  def show
    @appointment = Appointment.find_by_id(params[:id])
    respond_with @appointment
  end

  def create
    record_params = params[:appointment][:record] rescue nil
    params[:appointment].delete :record
    @appointment = Appointment.new(params[:appointment])

    if @appointment.record.blank?
      pacient = Pacient.new(record_params[:pacient])
      unless pacient.name.blank? || pacient.phone.blank?
        record = Record.create(status: :new)
        pacient.record = record
        pacient.save(:validate => false)
        @appointment.record = record
      end
    end

    if @appointment.save
      render json: {url: agendas_path(:id => @appointment.agenda_id, :date => @appointment.scheduled_at.to_date)}
    else
      render json: { errors: true }
    end
  end

  def update_status
    @appointment = Appointment.find(params[:id])
    @appointment.update_attributes(status: params[:status])
    
    redirect_to appointments_path
  end

  def update
    record_params = params[:appointment][:record] rescue nil
    params[:appointment].delete :record
    @appointment = Appointment.find(params[:id])
    @appointment.update_attributes(params[:appointment])

    if @appointment.record.blank?
      pacient = Pacient.new(record_params[:pacient])
      unless pacient.name.blank? || pacient.phone.blank?
        record = Record.create(status: :new)
        pacient.record = record
        pacient.save(:validate => false)
        @appointment.record = record
      end
    end
    
    if @appointment.save
      render json: {url: agendas_path(:id => @appointment.agenda_id, :date => @appointment.scheduled_at.to_date)}
    else
      render json: { errors: true }
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    agenda = @appointment.agenda
    date = @appointment.scheduled_at
    #if it was the first appointment, no need to mantain the pacient's record 
    if @appointment.record.status.new?
      @appointment.record.deactivate!
    end
    @appointment.destroy

    redirect_to agendas_path(:id => agenda, :date => date)
  end

end

