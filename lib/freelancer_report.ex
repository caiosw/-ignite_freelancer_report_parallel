alias FreelancerReport.Parser

defmodule FreelancerReport do
  @months %{
    1 => "janeiro",
    2 => "fevereiro",
    3 => "março",
    4 => "abril",
    5 => "maio",
    6 => "junho",
    7 => "julho",
    8 => "agosto",
    9 => "setembro",
    10 => "outubro",
    11 => "novembro",
    12 => "dezembro"
  }

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> handle_file()
  end

  def build_from_list(filename_list) when not is_list(filename_list) do
    {:error, "List of file names expected"}
  end

  def build_from_list(filename_list) do
    filename_list
    |> Task.async_stream(&build/1)
    |> IO.inspect()
    |> Enum.reduce(report_acc(), fn {:ok, file}, report ->
      merge_map(file, report)
    end)
  end

  defp merge_map(map1, map2) do
    Map.merge(map1, map2, fn key, v1, v2 ->
      if is_map(map1[key]) do
        merge_map(map1[key], map2[key])
      else
        v1 + v2
      end
    end)
  end

  defp handle_file({:ok, file}), do: aggregate_lines(file)
  defp handle_file({:error, reason}), do: {:error, reason}

  defp aggregate_lines(file) do
    Enum.reduce(file, report_acc(), fn [name, hours, _day, month, year], acc ->
      acc = create_if_not_exists(acc, name)

      month_name = @months[month]

      %{
        all_hours: _all,
        hours_per_month: months,
        hours_per_year: years
      } = acc

      all = Map.put(acc.all_hours, name, acc.all_hours[name] + hours)

      user_months =
        Map.put(
          acc.hours_per_month[name],
          month_name,
          zero_if_nil(acc.hours_per_month[name][month_name]) + hours
        )

      user_years =
        Map.put(
          acc.hours_per_year[name],
          year,
          zero_if_nil(acc.hours_per_year[name][year]) + hours
        )

      build_report(all, %{months | name => user_months}, %{years | name => user_years})
    end)
  end

  defp create_if_not_exists(acc, name) do
    case acc.all_hours[name] do
      nil ->
        all_hours = Map.put(acc.all_hours, name, 0)
        hours_per_month = Map.put(acc.hours_per_month, name, %{})
        hours_per_year = Map.put(acc.hours_per_year, name, %{})

        build_report(all_hours, hours_per_month, hours_per_year)

      _ ->
        acc
    end
  end

  defp zero_if_nil(value) do
    case value do
      nil -> 0
      _ -> value
    end
  end

  defp report_acc do
    build_report(%{}, %{}, %{})
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      all_hours: all_hours,
      hours_per_month: hours_per_month,
      hours_per_year: hours_per_year
    }
  end
end
