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

    s += ""
  end

  def default_btn(action, controller, id)
    s = ""
    case action
      when "edit"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
      when "new"
        s += btn_save
        s += btn_back(controller)
      when "show"
        s += btn_edit(controller, id)
        s += btn_delete(controller, id)
        s += btn_back(controller)
      when "index"
        s += btn_edit(controller, id)
        s += btn_show(controller, id)
        s += btn_delete(controller, id)
        s += btn_new(controller)
      when "editme"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
      when "editpass"
        s += btn_save
        s += btn_show(controller, id)
        s += btn_back(controller)
    end
    s += ""
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


end

