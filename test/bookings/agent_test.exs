defmodule FlightReservation.Bookings.AgentTest do
  use ExUnit.Case
  alias FlightReservation.Bookings.Agent, as: BookingsAgent
  alias FlightReservation.Bookings.Booking

  describe "save/1" do
    test "saves the booking" do
      BookingsAgent.start_link(%{})

      booking =
        Booking.build( "id do usuário", {2021, 4, 1, 10, 12}, "São Paulo", "Rio de Janeiro")

      response = BookingsAgent.save(booking)
      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    test "retrieves booking by id" do
      BookingsAgent.start_link(%{})

      booking =
        Booking.build("id do usuário", {2021, 4, 1, 10, 12}, "São Paulo", "Rio de Janeiro")

      BookingsAgent.save(booking)
      response = BookingsAgent.get(booking.id)

      expected_response =
        {:ok,
         %FlightReservation.Bookings.Booking{
           cidade_destino: "Rio de Janeiro",
           cidade_origem: "São Paulo",
           data_completa: ~N[2021-04-01 10:12:00],
           id: booking.id,
           id_usuario: "id do usuário"
         }}

      assert response == expected_response
    end
    test "if booking not found, returns an error" do
      BookingsAgent.start_link(%{})
      response = BookingsAgent.get("not_found_id")
      expected_response = {:error, "Booking not found"}
      assert response == expected_response

    end
  end
end
