# coding: utf-8
# Controlador para agregar objetos
class LostObjectsController < ApplicationController

  # Muestra todos los objetos
  # Es temporal mientras se implementan búsquedas
  def index
    params[:search] = nil unless params[:search] &&
                                 !params[:search].blank?
    params[:location_id] = nil unless params[:location_id] &&
                                      params[:location_id].to_i != 0
    
    @search_page = true
    @lost_objects = LostObject.all # Selecciona todos los objetos
    @search_options = params.permit(:page, :search, :actable_type,
                                    { params[:actable_type] => (specific_whitelist params) })
                                    
    # Si hay una búsqueda, limita según los parámetros
    if params[:search]
      @lost_objects = @lost_objects.search(params[:search])
    end
    
    # Si hay una sesión, oculta los objetos enviados por el usuario
    if current_user
      @lost_objects = @lost_objects.where.not(user_id: current_user.id)
    end
    
    # Si se seleccionó el lugar, busca los lugares relacionados
    if params[:location_id] && Location.exists?(id: params[:location_id])
      location = Location.find(params[:location_id])
      @lost_objects = @lost_objects.where(location: location.related)
    end

    # Filtra según el tipo
    if params[:actable_type]
      @lost_objects = specific_objects
    end

    @lost_objects = @lost_objects.includes(:images)
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
    @ticket = Ticket.new
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
      specific = p.require(p[:actable_type]).permit(specific_whitelist p)
    end
    general.merge specific
  end

  # Regresa los atributos permitidos en LostObject
  def lost_object_whitelist
    [:name, :category, :location_id, :description,
     { images_attributes: [:image] }]
  end
  
  # Regresa los atributos permitidos en el tipo específico
  def specific_whitelist(hash)
    return case hash[:actable_type]
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
    (specific_class params[:lost_object]).new(lost_objects_params)
  end

  # Da la clase específica de un objeto
  def specific_class(hash)
    return case hash[:actable_type]
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

  # Regresa los objetos específicos a partir de una coleccion
  def specific_objects
    type = specific_class params
    return @lost_objects.where("actable_type IS NULL") if type == LostObject
    objs = @lost_objects.where(actable_type: type)
    objs = type.where(id: objs.pluck(:actable_id))

    # Si hay más parámetros
    if params[params[:actable_type]]
      p = params.require(params[:actable_type]).permit(specific_whitelist params)
      valid_string_columns = ["brand", "model", "company", "size", "type"]
      valid_string_columns.each do |c|
        if p[c]
          p[c].split.each do |w|
            objs = objs.where("lower(#{c}) LIKE lower(?)", "%#{w}%")
          end
        end
      end

      valid_bool_columns = ["case", "cracked_screen", "sunglasses"]
      valid_bool_columns.each do |c|
        if params[params[:actable_type]]["has_#{c}"]
          bool = (p[c] && p[c]=="1") ? true : false
          objs = objs.where(c => bool)
        end
      end
    end
    
    LostObject.where(actable_type: type,
                     actable_id: objs.pluck(:id))
  end

  # Método auxiliar para generar la dirección de una búsqueda
  # Recibe hasta dos hash de opciones, con los valores del segundo
  # tomando prioridad sobre el primero
  def search_page_path(options1={}, options2={})
    ops = options1.merge options2
    lost_objects_path ops
  end
  helper_method :search_page_path
  
end
