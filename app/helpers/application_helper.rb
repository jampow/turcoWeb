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

  def editing?
    action_name == 'edit'
  end

  #monta menu das telas administrativas
  def mount_menu(*btns)
    id = params[:id]
    controller = controller_name
    action = action_name

    s = ""

    if btns.length > 0
      btns[0].each do |btn|
        s += case btn
               when "default"       : default_btn        action, controller, id
               when "separator"     : btn_separator
               when "save"          : btn_save
               when "show"          : btn_show                   controller, id
               when "back"          : btn_back                   controller
               when "new"           : btn_new                    controller
               when "edit"          : btn_edit                   controller, id
               when "delete"        : btn_delete                 controller, id
               when "editpass"      : btn_editpass               controller, id
               when "organizer"     : btn_organizer              controller
               when "upload"        : btn_upload                 controller, id
               when "credit_account": btn_credit_account                     id
               when "transactions"  : btn_transactions                       id
               when "measureunits"  : btn_measure_units                      id
               when "stocks"        : btn_stocks                             id
             end
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
      when "filter_index"
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
    url = id ? "/#{controller}/#{id}/edit" : "#"
    link_to "Editar", url, {:class => "button edit", :icon => "pencil"}
  end

  def btn_save
    link_to "Salvar", "#", {:class => "button save", :icon => "disk"}
  end

  def btn_show(controller, id)
    url = id ? "/#{controller}/#{id}" : "#"
    link_to "Mostrar", url, {:class => "button show", :icon => "search"}
  end

  def btn_back(controller)
    link_to "Voltar", "/#{controller}", {:class => "button back", :icon => "triangle-1-w"}
  end

  def btn_delete(controller, id)
    url = id ? "/#{controller}/#{id}" : "#"
    link_to "Deletar", url, {:class => "button delete", :icon => "trash"}
  end

  def btn_editpass(controller, id)
    url = id ? "/#{controller}/editpass/#{id}" : "#"
    link_to "Alterar senha", url, {:class => "button editpass", :icon => "key"}
  end

  def btn_organizer(controller)
    link_to "Ordenar", "/#{controller}/order", {:class => "button order", :icon => "transferthick-e-w"}
  end

  def btn_upload(controller, id)
    url = id ? "/attachments?model=#{controller}&id=#{id}" : "#"
    link_to "Enviar arquivo", url, {:class => "button upload", :icon => "arrowthick-1-n", :ajax => false}
  end

  # fields cada valor de fields deve ser um array, cada array pode ter até 3
  # valores sendo os dois primeiros obrigatórios.
  # 1 - field_name     => nome do campo na tabela
  # 2 - head_name      => nome no cabeçalho da tabela
  # 3 - hash de opções => pode definir align e format {:class => "center", :format => "number_to_currency"}
  def table(obj, *fields)
      s = <<-TABLE
            <table class="#{table_class(obj)}" cellpading="0" cellspacing="0" border="0" width="100%">
              <thead>
                <tr>
                  #{table_header(has_id?(obj), fields)}
                </tr>
              </thead>

              <tbody>
                #{table_body(obj, fields) if !obj.blank?}
              </tbody>
            </table>
          TABLE
    s
  end

  def has_id?(obj)
    if !obj.blank?
      r = obj[0].id ? true : false
    else
      r = false
    end
    r
  end

  def table_class(obj)
    # logger.info 'obj[0].nil? = ' + obj[0].nil?.to_s
    # logger.info '!obj[0].id = '  + (!obj[0].id).to_s
    obj[0].nil? || !obj[0].id ? 'simple-list' : 'list'
  end

  def table_header(id, *fields)
    s = id ? "<th class=\"hide\">ID</th>" : ""
    fields[0].each do |field|
      field[2] ||= {}
      s += "<th class=\"#{"hide" if field[2][:hide]}\">#{h field[1].to_s}</th>"
    end
    s
  end

  def table_body(obj, *fields)
    s = ""
    obj.each do |o|
      s += "<tr>"
      s += "<td class=\"hide right\">#{o.id}</td>" if o.id
      fields[0].each do |field|
        field[2] ||= {}
        field[2][:format].nil? ? x = "o.#{field[0].to_s}" : x = "#{field[2][:format]}(o.#{field[0].to_s})"
        s += "<td class=\"#{field[2][:class]} #{"hide" if field[2][:hide]}\">#{h eval(x)}</td>"
      end
      s += "</tr>"
    end
    s
  end

  #TODO: colocar opção pra classes adicionais
  def print_content(label, content, options = {:width => 25} )
    [10, 20, 25, 30, 40, 50, 60, 70, 75, 80, 90, 100].include? options[:width] ? w = options[:width] : w = 25

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

  def new_fields(f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_record") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    fields
  end

  def human_boolean(bool)
    bool ? "Sim" : "Não"
  end

  def date(date)
    if !date.nil?
      if date.class == Date
        l(date)
      elsif date.class == ActiveSupport::TimeWithZone
        l(date, :format => :date)
      elsif date.class == String && date.match(/[12][0-9]{3}-[01][0-9]-[0-3][0-9]/)
        date(Date.parse(date))
      else
        date
      end
    else
      ""
    end
  end

  def filter_display(starts, ends)
    s = " - "
    if ends.empty?
      s += "a partir de #{starts}"
    else
      if !starts.empty?
        s += "de #{starts} "
      end
      s += "até #{ends}"
    end
  end

end

