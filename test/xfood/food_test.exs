defmodule Xfood.FoodTest do
  use Xfood.DataCase
  import Xfood.AccountsFixtures
  alias Xfood.Food

  describe "vendors" do
    alias Xfood.Food.Vendor
    alias Xfood.VendorFactory

    @invalid_attrs %{
      block: nil,
      status: nil,
      permit: nil,
      location: nil,
      approved: nil,
      y: nil,
      x: nil,
      location_id: nil,
      applicant: nil,
      facility_type: nil,
      cnn: nil,
      location_description: nil,
      address: nil,
      blocklot: nil,
      lot: nil,
      food_items: nil,
      latitud: nil,
      longitude: nil,
      schedule: nil,
      days_hours: nil,
      noi_sent: nil,
      received: nil,
      prior_permit: nil,
      expiration_date: nil,
      fire_prevention_districts: nil,
      police_districts: nil,
      supervisor_districts: nil,
      zip_codes: nil,
      old_neighborhoods: nil
    }

    setup do
      user = user_fixture()
      vendor = VendorFactory.insert(:vendor, %{user_id: user.id})
      {:ok, user: user, vendor: vendor}
    end

    test "list_vendors/0 returns all vendors", %{vendor: vendor, user: user} do
      assert Food.list_vendors(user) == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given id", %{vendor: vendor} do
      assert Food.get_vendor!(vendor.id) == vendor
    end

    test "create_vendor/1 with valid data creates a vendor", %{user: user} do
      valid_attrs = %{
        block: "some block",
        status: "some status",
        permit: "some permit",
        location: "some location",
        approved: ~N[2023-06-07 12:43:00],
        y: 120.5,
        x: 120.5,
        location_id: 42,
        applicant: "some applicant",
        facility_type: "some facility_type",
        cnn: 42,
        location_description: "some location_description",
        address: "some address",
        blocklot: "some blocklot",
        lot: "some lot",
        food_items: "some food_items",
        latitud: 120.5,
        longitude: 120.5,
        schedule: "some schedule",
        days_hours: "some days_hours",
        noi_sent: "some noi_sent",
        received: ~N[2024-06-07 12:43:00],
        prior_permit: true,
        expiration_date: ~N[2024-06-07 12:43:00],
        fire_prevention_districts: 42,
        police_districts: 42,
        supervisor_districts: 42,
        zip_codes: "some zip_codes",
        old_neighborhoods: 42,
        user_id: user.id
      }

      assert {:ok, %Vendor{} = vendor} = Food.create_vendor(valid_attrs)
      assert vendor.block == "some block"
      assert vendor.status == "some status"
      assert vendor.permit == "some permit"
      assert vendor.location == "some location"
      assert vendor.approved == ~N[2023-06-07 12:43:00]
      assert vendor.y == 120.5
      assert vendor.x == 120.5
      assert vendor.location_id == 42
      assert vendor.applicant == "some applicant"
      assert vendor.facility_type == "some facility_type"
      assert vendor.cnn == 42
      assert vendor.location_description == "some location_description"
      assert vendor.address == "some address"
      assert vendor.blocklot == "some blocklot"
      assert vendor.lot == "some lot"
      assert vendor.food_items == "some food_items"
      assert vendor.latitud == 120.5
      assert vendor.longitude == 120.5
      assert vendor.schedule == "some schedule"
      assert vendor.days_hours == "some days_hours"
      assert vendor.noi_sent == "some noi_sent"
      assert vendor.received == ~N[2024-06-07 12:43:00]
      assert vendor.prior_permit == true
      assert vendor.expiration_date == ~N[2024-06-07 12:43:00]
      assert vendor.fire_prevention_districts == 42
      assert vendor.police_districts == 42
      assert vendor.supervisor_districts == 42
      assert vendor.zip_codes == "some zip_codes"
      assert vendor.old_neighborhoods == 42
      assert vendor.user_id == user.id
    end

    test "create_vendor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_vendor(@invalid_attrs)
    end

    test "update_vendor/2 with valid data updates the vendor", %{vendor: vendor, user: user} do
      update_attrs = %{
        block: "some updated block",
        status: "some updated status",
        permit: "some updated permit",
        location: "some updated location",
        approved: ~N[2024-06-08 12:43:00],
        y: 456.7,
        x: 456.7,
        location_id: 43,
        applicant: "some updated applicant",
        facility_type: "some updated facility_type",
        cnn: 43,
        location_description: "some updated location_description",
        address: "some updated address",
        blocklot: "some updated blocklot",
        lot: "some updated lot",
        food_items: "some updated food_items",
        latitud: 456.7,
        longitude: 456.7,
        schedule: "some updated schedule",
        days_hours: "some updated days_hours",
        noi_sent: "some updated noi_sent",
        received: ~N[2024-01-08 12:43:00],
        prior_permit: false,
        expiration_date: ~N[2025-06-08 12:43:00],
        fire_prevention_districts: 43,
        police_districts: 43,
        supervisor_districts: 43,
        zip_codes: "some updated zip_codes",
        old_neighborhoods: 43,
        user_id: user.id
      }

      assert {:ok, %Vendor{} = vendor} = Food.update_vendor(vendor, update_attrs)
      assert vendor.block == "some updated block"
      assert vendor.status == "some updated status"
      assert vendor.permit == "some updated permit"
      assert vendor.location == "some updated location"
      assert vendor.approved == ~N[2024-06-08 12:43:00]
      assert vendor.y == 456.7
      assert vendor.x == 456.7
      assert vendor.location_id == 43
      assert vendor.applicant == "some updated applicant"
      assert vendor.facility_type == "some updated facility_type"
      assert vendor.cnn == 43
      assert vendor.location_description == "some updated location_description"
      assert vendor.address == "some updated address"
      assert vendor.blocklot == "some updated blocklot"
      assert vendor.lot == "some updated lot"
      assert vendor.food_items == "some updated food_items"
      assert vendor.latitud == 456.7
      assert vendor.longitude == 456.7
      assert vendor.schedule == "some updated schedule"
      assert vendor.days_hours == "some updated days_hours"
      assert vendor.noi_sent == "some updated noi_sent"
      assert vendor.received == ~N[2024-01-08 12:43:00]
      assert vendor.prior_permit == false
      assert vendor.expiration_date == ~N[2025-06-08 12:43:00]
      assert vendor.fire_prevention_districts == 43
      assert vendor.police_districts == 43
      assert vendor.supervisor_districts == 43
      assert vendor.zip_codes == "some updated zip_codes"
      assert vendor.old_neighborhoods == 43
      assert vendor.user_id == user.id
    end

    test "update_vendor/2 with invalid data returns error changeset", %{vendor: vendor} do
      assert {:error, %Ecto.Changeset{}} = Food.update_vendor(vendor, @invalid_attrs)
      assert vendor == Food.get_vendor!(vendor.id)
    end

    test "delete_vendor/1 deletes the vendor", %{vendor: vendor} do
      assert {:ok, %Vendor{}} = Food.delete_vendor(vendor)
      assert_raise Ecto.NoResultsError, fn -> Food.get_vendor!(vendor.id) end
    end

    test "change_vendor/1 returns a vendor changeset", %{vendor: vendor} do
      assert %Ecto.Changeset{} = Food.change_vendor(vendor)
    end
  end
end
