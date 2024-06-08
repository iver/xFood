defmodule Mix.Tasks.Xfood.ImportTest do
  use Xfood.DataCase

  alias Mix.Tasks.Xfood.Import
  alias Xfood.AccountsFixtures

  describe "instructions/0" do
    test "contains help instructions" do
      assert Import.instructions() =~ "mix help xfood.import"
    end
  end

  describe "run/0" do
    test "print error when no args" do
      assert_raise Mix.Error, Import.instructions(), fn ->
        Import.run()
      end
    end

    test "when switch is nil" do
      assert_raise Mix.Error, Import.instructions(), fn ->
        Import.run()
      end
    end
  end

  describe "run/1" do
    @data_source "priv/Mobile_Food_Facility_Permit.csv"
    setup do
      {:ok, %{user: AccountsFixtures.user_fixture()}}
    end

    test "when file contains data", %{user: user} do
      data = [f: @data_source, u: user.id]
      result = Import.run(data)
      assert is_list(result)
      assert length(result) == 629
    end
  end
end
