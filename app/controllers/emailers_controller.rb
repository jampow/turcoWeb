class EmailersController < ApplicationController

  def send_email
    if request.post?
      from    = params[:from]
      subject = params[:subject]
      message = params[:message]
      to      = 'gianpaulo@shark-soft.com.br'
      name    = params[:name]

      if !from.blank? and !subject.blank? and !message.blank? and !name.blank?
        Emailer.deliver_contact(from, to, subject, message, name)
        return if request.xhr?
        render :text => 'O email foi enviado com sucesso'
      else
        @form_error = 'Nao foi enviado o email'
      end
    end
  end

  def notify_error
    if request.post?
      from    = "Turco-Mail"
      subject = "[Erro] Turco-Web"
      message = params[:message]
      to      = 'gianpaulo@shark-soft.com.br'
      name    = 'Error Logger'

      if !from.blank? and !subject.blank? and !message.blank? and !name.blank?
        Emailer.deliver_contact(from, to, subject, message, name)
        return if request.xhr?
        render :text => 'O email foi enviado com sucesso'
      else
        @form_error = 'Nao foi enviado o email'
      end
    end
  end

end

