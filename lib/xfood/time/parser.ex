defmodule Xfood.Time.Parser do
  @moduledoc """
  Module in charge of analyzing date and time to adapt them to the appropriate format.
  """

  def from_string(datetime) do
    length = String.length(datetime)

    case {datetime, length} do
      {"", _} ->
        nil

      {<<month::binary-size(2), 47, day::binary-size(2), 47, year::binary-size(4), 32, 32,
         hour::binary-size(2), 58, minute::binary-size(2), 58, seconds::binary-size(2), 32,
         xm::binary-size(1), 46, _rest::binary>>, _} ->
        "#{day}/#{month}/#{year}T#{hour}:#{minute}:#{seconds}#{xm}m"
        |> Timex.parse!("%d/%m/%YT%T%p", :strftime)

      {<<month::binary-size(2), 47, day::binary-size(2), 47, year::binary-size(4), 32,
         hour::binary-size(2), 58, minute::binary-size(2), 58, seconds::binary-size(2), 32,
         xm::binary-size(2), _rest::binary>>, _} ->
        "#{day}/#{month}/#{year}T#{hour}:#{minute}:#{seconds}#{xm}"
        |> Timex.parse!("%d/%m/%YT%T%p", :strftime)

      {short_date, 8} ->
        Timex.parse!(short_date, "{YYYY}{0M}{D}")
    end
  end
end
