#encoding: utf-8
class RecordsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @records = Record.all
  end

  def search
    @records = Pacient.includes(:record).search(params[:pacient][:name]).map(&:record)
    render :search, :layout => false
  end

  def show
    @record = Record.find_by_id(params[:id])
    respond_with @record
  end

  def edit
    @record = Record.find_by_id(params[:id])
    render :edit, :layout => !request.xhr?
  end

  def update
    @record = Record.find_by_id(params[:id])

    @record.update_attributes(params[:record])
    if @record.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to edit_record_path(@record)
    else
      render :edit
    end
  end

  def update_appointment_status
    @record = Record.find(params[:record_id])
    @appointment = Appointment.find(params[:appointment_id])
    @appointment.update_attributes(status: params[:status])
    
    redirect_to edit_record_path(@record)
  end

  def export
    @record = Record.find_by_id(params[:id])
    timestamp = Time.now.to_i.to_s
    html = render_to_string(layout: false, template: "records/edit.html.erb")
    kit = PDFKit.new(html, :page_size => 'Letter')
    filename = "record" + @record.id.to_s + "_" + timestamp + ".pdf"

    send_data(kit.to_pdf, :filename => filename, :type => 'application/pdf')
    return
  end

end

