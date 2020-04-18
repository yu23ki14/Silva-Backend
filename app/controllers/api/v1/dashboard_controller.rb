class Api::V1::DashboardController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_user

  def index
    @clients = @user.clients.distinct(:user_id).includes(:statuses)
    render json: {user: @user, clients: @clients.index_by(&:id).as_json(include: [:statuses])}, status: 200
  end

  private
  def set_user
    @user = current_api_v1_user
  end
  
end