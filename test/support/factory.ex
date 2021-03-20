defmodule FlightReservation.Factory do
  use ExMachina
  alias FlightReservation.Users.User

  def user_factory do
    %User{
      id: "id do usuário",
      name: "nome do usuário",
      email: "email do usuário",
      cpf: "cpf do usuário"
    }
  end
end
