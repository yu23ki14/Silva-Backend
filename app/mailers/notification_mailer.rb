class NotificationMailer < ApplicationMailer
  default from: 'silvalocalmailer@gmail.com'

  def alert_notification(users, client, type)
    @email_address = users.map(|user| [user.email])
    @client = client
    if type == 'grade'
      subject = "患者さんの優先度が#{client.grade}に更新されました。"
    end
    
    mail(to: @email_address, subject: subject)
  end
end
