defmodule FlightReservation.Users.UserTest do
  use ExUnit.Case
  alias FlightReservation.Users.User

  describe "build/3" do
    test "when all parameters are valid, returns the user" do
      response = User.build("Sergio", "sergio@banana.com", "123.456.789-00")

      expected_response = %FlightReservation.Users.User{
        cpf: "123.456.789-00",
        email: "sergio@banana.com",
        id: response.id,
        name: "Sergio"
      }

      assert response == expected_response
    end

    test "when cpf is invalid, return an error" do
      response = User.build("Sergio", "sergio@banana.com", "123456789")
      expected_response = {:error, "Invalid CPF: 123456789"}

      assert response == expected_response
    end

    test "when no parameters are provided, return an error" do
      response = User.build()
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
