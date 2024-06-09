defmodule Xfood.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @name Mix.Project.config()[:app]
  @version Mix.Project.config()[:version]
  @env Mix.env()

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      XfoodWeb.Telemetry,
      Xfood.Repo,
      {DNSCluster, query: Application.get_env(:xfood, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Xfood.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Xfood.Finch},
      # Start a worker by calling: Xfood.Worker.start_link(arg)
      # {Xfood.Worker, arg},
      # Start to serve requests, typically the last entry
      XfoodWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Xfood.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    XfoodWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  @spec env() :: :test
  def env, do: @env
  @spec full_name() :: <<_::64, _::_*8>>
  def full_name, do: "#{name()} #{@version} [#{@env}]"
  @spec name() :: binary()
  def name, do: @name |> to_string() |> String.upcase()
  @spec version() :: <<_::40>>
  def version, do: @version

  def host do
    endpoint = Application.fetch_env!(:xfood, XfoodWeb.Endpoint)
    endpoint[:url][:host]
  end
end
