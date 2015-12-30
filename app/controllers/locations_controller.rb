# coding: utf-8
class LocationsController < ApplicationController
  # Regresa un JSON con los lugares que descienden
  # directamente de uno con el id dado
  def index
    if(params[:id])
      @locations = Location.find(params[:id]).childs
    else
      @locations = Location.roots
    end

    respond_to do |format|
      format.json { render json: @locations.to_json(:only => [:id, :name]) }
    end
  end

end
