class RecordsController < ApplicationController
  load_and_authorize_resource

  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(params[:record])
    if @record.save
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to records_path
    else
		  render :new
    end
  end

  def show
    @record = Record.find_by_id(params[:id])
  end

  def edit
    @record = Record.find_by_id(params[:id])
  end

  def update
    @record = Record.find_by_id(params[:id])

    @record.update_attributes(params[:record])
    if @record.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to records_path
    else
      render :edit
    end
  end

  def destroy
    @record = Record.find_by_id(params[:id])

    if @record.destroy
      flash[:success] = 'Excluido com sucesso'
    else
      flash[:error] = 'Erro ao tentar excluir'
    end
    redirect_to records_path
  end
end

