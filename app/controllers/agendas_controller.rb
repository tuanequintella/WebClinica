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

    params[:agenda][:available_days_attributes].each_pair do |day, attrs|
      attrs["work_start_t"] = Time.zone.parse(attrs["work_start_t"])
      attrs["interval_start_t"] = Time.zone.parse(attrs["interval_start_t"]) unless attrs["interval_start_t"].blank? 
      attrs["interval_end_t"] = Time.zone.parse(attrs["interval_end_t"]) unless attrs["interval_end_t"].blank?
      attrs["work_end_t"] = Time.zone.parse(attrs["work_end_t"])
    end
    
    @agenda.update_attributes(params[:agenda])
    
    if @agenda.save
      render json: {url: agendas_path(:id => @agenda_id)}
    else
      render json: { errors: true, messages: @agenda.errors.full_messages }
    end
  end

  def destroy
    @agenda = Agenda.find(params[:id])
    

    if @agenda.deactivate!
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

