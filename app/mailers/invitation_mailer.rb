class InvitationMailer < ApplicationMailer
  default from: "#{ENV['MAILUSERNAME']}"

  def silva_invitation(email, from_user, url)
    @url = url
    @from_user = from_user
    mail(to: email, subject: "#{@from_user.name}さんからSilvaへの招待が来ました。") do |format|
      format.html
    end
  end
end
