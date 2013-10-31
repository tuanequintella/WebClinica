#encoding: utf-8 
class RecordEntriesController < ApplicationController
  authorize_resource

  def index
    @record_entries = RecordEntry.all
  end

  def show
    @record_entry = RecordEntry.find(params[:id])
    render :show, :layout => !request.xhr? 
  end

  def new
    @appointment = Appointment.find(params[:appointment_id])
    @record = @appointment.record
    @record_entry = RecordEntry.where(appointment_id: @appointment.id).first_or_initialize
    render :new, :layout => !request.xhr?
  end

  def create
    @record_entry = RecordEntry.new(params[:record_entry])
    @appointment = @record_entry.appointment
    @record = @appointment.record
    if @record_entry.save
      flash[:success] = 'Consulta salva com sucesso.'
      redirect_to appointments_path
    else
      render :new
    end
  end

  def update
    @record_entry = RecordEntry.find(params[:id])
    @appointment = @record_entry.appointment
    @record = @appointment.record
    
    @record_entry.update_attributes(params[:record_entry])

    if @record_entry.save
      flash[:success] = 'Consulta salva com sucesso.'
      redirect_to appointments_path
    else
      render :new
    end
  end
end