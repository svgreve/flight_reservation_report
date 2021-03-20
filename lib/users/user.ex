defmodule FlightReservation.Users.User do

  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys
  @regex_cpf ~r/^\d{3}\.\d{3}\.\d{3}\-\d{2}$/

  defstruct @keys

  def build(name, email, cpf) do
    case is_cpf_valid(cpf) do
      true ->   %__MODULE__{
        id: UUID.uuid4(),
        name: name,
        email: email,
        cpf: cpf
      }
      false -> {:error, "Invalid CPF: " <> cpf}
    end

  end

  def build() do
    {:error, "Invalid parameters"}

  end

  defp is_cpf_valid(cpf), do: Regex.match?(@regex_cpf, cpf)
end
