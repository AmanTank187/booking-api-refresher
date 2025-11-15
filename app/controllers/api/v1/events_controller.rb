class Api::V1::EventsController < ApplicationController
  def show
    event = Event.find(params["id"])
    render json: event.as_json(methods: [ :available_seats, :booked_users ])
  end

  private

  def event_params
    params.expect(:id)
  end
end
