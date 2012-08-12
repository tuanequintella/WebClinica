class OfficesController < ApplicationController

  def show
    @office = Office.first
  end

  def edit
    @office = Office.first
  end

  def update
    @office = Office.first
    @office.update_attributes(params[:office])
    if @office.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to office_path(@office)
    else
      render :edit
    end
  end

  def notify_patients
    @office = Office.first
    #manda informações da clinica no email dos pacientes
    redirect_to(office_path(@office), :notice => "Atualizações da clinica foram enviadas aos pacientes.")
  end

end
