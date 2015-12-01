# Controlador para agregar objetos
class LostObjectsController < ApplicationController
  
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
  
  private

  # Método auxiliar que filtra los atributos permitidos en un LostObject
  def lost_objects_params
    params.require(:lost_object).permit(:name, :category, :location, :description)
  end
  
end