class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    super do |resource|
      invitation = Invitation.find_by(uid: params[:invitation_uid])
      if invitation.present?
        user_client = UserClient.create(user_id: resource.id, client_id: invitation.client_id, role: invitation.role)
        invitation.destroy!
      end
    end
  end

  private
  # :company( 企業名 )を追加できるようにpravateメソッドに修正を加える
  def sign_up_params
    params.require(:registration).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:registration).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end
end
