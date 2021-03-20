defmodule FlightReservation.Users.AgentTest do
  use ExUnit.Case
  alias FlightReservation.Users.Agent, as: UserAgent
  alias FlightReservation.Users.User

  describe "save/1" do
    test "saves a corrected created user" do
      UserAgent.start_link(%{})
      user = User.build("Sergio", "sergio@banana.com", "123.456.789-00")
      response = UserAgent.save(user)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    test "retrieves an user by its id" do
      UserAgent.start_link(%{})
      user = User.build("Sergio", "sergio@banana.com", "123.456.789-00")
      id = user.id
      UserAgent.save(user)

      {:ok, retrieved_user} = UserAgent.get(id)
      assert retrieved_user == user
    end

    test "when the user id does not exist, returns an error" do
      UserAgent.start_link(%{})
      response = UserAgent.get("not_found_id")
      expected_response = {:error, "User not found"}
      assert expected_response == response
    end
  end
end
