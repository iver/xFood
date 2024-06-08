defmodule Xfood.Reader do
  @moduledoc """
  Contains the logic to read, extract and route information from a csv file.
  """

  # @fields %{

  # }
  def run(file, _user_id) do
    results =
      file
      |> File.stream!()
      |> CSV.decode()
      |> Stream.drop(1)
      |> Stream.map(&cast_fields/1)
      |> Enum.map(& &1)

    failures = Enum.filter(results, &(&1 == :error))
    IO.puts("Migrated #{Enum.count(results) - Enum.count(failures)} demographics")
    IO.puts("Failed to migrate #{Enum.count(failures)} results")
  end

  def cast_fields({:ok, data}) do
    %{
      id: Enum.at(data, 0),
      name: Enum.at(data, 1),
      truck: Enum.at(data, 2)
    }
  end
end
