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
    @admin = Admin.find_by_id(params[:id])

    if @admin == current_user
      redirect_to logout_path
    end

    if @admin.destroy
      flash[:success] = 'Excluido com sucesso'
    else
      flash[:error] = 'Erro ao tentar excluir'
    end
    redirect_to admins_path
  end
end
