module ClientsHelper
  def btn_upload_photos(id)
    link_to "Enviar fotos", "/clients/people_photo/?id=#{id}", :class => "button", :icon => "image", :ajax => "false", :id => "send_photos"
  end
end

