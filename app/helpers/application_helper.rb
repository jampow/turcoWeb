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
    link_to "Novo", "/#{controller}/new", {:class => "button new"}
  end

  def btn_edit(controller, id)
    link_to "Editar", "/#{controller}/#{id}/edit", {:class => "button edit"}
  end

  def btn_save
    link_to "Salvar", "#", {:class => "button save"}
  end

  def btn_show(controller, id)
    link_to "Mostrar", "/#{controller}/#{id}", {:class => "button show"}
  end

  def btn_back(controller)
    link_to "Voltar", "/#{controller}", {:class => "button back"}
  end

  def btn_delete(controller, id)
    link_to "Deletar", "/#{controller}/#{id}", {:class => "button delete"}
  end

  def btn_editpass(controller, id)
    link_to "Alterar senha", "/#{controller}/editpass/#{id}", {:class => "button editpass"}
  end

  def btn_organizer(controller)
    link_to "Ordenar", "/#{controller}/order", {:class => "button order"}
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


  def print_content(label, content, width = 25)
    [25, 50, 75, 100].include? width ? w = width : w = 25
    s = <<-HTML
          <div class="w#{w.to_s} pcontent">
            <b>#{label.to_s}:</b>
            #{content.to_s}
          </div>
        HTML
    s
  end

end

