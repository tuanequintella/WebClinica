#encoding: utf-8 
class CidsController < ApplicationController
  authorize_resource

  def index
    @cids = Cid.all
  end

  def import; end

  def load
    file = params[:cids][:import_file].tempfile
    has_errors = Cid.import(file)
    
    if has_errors
      flash[:error] = "Arquivo XML inválido!"
      render :import
    else 
      flash[:success] = "Arquivo importado com sucesso."
      redirect_to import_cids_path
    end
  end
end
