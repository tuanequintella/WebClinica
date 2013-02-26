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



    if @secretary.destroy
      flash[:success] = 'Excluido com sucesso'
    else
      flash[:error] = 'Erro ao tentar excluir'
    end
    redirect_to secretaries_path
  end
end
