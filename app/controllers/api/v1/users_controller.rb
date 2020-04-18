class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_client, only: [:create, :update, :set_my_role]
  before_action :authenticate_user, only: [:update, :create]

  def create
    user = User.find_by(email: params[:email])
    @user_client = UserClient.new({user_id: user.id, client_id: params[:client_id], role: params[:role]})
    if @user_client.save
      render json: {user: user, role: user_client_params[:role]}, status: 200
    else
      render json: {status: 500}, status:500
    end
  end

  def update
  end

  def set_my_role
    @user = current_api_v1_user
    @user_client = @client.user_clients.find_by(user_id: current_api_v1_user.id)
    if @user_client.update(user_client_params)
      render json: {user: @user, role: user_client_params[:role]}, status: 200
    end
  end

  def validate_email
    user = User.find_by(email: params[:email])
    if user.present?
      render json: {user: user, result: true}, status: 200
    else
      render json: {result: false}, status: 200
    end
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def authenticate_user
    render json: {status: 401, message: '権限がありません。'}, status: 401 unless @client.users.map{|user| user.id}.include?(current_api_v1_user.id)
  end

  def user_client_params
    params.permit(:role, :client_id)
  end
end
