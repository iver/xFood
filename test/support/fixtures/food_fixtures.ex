defmodule Xfood.FoodFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Xfood.Food` context.
  """

  @doc """
  Generate a vendor.
  """
  def vendor_fixture(attrs \\ %{}) do
    {:ok, vendor} =
      attrs
      |> Enum.into(%{
        andress: "some andress",
        applicant: "some applicant",
        approved: "some approved",
        block: "some block",
        blocklot: "some blocklot",
        cnn: 42,
        days_hours: "some days_hours",
        expiration_date: ~N[2024-06-07 12:43:00],
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
      })
      |> Xfood.Food.create_vendor()

    vendor
  end
end
