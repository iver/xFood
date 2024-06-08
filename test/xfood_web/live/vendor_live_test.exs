defmodule XfoodWeb.VendorLiveTest do
  use XfoodWeb.ConnCase

  import Phoenix.LiveViewTest
  import Xfood.FoodFixtures

  @create_attrs %{
    block: "some block",
    status: "some status",
    permit: "some permit",
    location: "some location",
    approved: "some approved",
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
    received: "2024-06-07T12:43:00",
    prior_permit: true,
    expiration_date: "2024-06-07T12:43:00",
    fire_prevention_districts: 42,
    police_districts: 42,
    supervisor_districts: 42,
    zip_codes: "some zip_codes",
    old_neighborhoods: 42
  }
  @update_attrs %{
    block: "some updated block",
    status: "some updated status",
    permit: "some updated permit",
    location: "some updated location",
    approved: "some updated approved",
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
    received: "2024-06-08T12:43:00",
    prior_permit: false,
    expiration_date: "2024-06-08T12:43:00",
    fire_prevention_districts: 43,
    police_districts: 43,
    supervisor_districts: 43,
    zip_codes: "some updated zip_codes",
    old_neighborhoods: 43
  }
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
    prior_permit: false,
    expiration_date: nil,
    fire_prevention_districts: nil,
    police_districts: nil,
    supervisor_districts: nil,
    zip_codes: nil,
    old_neighborhoods: nil
  }

  defp create_vendor(_) do
    vendor = vendor_fixture()
    %{vendor: vendor}
  end

  describe "Index" do
    setup [:create_vendor]

    test "lists all vendors", %{conn: conn, vendor: vendor} do
      {:ok, _index_live, html} = live(conn, ~p"/vendors")

      assert html =~ "Listing Vendors"
      assert html =~ vendor.block
    end

    test "saves new vendor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/vendors")

      assert index_live |> element("a", "New Vendor") |> render_click() =~
               "New Vendor"

      assert_patch(index_live, ~p"/vendors/new")

      assert index_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vendor-form", vendor: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vendors")

      html = render(index_live)
      assert html =~ "Vendor created successfully"
      assert html =~ "some block"
    end

    test "updates vendor in listing", %{conn: conn, vendor: vendor} do
      {:ok, index_live, _html} = live(conn, ~p"/vendors")

      assert index_live |> element("#vendors-#{vendor.id} a", "Edit") |> render_click() =~
               "Edit Vendor"

      assert_patch(index_live, ~p"/vendors/#{vendor}/edit")

      assert index_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vendor-form", vendor: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vendors")

      html = render(index_live)
      assert html =~ "Vendor updated successfully"
      assert html =~ "some updated block"
    end

    test "deletes vendor in listing", %{conn: conn, vendor: vendor} do
      {:ok, index_live, _html} = live(conn, ~p"/vendors")

      assert index_live |> element("#vendors-#{vendor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vendors-#{vendor.id}")
    end
  end

  describe "Show" do
    setup [:create_vendor]

    test "displays vendor", %{conn: conn, vendor: vendor} do
      {:ok, _show_live, html} = live(conn, ~p"/vendors/#{vendor}")

      assert html =~ "Show Vendor"
      assert html =~ vendor.block
    end

    test "updates vendor within modal", %{conn: conn, vendor: vendor} do
      {:ok, show_live, _html} = live(conn, ~p"/vendors/#{vendor}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vendor"

      assert_patch(show_live, ~p"/vendors/#{vendor}/show/edit")

      assert show_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#vendor-form", vendor: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/vendors/#{vendor}")

      html = render(show_live)
      assert html =~ "Vendor updated successfully"
      assert html =~ "some updated block"
    end
  end
end
