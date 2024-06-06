defmodule Xfood.Repo do
  use Ecto.Repo,
    otp_app: :xfood,
    adapter: Ecto.Adapters.Postgres
end
