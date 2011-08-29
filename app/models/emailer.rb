class Emailer < ActionMailer::Base

  ActionMailer::Base.delivery_method = :sendmail
  ActionMailer::Base.sendmail_settings = {
    :location  => '/usr/sbin/sendmail',
    :arguments => '-i -t -f notificacao@shark-soft.com.br'
  }

  def contact(from, to, subject, message, name, sent_at = Time.now)
    @subject    = subject   # Titulo do email
    @recipients = to        # Destino do email
    @from       = from      # origem do email
    @reply_to   = from      # Responder email para '(Novidade do rails 2.1)'
    @sent_on    = sent_at   # Data do email

  # Dados para a view

    @body["title"]   = subject
    @body["email"]   = from
    @body["message"] = message
    @headers         = {}
  end

end

