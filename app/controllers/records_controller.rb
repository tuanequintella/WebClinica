#encoding: utf-8
class RecordsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @records = Record.all
  end

  def search
    @records = Pacient.includes(:record).search(params[:pacient][:name]).map(&:record)
    render :search, :layout => false
  end

  def show
    @record = Record.find_by_id(params[:id])
    respond_with @record
  end

  def edit
    @record = Record.find_by_id(params[:id])
    render :edit, :layout => !request.xhr?
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

end

