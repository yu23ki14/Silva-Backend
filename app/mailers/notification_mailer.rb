class NotificationMailer < ApplicationMailer
  default from: "#{ENV['MAILUSERNAME']}"

  def update_grade_notification(users, client)
    email_address = users.map{|user| [user.email]}
    @client = client
    subject = "Silva:患者さんのクラスが#{client.grade}に更新されました。"
    mail(bcc: email_address, subject: subject) do |format|
      format.html
    end
  end

  def update_status_notification(users, client)
    email_address = users.map{|user| [user.email]}
    @client = client
    subject = "Silva:患者さんのステータスが更新されました。"
    mail(bcc: email_address, subject: subject) do |format|
      format.html
    end
  end
  
  def update_action_notification(users, client, action)
    email_address = users.map{|user| [user.email]}
    @client = client
    @action = action
    subject = "Silva:チームの#{action.role}のアクションが更新されました。"
    mail(bcc: email_address, subject: subject) do |format|
      format.html
    end
  end

end
