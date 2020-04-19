class Api::V1::ActionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_action, only: [:update]
  before_action :set_client
  before_action :authenticate_user, only: [:update, :create]

  def create
    @action = Action.new(action_params)
    if @action.save
      NotificationMailer.update_action_notification(@users, @client, @action).deliver_now
      render json: @action, status: 200
    else
      render json: @action.errors, status: 500
    end
  end

  def update
    if @action.update(action_update_params)
      render json: @action, status: 200
    else
      render json: @action.errors, status: 500
    end
  end

  private

  def set_action
    @action = Action.find(params[:id])
  end

  def set_client
    if @action.present?
      @client = @action.client
    elsif params[:client_id].present?
      @client = Client.find(params[:client_id])
    else
      render json: {status: 500, message: '予期せぬエラーが発生しました。'}, status: 500
    end
  end

  def authenticate_user
    @users = @client.users
    render json: {status: 401, message: '権限がありません。'}, status: 401 unless @users.map{|user| user.id}.include?(current_api_v1_user.id)
  end

  def action_params
    params.permit(:text, :client_id, :user_id, :role)
  end

  def action_update_params
    params.permit(:text)
  end
end
