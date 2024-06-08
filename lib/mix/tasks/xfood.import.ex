defmodule Mix.Tasks.Xfood.Import do
  @moduledoc """
  Import the data from a csv file that matches
  the header of the following columns:

  locationid, Applicant, FacilityType, cnn, LocationDescription,
  Address, blocklot, block, lot, permit, Status, FoodItems, X, Y,
  Latitude, Longitude, Schedule, dayshours, NOISent, Approved, Received,
  PriorPermit, ExpirationDate, Location,
  "Fire Prevention Districts", "Police Districts", "Supervisor Districts",
  "Zip Codes", "Neighborhoods (old)"

  ## Examples

  ```elixir
  mix xfood.import -f <xml_file_name> -u <user_id>
  ```

  ## Command line options

  * `-f`, `--file`      - filename to load       (required)
  * `-u`, `--user`      - user id who performs the import (required)

  """

  use Mix.Task

  require Logger

  alias Xfood.Application
  alias Xfood.Reader

  @shortdoc "Import csv file into the system"

  def instructions do
    """
    This mix task expected to receive parameters, run the following command to see the help.

    mix help xfood.import
    """
  end

  @spec run() :: none()
  def run, do: Mix.raise(instructions())

  @impl Mix.Task
  @spec run([binary(), ...]) :: any()
  def run(nil), do: Mix.raise(instructions())
  def run([]), do: Mix.raise(instructions())

  def run(args) do
    Mix.Task.run("app.start")

    args
    |> parse()
    |> evaluate_switches()
    |> execute()
  end

  def parse(args) do
    switches = [
      file: :string,
      user_id: :integer,
      help: :boolean,
      version: :boolean
    ]

    aliases = [f: :file, u: :user_id, h: :help, v: :version]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end

  def evaluate_switches({switches, args, invalid}) do
    valid? = valid?(invalid)

    cond do
      not valid? -> show_error(switches)
      valid? and length(switches) > 0 -> switches
      valid? and length(args) > 0 -> args
    end
  end

  defp execute(params) when is_list(params) do
    params
    |> Enum.into(%{})
    |> execute()
  end

  defp execute(%{h: true}) do
    Mix.shell().info(instructions())
  end

  defp execute(%{help: true}) do
    Mix.shell().info(instructions())
  end

  defp execute(%{u: user_id, f: file} = params) do
    params
    |> Map.merge(%{user_id: user_id, file: file})
    |> Map.drop([:u, :f])
    |> execute()
  end

  defp execute(%{user_id: user_id, file: file} = _params) do
    Reader.run(file, user_id)
  end

  defp execute(%{version: true}) do
    Mix.shell().info("#{Application.full_name()}")
  end

  defp execute(default) do
    Mix.shell().error("==== Missing information: ====")
    Mix.shell().info("\t#{inspect(default)}")
    show_error(default)
  end

  defp valid?(input) do
    case input do
      nil -> true
      input when is_list(input) -> input == []
      _ -> Logger.error("Invalid: #{inspect(input)}")
    end
  end

  # show_error send message to console and display help
  defp show_error(input) do
    Mix.shell().info("\t#{inspect(input)}")
    Mix.shell().info("--------------------------------------------")
    Mix.shell().info("VERSION: #{Application.version()}")
    instructions()
  end
end
