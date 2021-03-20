defmodule FlightReservation.Users.CreateOrUpdate do
  alias FlightReservation.Users.Agent, as: UserAgent
  alias FlightReservation.Users.User

  def call(%{name: name, email: email, cpf: cpf})
      when is_binary(name) and is_binary(email) and is_binary(cpf) do
    User.build(name, email, cpf)
    |> save_user()
  end

  def call(%{}), do: {:error, "Invalid parameters"}

  defp save_user(%User{} = user) do
    UserAgent.save(user)
    {:ok, user.id}
  end

  defp save_user({:error, reason}) do
    {:error, reason}
  end
end
