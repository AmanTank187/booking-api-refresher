class Api::V1::EventsController < ApplicationController
  before_action :current_user, only: [ :create, :book ]
  def show
    event = Event.find(params["id"])
    render json: event.as_json(methods: [ :available_seats, :booked_users ])
  end

  def create
    event = Event.new(event_params)
    event.creator = @current_user
    if event.save
      head :no_content
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def book
    event = Event.find(params["event_id"])
    booking = event.bookings.new(user: @current_user)
    if booking.save
      head :no_content
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:id, :title, :starts_at, :ends_at, :capacity)
  end

  def current_user
    params.permit(:current_user_id)
    @current_user = User.find(params["current_user_id"])
  end
end
