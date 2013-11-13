#encoding: utf-8
class SecretariesController < ApplicationController
  load_and_authorize_resource

  def index
    @secretaries = Secretary.all
  end

  def new
    @secretary = Secretary.new
  end

  def create
    @secretary = Secretary.new(params[:secretary])
    @secretary.activate!
    
    if @secretary.save
      @secretary.deliver_reset_password_instructions!
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to secretaries_path
    else
		  render :new
    end
  end

  def show
    @secretary = Secretary.find_by_id(params[:id])
  end

  def edit
    @secretary = Secretary.find_by_id(params[:id])
  end

  def update
    @secretary = Secretary.find_by_id(params[:id])
    params[:secretary].delete :username
    @secretary.update_attributes(params[:secretary])
    if @secretary.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to secretaries_path
    else
      render :edit
    end
  end

  def destroy
    @secretary = Secretary.find_by_id(params[:id])
    
    if @secretary.deactivate!
      flash[:success] = 'Desativado com sucesso'
    else
      flash[:error] = 'Erro ao tentar desativar'
    end

    if @secretary == current_user
      redirect_to logout_path
    else
      redirect_to secretaries_path
    end
  end
  
  def recreate
    @secretary = Secretary.find(params[:secretary_id])
    @secretary.activate!

    if(@secretary.save)
      flash[:success] = "Usuário reativado com sucesso"
    else
      flash[:error] = "Erro ao reativar usuário"
    end
    redirect_to secretaries_path
  end
end
