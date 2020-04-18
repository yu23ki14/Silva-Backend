class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private
  # :company( 企業名 )を追加できるようにpravateメソッドに修正を加える
  def sign_up_params
    params.require(:registration).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:registration).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end
end
