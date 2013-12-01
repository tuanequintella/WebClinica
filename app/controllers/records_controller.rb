#encoding: utf-8
class RecordsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    if params[:name]
      @records = Pacient.includes(:record).quick_search(params[:name]).map(&:record)
    else
      @records = Record.all
    end
  end

  def search
    @records = Pacient.includes(:record).quick_search(params[:pacient][:name]).map(&:record)
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
    @appointment.status = params[:status]
    @appointment.save(validate: false)
    
    redirect_to edit_record_path(@record)
  end

  def export
    @record = Record.find_by_id(params[:id])
    @pacient = @record.pacient
    timestamp = Time.now.to_i.to_s
    html = render_to_string(layout: false, template: "records/show.html.erb")
    kit = PDFKit.new(html, :page_size => 'Letter')
    kit.stylesheets << "#{Rails.root.to_s}/app/assets/stylesheets/pdf_export.css"

    filename = @record.pacient.name.split(" ").first + "_" + @record.pacient.name.split(" ").last + "_" + timestamp + ".pdf"

    send_data(kit.to_pdf, :filename => filename, :type => 'application/pdf')
    return
  end

end

