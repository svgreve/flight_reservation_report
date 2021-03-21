defmodule FlightReservation.Bookings.Report do
  alias FlightReservation.Bookings.Agent, as: BookingAgent
  alias FlightReservation.Bookings.Booking

  def create(from_date, to_date) do
    with {:ok, naive_from_date} <- NaiveDateTime.from_iso8601(from_date <> " 00:00:00"),
         {:ok, naive_to_date} <- NaiveDateTime.from_iso8601(to_date <> " 23:59:00") do
      bookings_list = build_bookings_list(naive_from_date, naive_to_date)
      file_name = "reports/bookings_" <> from_date <> "_" <> to_date <> ".csv"
      File.write(file_name, bookings_list)
      {:ok, "Report successfully created"}
    else
      {:error, _reason} -> {:error, "Invalid dates"}
    end
  end

  defp build_bookings_list(naive_from_date, naive_to_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.filter(fn booking ->
      check_report_period(booking.data_completa, naive_from_date, naive_to_date)
    end)
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         id_usuario: id_usuario,
         data_completa: data_completa
       }) do
    id_usuario <>
      "," <>
      cidade_origem <>
      "," <>
      cidade_destino <>
      "," <>
      date_format(data_completa) <> "\n"
  end

  defp date_format(data_completa), do: NaiveDateTime.to_string(data_completa)

  defp check_report_period(date, from_date, to_date) do
    check_from = NaiveDateTime.compare(date, from_date)
    check_to = NaiveDateTime.compare(date, to_date)
    check_from != :lt and check_to != :gt
  end
end
