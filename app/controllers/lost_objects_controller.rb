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
    params.require(:lost_object).permit(:name, :category,
                                        :location_id, :description,
                                        images_attributes: [:image])
  end

  # Método auxiliar para generar la dirección de una búsqueda
  def search_page_path(query=nil,page=nil)
    lost_objects_path(search: (query if query && !query.empty?),
                      page: page)
  end
  helper_method :search_page_path
  
end
