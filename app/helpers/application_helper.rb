# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def controller_action_name
    controller_name + '-' + action_name
  end

  def controller_name
    params[:controller]
  end

  def action_name
    self.controller.action_name
  end



  #monta menu das telas administrativas
  def mount_menu(*btns)
    id = params[:id]
    controller = controller_name
    action = action_name

    s = ""

    if btns.length > 0
      btns[0].each do |btn|
        s += default_btn(action, controller, id)  if btn == "default"

        s += btn_separator                        if btn == "separator"
        s += btn_save                             if btn == "save"
        s += btn_show(controller, id)             if btn == "show"
        s += btn_back(controller)                 if btn == "back"
        s += btn_new(controller)                  if btn == "new"
        s += btn_edit(controller, id)             if btn == "edit"
        s += btn_delete(controller, id)           if btn == "delete"
        s += btn_editpass(controller, id)         if btn == "editpass"
        s += btn_organizer(controller)            if btn == "order"
      end
    else
      s += default_btn(action, controller, id)
    end
    s
  end

  def default_btn(action, controller, id)
    s = ""
    case action
      when "edit"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
      when "update"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
      when "new"
        s += btn_save
        s += btn_back(controller)
      when "create"
        s += btn_save
        s += btn_back(controller)
      when "show"
        s += btn_edit(controller, id)
        s += btn_delete(controller, id)
        s += btn_back(controller)
      when "index"
        s += btn_new(controller)
        s += btn_edit(controller, id)
        s += btn_show(controller, id)
        s += btn_delete(controller, id)
      when "editme"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
      when "editpass"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
    end
    s
  end

  def btn_separator
    s = "<div class=\"separator ui-state-default\">&nbsp;</div>"
  end

  def btn_new(controller)
    link_to "Novo", "/#{controller}/new", {:class => "button new", :icon => "plusthick"}
  end

  def btn_edit(controller, id)
    link_to "Editar", "/#{controller}/#{id}/edit", {:class => "button edit", :icon => "pencil"}
  end

  def btn_save
    link_to "Salvar", "#", {:class => "button save", :icon => "disk"}
  end

  def btn_show(controller, id)
    link_to "Mostrar", "/#{controller}/#{id}", {:class => "button show", :icon => "search"}
  end

  def btn_back(controller)
    link_to "Voltar", "/#{controller}", {:class => "button back", :icon => "triangle-1-w"}
  end

  def btn_delete(controller, id)
    link_to "Deletar", "/#{controller}/#{id}", {:class => "button delete", :icon => "trash"}
  end

  def btn_editpass(controller, id)
    link_to "Alterar senha", "/#{controller}/editpass/#{id}", {:class => "button editpass", :icon => "key"}
  end

  def btn_organizer(controller)
    link_to "Ordenar", "/#{controller}/order", {:class => "button order", :icon => "transferthick-e-w"}
  end


  # fields cada valor de fields deve ser um array, cada array pode ter até 3
  # valores sendo os dois primeiros obrigatórios.
  # 1 - field_name     => nome do campo na tabela
  # 2 - head_name      => nome no cabeçalho da tabela
  # 3 - hash de opções => pode definir align e format {:class => "center", :format => "number_to_currency"}
  def table(obj, *fields)
    s = <<-TABLE
          <table class="list" cellpading="0" cellspacing="0" border="0" width="100%">
            <thead>
              <tr>
                #{table_header(fields)}
              </tr>
            </thead>

            <tbody>
              #{table_body(obj, fields)}
            </tbody>
          </table>
        TABLE
  end

  def table_header(*fields)
    s = "<th>ID</th>"
    fields[0].each do |field|
      s += "<th>#{h field[1].to_s}</th>"
    end
    s
  end

  def table_body(obj, *fields)
    s = ""
    obj.each do |o|
      s += "<tr><td class=\"right\">#{o.id}</td>"
      fields[0].each do |field|
        field[2] ||= {}
        field[2][:format].nil? ? x = "o.#{field[0].to_s}" : x = "#{field[2][:format]}(o.#{field[0].to_s})"
        s += "<td class=\"#{field[2][:class]}\">#{h eval(x)}</td>"
      end
      s += "</tr>"
    end
    s
  end

  #TODO: colocar opção pra classes adicionais
  def print_content(label, content, options = {:width => 25} )
    [25, 50, 75, 100].include? options[:width] ? w = options[:width] : w = 25

    if options[:email] == true
      email = "link-to-email"
      mail_icon = "<span class=\"ui-icon ui-icon-mail-closed\"></span>"
      content = "<a href=\"mailto:#{content}\">#{content}#{mail_icon}</a>"
    else
      email = ""
    end

    s = <<-HTML
          <div class="w#{w.to_s} pcontent #{email}">
            <b>#{label.to_s}:</b>
            <span>#{content.to_s}</span>
          </div>
        HTML
    s
  end

  def address_fields(obj)
    s  = obj.text_field :cep               , :label => "CEP"         , :class => 'mask-cep'
    s += obj.text_field :street            , :label => "Endereço"
    s += obj.text_field :number            , :label => "Número"
    s += obj.text_field :complement        , :label => "Complemento"
    s += obj.text_field :neighborhood      , :label => "Bairro"
    s += obj.text_field :city              , :label => "Cidade"
    s += obj.select     :estate_id, @estate, :label => "Estado"
    s += obj.text_field :country           , :label => "País"
  end

  def address_toolbar btns = ['copy', 'paste', 'map', 'cep']
    s  = "<div class=\"address-toolbar\">"
    s +=   btn_copy  if btns.include? 'copy'
    s +=   btn_paste if btns.include? 'paste'
    s +=   btn_map   if btns.include? 'map'
    s +=   btn_cep   if btns.include? 'cep'
    s += "</div>"
  end

  def btn_copy
    flash[:btn_copy] = "true"
    html  = "<a href=\"#\" class=\"button copy\" caption=\"false\" icon=\"copy\" >Copiar</a>"
  end

  def js_copy
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
    flash[:btn_paste] = "true"
    html = "<a href=\"#\" class=\"button paste\" caption=\"false\" icon=\"clipboard\" >Colar</a>"
  end

  def js_paste
    html  = <<-JS
              $('a.paste').click(function(){
                fieldsFrom = $('.copyied').parent();
                fieldsTo   = $(this).parent().parent();

                fieldsTo.find( 'input[name$=street\]]'      ).attr('value', fieldsFrom.find( 'input[name$=street\]]'      ).attr('value'));
                fieldsTo.find( 'input[name$=number\]]'      ).attr('value', fieldsFrom.find( 'input[name$=number\]]'      ).attr('value'));
                fieldsTo.find( 'input[name$=complement\]]'  ).attr('value', fieldsFrom.find( 'input[name$=complement\]]'  ).attr('value'));
                fieldsTo.find( 'input[name$=neighborhood\]]').attr('value', fieldsFrom.find( 'input[name$=neighborhood\]]').attr('value'));
                fieldsTo.find( 'input[name$=city\]]'        ).attr('value', fieldsFrom.find( 'input[name$=city\]]'        ).attr('value'));
                fieldsTo.find('select[name$=estate_id\]]'   ).attr('value', fieldsFrom.find('select[name$=estate_id\]]'   ).attr('value'));
                fieldsTo.find( 'input[name$=country\]]'     ).attr('value', fieldsFrom.find( 'input[name$=country\]]'     ).attr('value'));
                fieldsTo.find( 'input[name$=cep\]]'         ).attr('value', fieldsFrom.find( 'input[name$=cep\]]'         ).attr('value'));
                return false;
              });
            JS
    html
  end

  def btn_map
    flash[:btn_map] = "true"
    html = "<a href=\"#\" class=\"button map\" caption=\"false\" icon=\"pin-s\" target=\"_blank\" ajax=\"false\" >Ver no mapa</a>"
  end

  def js_map
    html  = <<-JS
              $('.map').click(function(){
                context = $(this).parent().parent();
                stt = context.find( 'input[name$=street\]]'                   ).attr('value');
                nbr = context.find( 'input[name$=number\]]'                   ).attr('value');
                nbh = context.find( 'input[name$=neighborhood\]]'             ).attr('value');
                cty = context.find( 'input[name$=city\]]'                     ).attr('value');
                cep = context.find( 'input[name$=cep\]]'                      ).attr('value');
                ett = context.find('select[name$=estate_id\]] option:selected').text();

                address = escape(stt + ', ' + nbr + ' - ' + nbh + ', ' + cty + ' - ' + ett + ', ' + cep);
                t.attr('href', 'http://maps.google.com.br?q=' + address);
              });
            JS
    html
  end

  def btn_cep
    flash[:btn_cep] = "true"
    html = "<a href=\"#\" class=\"button cep\" caption=\"false\" icon=\"mail-closed\" >Consultar CEP</a>"
  end

  def js_cep
    html  = <<-JS
              $('.cep').click(function(){
                t = $(this);
                if (t.attr('click') == 'true') {
                  return false;
                } else {
                  t.attr('click', 'true');
                }
                context = t.parent().parent();
                cep     = context.find('input[name$=cep\]]').attr('value');

                if (cep == "" || cep.length < 9)
                {
                  alert('CEP inválido');
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
                        context.find( 'input[name$=street\]]'      ).attr('value', result.logradouro);
                        context.find( 'input[name$=neighborhood\]]').attr('value', result.bairro);
                        context.find( 'input[name$=city\]]'        ).attr('value', result.cidade);
                        context.find('select[name$=estate_id\]]'   ).attr('value', result.estate_id);
                        context.find( 'input[name$=country\]]'     ).attr('value', 'Brasil');
                        context.find( 'input[name$=number\]]'      ).focus();
                      } else {
                        alert(result.resultado_txt);
                      }
                    }
                  });
                }
              });
            JS
    html
  end

end

