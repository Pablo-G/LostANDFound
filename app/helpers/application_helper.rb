module ApplicationHelper

  # Agrega una etiqueta que se puede desactivar con un checkbox.
  # id debe corresponder a la etiqueta que se quiere desactivar
  def toggleable_tag(id,tag)
    content_tag :div, class: "checkbox" do
      (check_box_tag nil, "", false,
                    {"class" => ["checkbox-using", "toggleable"],
                     "data-target" => id}) +
      tag
    end
  end
  
end
