defmodule Xfood.Reader do
  @moduledoc """
  Contains the logic to read, extract and route information from a csv file.
  """
  require Logger

  alias Xfood.Food
  alias Xfood.Time.Parser, as: TimeParser

  @fields %{
    location_id: %{index: 0, type: :integer},
    applicant: %{index: 1, type: :string},
    facility_type: %{index: 2, type: :string},
    cnn: %{index: 3, type: :integer},
    location_description: %{index: 4, type: :string},
    address: %{index: 5, type: :string},
    blocklot: %{index: 6, type: :string},
    block: %{index: 7, type: :string},
    lot: %{index: 8, type: :string},
    permit: %{index: 9, type: :string},
    status: %{index: 10, type: :string},
    food_items: %{index: 11, type: :string},
    x: %{index: 12, type: :float},
    y: %{index: 13, type: :float},
    latitud: %{index: 14, type: :float},
    longitude: %{index: 15, type: :float},
    schedule: %{index: 16, type: :string},
    days_hours: %{index: 17, type: :string},
    noi_sent: %{index: 18, type: :string},
    approved: %{index: 19, type: :datetime},
    received: %{index: 20, type: :datetime},
    prior_permit: %{index: 21, type: :boolean},
    expiration_date: %{index: 22, type: :datetime},
    location: %{index: 23, type: :string},
    fire_prevention_districts: %{index: 24, type: :integer},
    police_districts: %{index: 25, type: :integer},
    supervisor_districts: %{index: 26, type: :integer},
    zip_codes: %{index: 27, type: :string},
    old_neighborhoods: %{index: 28, type: :integer}
  }
  def run(file, user_id) do
    results =
      file
      |> File.stream!()
      |> CSV.decode()
      |> Stream.drop(1)
      |> Stream.map(&cast_fields/1)
      |> Stream.map(fn schema -> insert_vendor(schema, user_id) end)
      |> Enum.map(& &1)

    failures = Enum.filter(results, &(&1 == :error))
    IO.puts("Imported #{Enum.count(results) - Enum.count(failures)} vendors")
    IO.puts("Failed to import #{Enum.count(failures)} ")
    results
  end

  def insert_vendor(vendor, user_id) do
    vendor
    |> Map.put(:user_id, user_id)
    |> Food.create_vendor()
    |> case do
      {:ok, vendor} ->
        vendor

      {:error, reason} ->
        Logger.error("when trying to insert: #{inspect(reason)}")
        reason
    end
  end

  def cast_fields({:ok, data}) do
    cast_fields(data)
  end

  def cast_fields(data) do
    Enum.into(@fields, %{}, fn {key, %{index: index, type: type}} ->
      {key, Enum.at(data, index) |> cast_to(type)}
    end)
  end

  def cast_to(val, :integer) do
    case val do
      "" -> 0
      val when is_binary(val) -> String.to_integer(val)
      nil -> 0
    end
  end

  def cast_to(val, :float) do
    case val do
      "" ->
        0

      val when is_binary(val) ->
        case Float.parse(val) do
          {result, _} -> result
          :error -> 0
        end

      nil ->
        0
    end
  end

  def cast_to(val, :string) do
    "#{val}"
  end

  def cast_to(val, :datetime) do
    case val do
      "" ->
        nil

      date ->
        TimeParser.from_string(date)
    end
  end

  def cast_to(val, :boolean), do: val == "1"
end
