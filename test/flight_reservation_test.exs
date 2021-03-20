defmodule FlightReservationTest do
  use ExUnit.Case

  alias FlightReservation

  describe "create_user/1" do
    test "when all parameters are correct, create the user" do
      FlightReservation.start_agents()

      user_params = %{
        name: "Sergio",
        email: "sergio@banana.com",
        cpf: "123.456.789-00"
      }

      {:ok, user_id} = FlightReservation.create_user(user_params)

      expected_user_id = user_id

      assert user_id == expected_user_id
    end

    test "when cpf is invalid, returns an error" do
      FlightReservation.start_agents()

      user_params = %{
        name: "Sergio",
        email: "sergio@banana.com",
        cpf: "123456789"
      }

      response = FlightReservation.create_user(user_params)

      expected_response = {:error, "Invalid CPF: 123456789"}
      assert response == expected_response
    end

    test "when there are no user parameters, returns an error" do
      FlightReservation.start_agents()
      response = FlightReservation.create_user(%{})

      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end

  describe "create_booking/2" do
    test "when all parameters are correct, creates the booking" do
      FlightReservation.start_agents()

      user_params = %{
        name: "Sergio",
        email: "sergio@banana.com",
        cpf: "123.456.789-00"
      }

      {:ok, user_id} = FlightReservation.create_user(user_params)


      booking_params = %{
        ano: 2021,
        mes: 4,
        dia: 1,
        hora: 20,
        minuto: 30,
        cidade_origem: "São Paulo",
        cidade_destino: "Rio de Janeiro"
      }

      {:ok, booking_id} = FlightReservation.create_booking(user_id, booking_params)

      is_binary(booking_id)
    end

    test "when the user does not exist, returns an error" do
      FlightReservation.start_agents()
      booking_params = %{
        ano: 2021,
        mes: 4,
        dia: 1,
        hora: 20,
        minuto: 30,
        cidade_origem: "São Paulo",
        cidade_destino: "Rio de Janeiro"
      }
      user_id = "user not found"

      response = FlightReservation.create_booking(user_id, booking_params)
      expected_response = {:ok, "User not found"}

      assert response == expected_response


    end
  end
end
