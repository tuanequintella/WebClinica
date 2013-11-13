#encoding: utf-8 
class AdminsController < ApplicationController
  load_and_authorize_resource

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    @admin.activate!
    
    if @admin.save
      @admin.deliver_reset_password_instructions!
      flash[:success] = 'Cadastrado com sucesso.'
      redirect_to admins_path
    else
		  render :new
    end
  end

  def edit
    @admin = Admin.find_by_id(params[:id])
  end

  def update
    @admin = Admin.find_by_id(params[:id])
    params[:admin].delete :username
    @admin.update_attributes(params[:admin])
    if @admin.save
      flash[:success] = 'Atualizado com sucesso.'
      redirect_to admins_path
    else
      render :edit
    end
  end

  def destroy
    if Admin.where(:active=>true).count == 1
      flash[:error] = 'Não é possível desativar todos os administradores.'
      redirect_to admins_path
    else
      @admin = Admin.find_by_id(params[:id])
      
      if @admin.deactivate!
        flash[:success] = 'Desativado com sucesso'
      else
        flash[:error] = 'Erro ao tentar desativar'
      end
      
      if @admin == current_user
        redirect_to logout_path
      else
        redirect_to admins_path
      end
    end
  end
  
  def recreate
    @admin = Admin.find(params[:admin_id])
    @admin.activate!

    if(@admin.save)
      flash[:success] = "Usuário reativado com sucesso"
    else
      flash[:error] = "Erro ao reativar usuário"
    end
    redirect_to admins_path
  end
end
