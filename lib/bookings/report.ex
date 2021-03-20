defmodule FlightReservation.Bookings.Report do
  alias FlightReservation.Bookings.Agent, as: BookingAgent
  alias FlightReservation.Bookings.Booking

  def create(filename) do
    bookings_list = build_bookings_list()
    File.write("reports/"<>filename, bookings_list)
  end

  defp build_bookings_list() do
    BookingAgent.get_all
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{cidade_origem: cidade_origem, cidade_destino: cidade_destino}) do
    cidade_origem <> ", " <> cidade_destino <> "\n"
  end
end
