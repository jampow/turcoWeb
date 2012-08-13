module AddressHelper


  def address_container(title, obj)
    s  = "<h2>#{title}</h2>"
    #if action_name == 'show'
      s += "<div class=\"toggleable\">"
      s +=    address_toolbar 'map'

      s +=    print_content "CEP"        , h(obj.cep)
      s +=    print_content "Endereço"   , h(obj.street)
      s +=    print_content "Número"     , h(obj.number)
      s +=    print_content "Complemento", h(obj.complement)
      s +=    print_content "Bairro"     , h(obj.neighborhood)
      s +=    print_content "Cidade"     , h(obj.city)
      s +=    print_content "País"       , h(obj.country)
      s +=    print_content "Estado"     , h((obj.estate.name if obj.estate_id))
      s += "  <div class=\"clear\"></div>"
      s += "</div>"
    #else
    #  s += address_toolbar
    #
    #  s += obj.text_field :cep               , :label => "CEP"         , :class => 'mask-cep'
    #  s += obj.text_field :street            , :label => "Endereço"
    #  s += obj.text_field :number            , :label => "Número"
    #  s += obj.text_field :complement        , :label => "Complemento"
    #  s += obj.text_field :neighborhood      , :label => "Bairro"
    #  s += obj.text_field :city              , :label => "Cidade"
    #  s += obj.select     :estate_id, @estate, :label => "Estado"
    #  s += obj.text_field :country           , :label => "País"
    #end
    return s
  end

  def address_toolbar btns = ['copy', 'paste', 'map', 'cep']
    s  = "<div class=\"form-toolbar\">"
    s +=   btn_copy  if btns.include? 'copy'
    s +=   btn_paste if btns.include? 'paste'
    s +=   btn_map   if btns.include? 'map'
    s +=   btn_cep   if btns.include? 'cep'
    s += "</div>"
  end

  def btn_copy
    flash[:btn_copy] = true
    html  = "<a href=\"#\" class=\"button copy\" caption=\"false\" icon=\"copy\" >Copiar</a>"
  end

  def js_copy
    flash[:btn_copy] = false
    html  = <<-JS
              $('a.copy').click(function(){
                $('.copyied').removeClass('copyied');
                $(this).parent().addClass('copyied');
                return false;
              });
            JS
    html
  end

  def btn_paste
    flash[:btn_paste] = true
    html = "<a href=\"#\" class=\"button paste\" caption=\"false\" icon=\"clipboard\" >Colar</a>"
  end

  def js_paste
    flash[:btn_paste] = false
    html  = <<-JS
              $('a.paste').click(function(){
                fieldsFrom = $('.copyied').parent();
                fieldsTo   = $(this).parent().parent();

                fieldsTo.find( 'input[name$=street\\]]'      ).attr('value', fieldsFrom.find( 'input[name$=street\\]]'      ).attr('value'));
                fieldsTo.find( 'input[name$=number\\]]'      ).attr('value', fieldsFrom.find( 'input[name$=number\\]]'      ).attr('value'));
                fieldsTo.find( 'input[name$=complement\\]]'  ).attr('value', fieldsFrom.find( 'input[name$=complement\\]]'  ).attr('value'));
                fieldsTo.find( 'input[name$=neighborhood\\]]').attr('value', fieldsFrom.find( 'input[name$=neighborhood\\]]').attr('value'));
                fieldsTo.find( 'input[name$=city\\]]'        ).attr('value', fieldsFrom.find( 'input[name$=city\\]]'        ).attr('value'));
                fieldsTo.find('select[name$=estate_id\\]]'   ).attr('value', fieldsFrom.find('select[name$=estate_id\\]]'   ).attr('value'));
                fieldsTo.find( 'input[name$=country\\]]'     ).attr('value', fieldsFrom.find( 'input[name$=country\\]]'     ).attr('value'));
                fieldsTo.find( 'input[name$=cep\\]]'         ).attr('value', fieldsFrom.find( 'input[name$=cep\\]]'         ).attr('value'));
                return false;
              });
            JS
    html
  end

  def btn_map
    if action_name == 'new' || action_name == 'edit'
      flash[:btn_map_form] = true
      flash[:btn_map_show] = false
    end
    if action_name == 'show'
      flash[:btn_map_form] = false
      flash[:btn_map_show] = true
    end
    html = "<a href=\"#\" class=\"button map\" caption=\"false\" icon=\"pin-s\" target=\"_blank\" ajax=\"false\" >Ver no mapa</a>"
  end

  def js_map_form
    flash[:btn_map_form] = false
    html  = <<-JS
              $('.map').click(function(){
                t = $(this);
                context = t.parent().parent();
                stt = context.find( 'input[name$=street\\]]'                   ).attr('value');
                nbr = context.find( 'input[name$=number\\]]'                   ).attr('value');
                cty = context.find( 'input[name$=city\\]]'                     ).attr('value');
                cep = context.find( 'input[name$=cep\\]]'                      ).attr('value');

                address = escape(stt + ', ' + nbr + ', ' + cty + ', ' + cep);
                t.attr('href', 'http://maps.google.com.br?q=' + address);
              });
            JS
    html
  end

  def js_map_show
    flash[:btn_map_show] = false
    html =  <<-JS
              $('.map').click(function(){
                context = $(this).parent().parent();
                fields = $('div.pcontent', context);

                values = [];
                fields.each(function(){
                  values.push($(this).children('span').text());
                });

                cep = values[0];
                stt = values[1];
                nbr = values[2];
                // nbh = values[4];
                cty = values[5];
                // ett = values[6];

                address = escape(stt + ', ' + nbr + ', ' + cty + ', ' + cep);
                $(this).attr('href', 'http://maps.google.com.br?q=' + address);
              });
            JS
  end

  def btn_cep
    flash[:btn_cep] = true
    html = "<a href=\"#\" class=\"button cep\" caption=\"false\" icon=\"mail-closed\" >Consultar CEP</a>"
  end

  def js_cep
    flash[:btn_cep] = false
    html  = <<-JS
              $('.cep').click(function(){
                t = $(this);
                if (t.attr('click') == 'true') {
                  return false;
                } else {
                  t.attr('click', 'true');
                }
                context = t.parent().parent();
                cep     = context.find('input[name$=cep\\]]').attr('value');

                if (cep == "" || cep.length < 9)
                {
                  alert('CEP inválido', 'Inválido');
                }
                else
                {
                  $.ajax({
                    url: '/cep/findCep',
                    data: 'cep=' + cep,
                    type: 'GET',
                    dataType: 'json',
                    success: function(data){
                      result = eval(data);
                      if (result.resultado == 1) {
                        context.find( 'input[name$=street\\]]'      ).attr('value', result.logradouro);
                        context.find( 'input[name$=neighborhood\\]]').attr('value', result.bairro);
                        context.find( 'input[name$=city\\]]'        ).attr('value', result.cidade);
                        context.find( 'input[name$=city_id\\]]'     ).attr('value', result.city_id);
                        context.find('select[name$=estate_id\\]]'   ).attr('value', result.estate_id);
                        context.find( 'input[name$=country\\]]'     ).attr('value', 'Brasil');
                        context.find( 'input[name$=number\\]]'      ).focus();
                      } else {
                        alert(result.resultado_txt, "Mensagem");
                      }
                    }
                  });
                }
              });
            JS
    html
  end

end

