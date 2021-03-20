defmodule FlightReservation do
  alias FlightReservation.Bookings.Agent, as: BookingAgent
  alias FlightReservation.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking

  alias FlightReservation.Users.Agent, as: UserAgent
  alias FlightReservation.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(user_params), to: CreateOrUpdateUser, as: :call
  defdelegate create_booking(user_id, booking_params), to: CreateOrUpdateBooking, as: :call

  defdelegate get_user(id), to: UserAgent, as: :get
  defdelegate get_booking(id), to: BookingAgent, as: :get

end
