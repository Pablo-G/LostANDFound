# coding: utf-8
# Controlador para agregar objetos
class LostObjectsController < ApplicationController

  # Muestra todos los objetos
  # Es temporal mientras se implementan búsquedas
  def index
    @search_page = true;
    if params[:search]
      @lost_objects = LostObject.search(params[:search]).order("name")
    else
      @lost_objects = LostObject.all.order('name')
    end


    # Esto debe ir al final del método, regresa sólo los adecuados
    # para la página de búsqueda
    limit = 15                  # Máximo número por página
    @pages = (@lost_objects.count/limit.to_f).ceil # Total de páginas
    @page = params[:page] ? params[:page].to_i : 1 # Página actual
    @min_page = [@page - 5, 1].max
    @max_page = [@page + 5, @pages].min
    @lost_objects = @lost_objects.limit(15).offset(limit*(@page-1))
  end

  def show
    @lost_object = LostObject.find(params[:id])
    @specific = @lost_object.specific
  end
  
  def new
    if current_user
      @lost_object = LostObject.new
      4.times { @lost_object.images.build}
    else
      redirect_to_login
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
        @lost_object = @lost_object.acting_as if @lost_object.actable_type
        redirect_to lost_object_path(@lost_object)
      else                     
        render :new
      end
    else
      redirect_to_login
    end
  end

  def destroy
    if !current_user
      add_message_need_login
      redirect_to_login and return
    end

    @lost_object = LostObject.find(params[:id])
    if @lost_object.authorized? current_user
      @lost_object.destroy
      add_message :success, "Objeto eliminado exitosamente"
      redirect_to lost_objects_path
    else
      render :show, status: :forbidden and return
    end
    
  end
  
  private

  # Método auxiliar que filtra los atributos permitidos en un LostObject
  def lost_objects_params
    p = params.require(:lost_object)
    general = p.permit(lost_object_whitelist)
    specific = {}
    if p[p[:actable_type]]
      specific = p.require(p[:actable_type]).permit(specific_whitelist)
    end
    puts general.merge specific
    general.merge specific
  end

  # Regresa los atributos permitidos en LostObject
  def lost_object_whitelist
    [:name, :category, :location_id, :description,
     { images_attributes: [:image] }]
  end
  
  # Regresa los atributos permitidos en el tipo específico
  def specific_whitelist
    return case params[:lost_object][:actable_type]
           when "phone"
             [:brand, :model, :company, :case, :cracked_screen]
           when "laptop"
             [:brand, :model]
           when "backpack"
             [:brand, :size]
           when "notebook"
             [:size, :type]
           when "glasses"
             [:brand, :sunglasses]
           else
             []
           end
  end

  # Crea un objeto de un tipo específico
  def create_specific
    (specific_class).new(lost_objects_params)
  end

  # Da la clase específica de un objeto
  def specific_class
    return case params[:lost_object][:actable_type]
           when "phone"
             Phone
           when "laptop"
             Laptop
           when "backpack"
             Backpack
           when "notebook"
             Notebook
           when "glasses"
             Glasses
           else
             LostObject
           end
  end

  # Método auxiliar para generar la dirección de una búsqueda
  def search_page_path(query=nil,page=nil)
    lost_objects_path(search: (query if query && !query.empty?),
                      page: page)
  end
  helper_method :search_page_path
  
end
