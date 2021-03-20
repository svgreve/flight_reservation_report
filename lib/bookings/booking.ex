defmodule FlightReservation.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys
  defstruct @keys

  def build(id_usuario, data_completa, cidade_origem, cidade_destino) do
    {ano, mes, dia, hora, minuto} = data_completa
    {:ok, data_completa_naive} = NaiveDateTime.new(ano, mes, dia, hora, minuto, 0)
    %__MODULE__{
      id: UUID.uuid4(),
      data_completa: data_completa_naive,
      cidade_origem: cidade_origem,
      cidade_destino: cidade_destino,
      id_usuario: id_usuario
    }
  end
end
