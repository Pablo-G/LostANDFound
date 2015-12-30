module ApplicationHelper

  # Agrega una etiqueta que se puede desactivar con un checkbox.
  # id debe corresponder a la etiqueta que se quiere desactivar
  def toggleable_tag(id,tag,name=nil)
    content_tag :div, class: "checkbox" do
      (check_box_tag name, "1", false,
                    {"class" => ["checkbox-using", "toggleable"],
                     "data-target" => id}) +
      tag
    end
  end
  
end
