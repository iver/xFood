defmodule Xfood.VendorFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Xfood.Repo

  alias Faker.Address
  alias Xfood.Food.Vendor

  def vendor_factory do
    %Vendor{
      address: Address.street_address(),
      applicant: get_applicant(),
      approved: ~N[2023-06-07 18:43:00],
      block: "some block",
      blocklot: "some blocklot",
      cnn: 42,
      days_hours: "some days_hours",
      expiration_date: ~N[2026-06-07 12:43:00],
      facility_type: "some facility_type",
      fire_prevention_districts: 42,
      food_items: "some food_items",
      latitud: 120.5,
      location: "some location",
      location_description: "some location_description",
      location_id: 42,
      longitude: 120.5,
      lot: "some lot",
      noi_sent: "some noi_sent",
      old_neighborhoods: 42,
      permit: "some permit",
      police_districts: 42,
      prior_permit: true,
      received: ~N[2024-06-07 12:43:00],
      schedule: "some schedule",
      status: "some status",
      supervisor_districts: 42,
      x: 120.5,
      y: 120.5,
      zip_codes: "some zip_codes"
    }
  end

  defp get_applicant do
    [
      ~c"Treats by the Bay LLC",
      ~c"MOMO INNOVATION LLC",
      ~c"El Calamar Perubian Food Truck",
      ~c"BH & MT LLC",
      ~c"BOWL'D ACAI, LLC.",
      ~c"The Chef Station"
    ]
    |> Enum.random()
    |> to_string()
  end
end
