class Api::V1::InvitationsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
    if params[:user_present]
      invitation = Invitation.where(client_id: invite_team_params[:client_id]).where(user_id: invite_team_params[:user_id]).where(role: invite_team_params[:role])
      if !invitation.present?
        @invitation = Invitation.new(invite_team_params)
        user = User.find(invite_team_params[:user_id])
        if @invitation.save
          render json: {user: user.as_json.merge(inviting: true), role: invite_team_params[:role]}, status: 200
        else
          render json: @invitation.errors
        end
      else
        render status: 400, json: { status: 400, message: 'Bad Request' }
      end
    else
      uid = SecureRandom.urlsafe_base64
      @invitation = Invitation.new(invite_silva_params.merge(uid: uid))
      user = User.find(1)
      if @invitation.save
        InvitationMailer.silva_invitation(invite_silva_params[:email], current_api_v1_user, "#{ENV['APP_URL']}/auth/sign_up?invitation_uid=#{uid}").deliver
        render json: {user: user.as_json.merge(inviting: true), role: invite_silva_params[:role]}, status: 200
      else
        render json: @invitation.errors
      end
    end
  end

  def answer
    invite_answer_params.each do |key, value|
      invitation = Invitation.find(key)
      if invitation.user_id == current_api_v1_user.id
        if value
          @user_client = UserClient.new(user_id: current_api_v1_user.id, client_id: invitation.client_id, role: invitation.role)
          @user_client.save!
          invitation.destroy!
        else
          invitation.destroy!
        end
      end
    end
  end

  private
  def invite_team_params
    params.permit(:role, :client_id, :user_id).merge(from_user_id: current_api_v1_user.id, uid: SecureRandom.urlsafe_base64)
  end

  def invite_silva_params
    params.permit(:role, :client_id, :email).merge(user_id: 1, from_user_id: current_api_v1_user.id)
  end

  def invite_answer_params
    params.require(:answer)
  end
end
