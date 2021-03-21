defmodule FlightReservation.Bookings.ReportTest do
  use ExUnit.Case

  alias FlightReservation.Bookings.Agent, as: BookingsAgent
  alias FlightReservation.Bookings.Booking
  alias FlightReservation.Bookings.Report

  alias FlightReservation.Users.Agent, as: UserAgent
  alias FlightReservation.Users.User

  describe "create/2" do
    test "when dates are valid, creates the report" do
      UserAgent.start_link(%{})
      BookingsAgent.start_link(%{})

      user = User.build("Sergio", "sergio@banana.com", "123.456.789-00")
      user_id = user.id

      UserAgent.save(user)

      booking1 = Booking.build(user_id, {2021, 4, 1, 10, 12}, "São Paulo", "Rio de Janeiro")
      BookingsAgent.save(booking1)

      booking2 = Booking.build(user_id, {2021, 4, 2, 10, 12}, "Rio de Janeiro", "São Paulo")
      BookingsAgent.save(booking2)

      from_date = "2021-03-01"
      to_date = "2021-04-30"
      response = Report.create(from_date, to_date)
      expected_response = {:ok, "Report successfully created"}

      assert response == expected_response
    end

    test "when dates are invalid, return an error" do
      from_date = "2021-03-01"
      to_date = "2021-04-31"
      response = Report.create(from_date, to_date)
      expected_response = {:error, "Invalid dates"}

      assert response == expected_response

    end
  end
end
