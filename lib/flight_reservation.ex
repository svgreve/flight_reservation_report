defmodule FlightReservation do
  alias FlightReservation.Bookings.Agent, as: BookingAgent
  alias FlightReservation.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias FlightReservation.Bookings.Report, as: BookingsReport

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

  defdelegate get_all_bookings, to: BookingAgent, as: :get_all
  defdelegate get_bookings_report(from_date, to_date), to: BookingsReport, as: :create

end
