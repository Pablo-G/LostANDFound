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
    if current_user
      @lost_object = LostObject.new
    else
      redirect_to sign_in_path
    end
  end
  
  #Crea un nuevo objeto
  def create
    if current_user
      @lost_object = create_specific
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

  def lost_objects_whitelist
    [:name, :category, :location_id, :description, :image]
  end
  
  def specific_whitelist
    return case params[:lost_object][:actable_type]
           when "phone"
             [:brand, :model, :company, :case, :cracked_screen]
           when "backpack"
             []# [:size]
           when "notebook"
             []# [:size, :kind]
           when "glasses"
             []# [:kind, :brand]
           when "laptop"
             [:brand, :model]# [:brand, :model, :size, :keyboard_layout]
           else
             []
           end
  end
  
  # Método auxiliar que filtra los atributos permitidos en un LostObject
  def lost_objects_params
    params.require(:lost_object).permit(lost_objects_whitelist +
                                        specific_whitelist)
  end

  # Crea un lost_object del tipo especifico que indique params
  def create_specific
    return case params[:lost_object][:actable_type]
           when "phone"
             Phone.new(lost_objects_params)
           when "backpack"
             Backpack.new(lost_objects_params)
           when "notebook"
             Notebook.new(lost_objects_params)
           when "glasses"
             Glasses.new(lost_objects_params)
           when "laptop"
             Laptop.new(lost_objects_params)
           else
             LostObject.new(lost_objects_params)
           end
  end
  
end
