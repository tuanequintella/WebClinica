#encoding: utf-8 
class CidsController < ApplicationController
  authorize_resource

  def index
    @cids = Cid.all
  end

  def import; end

  def load
    before = Cid.count
    file = params[:cids][:import_file].tempfile
    success = Cid.import(file)
    new_count = Cid.count - before

    if success
      flash[:success] = "Importação sem falhas! " + Cid.count.to_s + " registros na base. " + new_count.to_s + " registros novos."
      redirect_to import_cids_path
    else
      flash[:error] = "Arquivo XML inválido!"
      render :import
    end
  end
end
