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
end

