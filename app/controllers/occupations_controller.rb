#encoding: utf-8 
class OccupationsController < ApplicationController
  load_and_authorize_resource

  def index
    @occupations = Occupation.all
  end

  def new
    @occupation = Occupation.new
  end

  def create
    @occupation = Occupation.new(params[:occupation])
    @occupation.activate!
    
    if @occupation.save
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to occupations_path
    else
      render :new
    end
  end

  def edit
    @occupation = Occupation.find_by_id(params[:id])
  end

  def update
    @occupation = Occupation.find_by_id(params[:id])
    @occupation.update_attributes(params[:occupation])
    if @occupation.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to occupations_path
    else
      render :edit
    end
  end

  def destroy
    if Occupation.where(:active=>true).count == 1
      flash[:error] = 'Não é possível desativar todas as especialidades.'
      redirect_to occupations_path
    else
      @occupation = Occupation.find(params[:id])
      
      if @occupation.deactivate!
        flash[:success] = 'Desativada com sucesso'
      else
        flash[:error] = 'Erro ao tentar desativar'
      end
      
      redirect_to occupations_path
    end
  end
  
  def recreate
    @occupation = Occupation.find(params[:occupation_id])
    @occupation.activate!

    if(@occupation.save)
      flash[:success] = "Registro reativado com sucesso"
    else
      flash[:error] = "Erro ao reativar registro"
    end
    redirect_to occupations_path
  end
end
