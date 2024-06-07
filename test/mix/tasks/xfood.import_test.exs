defmodule Mix.Tasks.Xfood.ImportTest do
  use Xfood.DataCase
  alias Mix.Tasks.Xfood.Import

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
end
