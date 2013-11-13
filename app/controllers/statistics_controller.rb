#encoding: utf-8
class StatisticsController < ApplicationController
  require 'socket'
  require "gchart"
  respond_to :html, :xlsx

  def index; end

  def age
    if params[:age_search][:age_from].present? && params[:age_search][:age_to].present?
      @pacients = Pacient.params_search(params[:age_search]) 
      @cid = Cid.find(params[:age_search][:cid_id])

      respond_to do |format|
        format.html
        format.xlsx { render xlsx: "age", disposition: "attachment", filename: "idades_cid" + @cid.code + "_" + Time.now.to_i.to_s + ".xlsx" }
      end

    else
      flash[:error] = "Preencha todos os parâmetros de busca"
      render :index
    end
  end

  def time
    if params[:time_search][:date_from].present? && params[:time_search][:date_to].present?
      @record_entries = RecordEntry.params_search(params[:time_search]) 
      @cid = Cid.find(params[:time_search][:cid_id])

      respond_to do |format|
        format.html
        format.xlsx { render xlsx: "time", disposition: "attachment", filename: "tempo_cid" + @cid.code + "_" + Time.now.to_i.to_s + ".xlsx" }
      end

    else
      flash[:error] = "Preencha todos os parâmetros de busca"
      render :index
    end
  end

end