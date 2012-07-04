class OfficesController < ApplicationController

  def show
    @office = Office.find_by_id(params[:id])
  end

  def edit
    @office = Office.find_by_id(params[:id])
  end

  def update
    @office = Office.find_by_id(params[:id])
    @office.update_attributes(params[:office])
    if @office.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to office_path
    else
      render :edit
    end
  end

  def notify_patients
    #manda informações da clinica no email dos pacientes
    redirect_to(office_path, :notice => "Atualizações da clinica foram enviadas aos pacientes.")
  end

end
