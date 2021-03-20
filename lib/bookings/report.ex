defmodule FlightReservation.Bookings.Report do
  alias FlightReservation.Bookings.Agent, as: BookingAgent
  alias FlightReservation.Bookings.Booking

  def create(filename, from_date, to_date) do
    bookings_list = build_bookings_list()
    file_name = from_date <> "_" <> to_date <> "_" <> filename
    File.write("reports/" <> file_name, bookings_list)
  end

  defp build_bookings_list() do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)


  end

  defp booking_string(%Booking{
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         id_usuario: id_usuario,
         data_completa: data_completa
       }) do
    id_usuario.id <>
      "," <>
      cidade_origem <>
      "," <>
      cidade_destino <>
      "," <>
      date_format(data_completa) <> "\n"
  end

  defp date_format(data_completa), do: NaiveDateTime.to_string(data_completa)
end
