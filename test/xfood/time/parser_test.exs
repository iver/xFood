defmodule Xfood.Time.ParserTest do
  use ExUnit.Case
  alias Xfood.Time.Parser

  describe "from_string/1" do
    test "when date is like 11/05/2021 12:00:00 AM" do
      date = "11/05/2021 12:00:00 AM"
      result = Parser.from_string(date)
      expected = ~N[2021-11-05 00:00:00]
      assert expected == result
    end

    test "when date is like 12/03/2021  12:00:00 a.m." do
      date = "12/03/2021  12:00:00 a.m."
      result = Parser.from_string(date)
      expected = ~N[2021-12-03 00:00:00]
      assert expected == result
    end

    test "when date is like 20211105" do
      date = "20211105"
      result = Parser.from_string(date)
      expected = ~N[2021-11-05 00:00:00]
      assert expected == result
    end
  end
end
