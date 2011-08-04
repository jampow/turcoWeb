module ClientsHelper

  def address_toolbar
    html =  <<-HTML
              <div class="address-toolbar">
                <a href="#" class="copy "                              >Copiar</a>
                <a href="#" class="paste"                              >Colar</a>
                <a href="#" class="map"   target="_blank" ajax="false" >Ver no mapa</a>
              </div>
            HTML
  end
end

