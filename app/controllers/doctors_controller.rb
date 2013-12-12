#encoding: utf-8
class DoctorsController < ApplicationController
  load_and_authorize_resource

  def index
    @doctors = Doctor.all.sort_by{ |p| [p.active_number, p.name] }
  end

  def new
    @doctor = Doctor.new
    @doctor.agenda = Agenda.new
  end

  def create
    fixed_hi = HealthInsurance.where(name: 'Sem convênio (particular)').first.id
    params[:doctor][:health_insurance_ids] = (params[:doctor][:health_insurance_ids] + [fixed_hi.to_s]).uniq
    
    params[:doctor][:agenda_attributes][:available_days_attributes].each_pair do |day, attrs|
      attrs["work_start_t"] = Time.zone.parse(attrs["work_start_t"])
      attrs["interval_start_t"] = Time.zone.parse(attrs["interval_start_t"]) unless attrs["interval_start_t"].blank? 
      attrs["interval_end_t"] = Time.zone.parse(attrs["interval_end_t"]) unless attrs["interval_end_t"].blank?
      attrs["work_end_t"] = Time.zone.parse(attrs["work_end_t"])
    end

    @doctor = Doctor.new(params[:doctor])
    @doctor.activate!
    @doctor.agenda.activate!
    if @doctor.save
      @doctor.deliver_reset_password_instructions!
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to doctors_path
    else
      render :new
    end
  end

  def show
    @doctor = Doctor.find_by_id(params[:id])
  end

  def edit
    @doctor = Doctor.find_by_id(params[:id])
  end

  def update
    @doctor = Doctor.find_by_id(params[:id])
    params[:doctor].delete :username
    fixed_hi = HealthInsurance.where(name: 'Sem convênio (particular)').first.id
    params[:doctor][:health_insurance_ids] = (params[:doctor][:health_insurance_ids] + [fixed_hi.to_s]).uniq

    @doctor.update_attributes(params[:doctor])
    if @doctor.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to doctors_path
    else
      render :edit
    end
  end

  def destroy
    @doctor = Doctor.find_by_id(params[:id])
    
    if @doctor.deactivate!
      @doctor.agenda.deactivate!
      flash[:success] = 'Desativado com sucesso'
    else
      flash[:error] = 'Erro ao tentar desativar'
    end
    
    if @doctor == current_user
      redirect_to logout_path
    else
      redirect_to doctors_path
    end
  end
  
  def recreate
    @doctor = Doctor.find(params[:doctor_id])
    @doctor.activate!
    @doctor.agenda.activate!

    if(@doctor.save)
      flash[:success] = "Usuário reativado com sucesso"
    else
      flash[:error] = "Erro ao reativar usuário"
    end
    redirect_to doctors_path
  end
end

