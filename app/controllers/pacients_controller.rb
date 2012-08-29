class PacientsController < ApplicationController
  load_and_authorize_resource

  def index
    @pacients = Pacient.all
  end

  def new
    @pacient = Pacient.new
    @pacient.record = Record.new
  end

  def create
    @pacient = Pacient.new(params[:pacient])
    if @pacient.save
      flash[:READTHIS] = I18n.t('activerecord.attributes.record.warning', :id => @pacient.record.id)
      redirect_to pacients_path
    else
		  render :new
    end
  end

  def show
    @pacient = Pacient.find_by_id(params[:id])
  end

  def edit
    @pacient = Pacient.find_by_id(params[:id])
  end

  def update
    @pacient = Pacient.find_by_id(params[:id])
    params[:pacient].delete :username
    @pacient.update_attributes(params[:pacient])
    if @pacient.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to pacients_path
    else
      render :edit
    end
  end

  def destroy
    @pacient = Pacient.find_by_id(params[:id])

    if @pacient.destroy
      flash[:success] = 'Excluido com sucesso'
    else
      flash[:error] = 'Erro ao tentar excluir'
    end
    redirect_to pacients_path
  end
end
