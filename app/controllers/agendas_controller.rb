#encoding: utf-8
class AgendasController < ApplicationController
  
  def index
    if params[:id]
      @agenda = Agenda.find(params[:id])
    else
      @agenda = Agenda.new
      @agenda.doctor = Doctor.new
    end
    
    if params[:date]
      @date = params[:date]
    else
      @date = Date.today
    end
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
    @agenda = Agenda.find_by_id(params[:id])
    @agenda.update_attributes(params[:agenda])
    if @agenda.save
      redirect_to agendas_path(id: @agenda)
    else
      render :edit, :layout => !request.xhr?
    end
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

