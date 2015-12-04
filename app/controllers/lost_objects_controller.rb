# coding: utf-8
# Controlador para agregar objetos
class LostObjectsController < ApplicationController

  # Muestra todos los objetos
  # Es temporal mientras se implementan búsquedas
  def index
    @lost_objects = LostObject.all
  end

  def show
    @lost_object = LostObject.find(params[:id])
  end
  
  def new
    @lost_object = LostObject.new
  end
  
  #Crea un nuevo objeto
  def create
    @lost_object = LostObject.new(lost_objects_params)

    if @lost_object.save            
      
      redirect_to session_index_path
    else                     
      render :new            
    end
  end

  def destroy
    @lost_object = LostObject.find(params[:id])
    @lost_object.destroy

    redirect_to lost_objects_path
  end
  
  private

  # Método auxiliar que filtra los atributos permitidos en un LostObject
  def lost_objects_params
    params.require(:lost_object).permit(:name, :category,
                                        :location_id, :description,
                                        :image)
  end
  
end
