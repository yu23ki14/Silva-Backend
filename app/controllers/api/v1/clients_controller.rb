class Api::V1::ClientsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_client_and_users, only: [:update, :show]
  before_action :authenticate_user, only: [:update, :show]

  def show
    @statuses = @client.statuses.order(updated_at: :desc)
    @actions = @client.actions.order(updated_at: :desc)
    @team = @client.user_clients.map{|user_client| {role: user_client.role, user: user_client.user, action: @actions.where(user_id: user_client.user_id).where(role: user_client.role).limit(1)}}
    render json: {client: @client, statuses: @statuses, actions: @actions, team: @team}, status: 200
  end

  def create
    @client = Client.new(client_params)
    illnesses = params[:underlying_illnesses]
    if @client.save
      illnesses.each do |illness|
        @client_illness = ClientIllness.new(client_id: @client.id, underlying_illness_id: illness)
        @client_illness.save
      end
      @user_client = UserClient.new(user_id: current_api_v1_user.id, client_id: @client.id)
      if @user_client.save
        render json: @client.as_json(include: [:statuses]), status: 200
      else
        render json: @client.errors, status: 500
      end
    else
      render json: @client.errors, status: 500
    end
  end

  def update
    illnesses = params[:underlying_illnesses]
    current_illnesses_data = @client.underlying_illnesses.map{|illness| illness.id}
    grade_updated = params[:grade] != @client.grade
    if @client.update(client_params)
      if illnesses != current_illnesses_data
        @client.underlying_illnesses.destroy_all
        illnesses.each do |illness|
          @client_illness = ClientIllness.new(client_id: @client.id, underlying_illness_id: illness)
          @client_illness.save
        end
      end
      NotificationMailer.with(users: @users, client: @client, type: 'grade').alert_notification.deliver_later
      render json: @client, status: 200
    else
      render json: @client.errors, status: 500
    end
  end

  private
  def set_client_and_users
    @client = Client.find(params[:id])
    @users = @client.users
  end

  def authenticate_user
    render json: {status: 401, message: '権限がありません。'}, status: 401 unless @users.map{|user| user.id}.include?(current_api_v1_user.id)
  end

  def client_params
    params.permit(:initial, :gender, :age, :address, :grade)
  end
end
