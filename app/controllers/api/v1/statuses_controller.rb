class Api::V1::StatusesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_status, only: [:update]
  before_action :set_client
  before_action :authenticate_user, only: [:update, :create]

  def create
    @status = Status.new(status_params)
    if @status.save
      NotificationMailer.update_status_notification(@users, @client).deliver_now
      render json: @status, status: 200
    else
      render json: @status.errors, status: 500
    end
  end

  def update
    if @status.update_attributes(status_update_params)
      render json: @status, status: 200
    else
      render json: @status.errors, status: 500
    end
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def set_client
    if @status.present?
      @client = @status.client
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

  def status_params
    params.permit(:text, :client_id).merge(user_id: current_api_v1_user.id)
  end

  def status_update_params
    params.permit(:text)
  end
end
