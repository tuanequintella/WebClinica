class DoctorsController < ApplicationController
  load_and_authorize_resource

  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
    @doctor.agenda = Agenda.new
  end

  def create
    @doctor = Doctor.new(params[:doctor])
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



    if @doctor.destroy
      flash[:success] = 'Excluido com sucesso'
    else
      flash[:error] = 'Erro ao tentar excluir'
    end
    redirect_to doctors_path
  end
end

