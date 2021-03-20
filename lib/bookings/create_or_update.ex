defmodule FlightReservation.Bookings.CreateOrUpdate do
  alias FlightReservation.Bookings.Agent, as: BookingAgent
  alias FlightReservation.Bookings.Booking
  alias FlightReservation.Users.Agent, as: UserAgent

  def call(
        id_usuario,
        %{
          ano: ano,
          mes: mes,
          dia: dia,
          hora: hora,
          minuto: minuto,
          cidade_origem: cidade_origem,
          cidade_destino: cidade_destino
        }
      ) do
    case UserAgent.get(id_usuario) do
      {:ok, id_usuario} ->
        save_booking(
          Booking.build(id_usuario, {ano, mes, dia, hora, minuto}, cidade_origem, cidade_destino)
        )

      {:error, _reason} ->
        {:ok, "User not found"}
    end
  end

  def call(), do: {:error, "Invalid parameters"}

  defp save_booking(%Booking{} = booking) do
    BookingAgent.save(booking)
    {:ok, booking.id}
  end
end
