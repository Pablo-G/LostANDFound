Paperclip.interpolates(:missing) do |attachment, style|
  ActionController::Base.helpers.asset_path("#{style}/missing.jpg")
end
