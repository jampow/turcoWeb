module ClientsHelper

  def address_toolbar btns = ['copy', 'paste', 'map', 'cep']
    s  = "<div class=\"address-toolbar\">"
    s +=   btn_copy  if btns.include? 'copy'
    s +=   btn_paste if btns.include? 'paste'
    s +=   btn_map   if btns.include? 'map'
    s +=   btn_cep   if btns.include? 'cep'
    s += "</div>"
  end

  def btn_copy
    html = "<a href=\"#\" class=\"button copy\" caption=\"false\" icon=\"copy\" >Copiar</a>"
  end

  def btn_paste
    html = "<a href=\"#\" class=\"button paste\" caption=\"false\" icon=\"clipboard\" >Colar</a>"
  end

  def btn_map
    html = "<a href=\"#\" class=\"button map\" caption=\"false\" icon=\"pin-s\" target=\"_blank\" ajax=\"false\" >Ver no mapa</a>"
  end

  def btn_cep
    html = "<a href=\"#\" class=\"button cep\" caption=\"false\" icon=\"mail-closed\" >Consultar CEP</a>"
  end
end

