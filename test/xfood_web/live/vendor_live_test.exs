defmodule XfoodWeb.VendorLiveTest do
  use XfoodWeb.ConnCase

  import Phoenix.LiveViewTest
  import Xfood.AccountsFixtures

  alias Xfood.VendorFactory

  setup %{conn: conn} do
    user = user_fixture()
    vendor = VendorFactory.insert(:vendor, %{user_id: user.id})
    conn = log_in_user(conn, user)
    {:ok, conn: conn, user: user, vendor: vendor}
  end

  describe "Index" do
    test "lists all vendors", %{conn: conn, vendor: vendor} do
      {:ok, _index_live, html} = live(conn, ~p"/vendors")

      assert html =~ "Listing Vendors"
      assert html =~ vendor.block
    end
  end
end
