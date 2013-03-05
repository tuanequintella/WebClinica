class AgendasController < ApplicationController
  load_and_authorize_resource

  def index
    @agenda = Agenda.new
    @agenda.doctor = Doctor.new
  end

  def show
    @agenda = Agenda.find_by_id(params[:id])
    @week = @agenda.week(params[:date])
    render :show, :layout => !request.xhr?
  end

  def edit
    @agenda = Agenda.find_by_id(params[:id])
    @doctor = @agenda.doctor
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

end

