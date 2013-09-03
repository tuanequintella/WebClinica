#encoding: utf-8 
class HealthInsurancesController < ApplicationController
  load_and_authorize_resource

  def index
    @health_insurances = HealthInsurance.all
  end

  def new
    @health_insurance = HealthInsurance.new
  end

  def create
    @health_insurance = HealthInsurance.new(params[:health_insurance])
    @health_insurance.activate!
    
    if @health_insurance.save
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to health_insurances_path
    else
		  render :new
    end
  end

  def edit
    @health_insurance = HealthInsurance.find_by_id(params[:id])
  end

  def update
    @health_insurance = HealthInsurance.find_by_id(params[:id])
    params[:health_insurance].delete :username
    @health_insurance.update_attributes(params[:health_insurance])
    if @health_insurance.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to health_insurances_path
    else
      render :edit
    end
  end

  def destroy
    if HealthInsurance.where(:active=>true).count == 1
      flash[:error] = 'Não é possível desativar todos os convênios.'
      redirect_to health_insurances_path
    else
      @health_insurance = HealthInsurance.find_by_id(params[:id])
      @health_insurance.deactivate!
      
      if @health_insurance.save
        flash[:success] = 'Desativado com sucesso'
      else
        flash[:error] = 'Erro ao tentar desativar'
      end
      
      redirect_to health_insurances_path
    end
  end
  
  def recreate
    @health_insurance = HealthInsurance.find(params[:health_insurance_id])
    @health_insurance.activate!

    if(@health_insurance.save)
      flash[:success] = "Registro reativado com sucesso"
    else
      flash[:error] = "Erro ao reativar registro"
    end
    redirect_to health_insurances_path
  end
end
