defmodule FreelancerReport.Parser do
  def parse_file(filename) do
    filepath = "reports/#{filename}"

    if File.exists?(filepath) do
      result =
        filepath
        |> File.stream!()
        |> Enum.map(&parse_line/1)

      {:ok, result}
    else
      {:error, "File not found!"}
    end
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
    |> List.update_at(3, &String.to_integer/1)
  end
end
