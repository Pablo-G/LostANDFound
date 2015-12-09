# coding: utf-8
# Controlador para agregar objetos
class LostObjectsController < ApplicationController

  # Muestra todos los objetos
  # Es temporal mientras se implementan búsquedas
  def index
    @lost_objects = LostObject.all
    if params[:search]
      @lost_objects = LostObject.search(params[:search]).order("name")
    else
      @lost_objects = LostObject.all.order('name')
    end
  end

  def show
    @lost_object = LostObject.find(params[:id])
  end
  
  def new
    if current_user
      @lost_object = LostObject.new
    else
      redirect_to sign_in_path
    end
  end
  
  #Crea un nuevo objeto
  def create
    if current_user
      @lost_object = LostObject.new(lost_objects_params)
      @lost_object.user = current_user
      @lost_object.state = false # No se ha devuelto
      @lost_object.date_added = DateTime.now

      if @lost_object.save            
        redirect_to lost_object_path(@lost_object)
      else                     
        render :new
      end
    else
      redirect_to sign_in_path
    end
  end

  def destroy
    if !current_user
      redirect_to sign_in_path and return
    end

    @lost_object = LostObject.find(params[:id])
    if @lost_object.authorized? current_user
      @lost_object.destroy
      redirect_to lost_objects_path
    else
      render :show, status: :forbidden and return
    end
    
  end
  
  private

  # Método auxiliar que filtra los atributos permitidos en un LostObject
  def lost_objects_params
    params.require(:lost_object).permit(:name, :category,
                                        :location_id, :description,
                                        :image)
  end
  
end
