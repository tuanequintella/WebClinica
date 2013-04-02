#encoding: utf-8
class PacientsController < ApplicationController
  load_and_authorize_resource

  def index
    @pacients = Pacient.all
  end

  def search
    @pacients = Pacient.search(params[:pacient][:name])
    render :search, :layout => false
  end

  def new
    @pacient = Pacient.new
    @pacient.record = Record.new
  end

  def create
    @pacient = Pacient.new(params[:pacient])
    
    if @pacient.save
      unless(@pacient.record.status == Record::NEW)
        ap = Appointment.new(:scheduled_at => params[:last_appointment_date], :record => @pacient.record)
        ap.save
        @pacient.record.last_appointment = ap
        @pacient.record.save
        flash[:READTHIS] = I18n.t('activerecord.attributes.record.warning', :id => "%04d" % @pacient.record.id)
      end
      redirect_to pacients_path
    else
		  render :new
    end
  end

  def show
    @pacient = Pacient.find_by_id(params[:id])
  end

  def edit
    @pacient = Pacient.find_by_id(params[:id])
  end

  def update
    @pacient = Pacient.find_by_id(params[:id])
    params[:pacient].delete :username
    @pacient.update_attributes(params[:pacient])
    if @pacient.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to pacients_path
    else
      render :edit
    end
  end

  def destroy
    @pacient = Pacient.find_by_id(params[:id])
    @pacient.record.deactivate!
    
    if @pacient.record.save
      flash[:success] = 'Desativado com sucesso'
    else
      flash[:error] = 'Erro ao tentar desativar'
    end
    redirect_to pacients_path
  end
  
  def recreate
    @pacient = Pacient.find(params[:pacient_id])
    @pacient.record.activate!

    if(@pacient.record.save)
      flash[:success] = "Paciente reativado com sucesso"
    else
      flash[:error] = "Erro ao reativar paciente"
    end
    redirect_to pacients_path
  end
end
