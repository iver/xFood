defmodule Xfood.UserFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Xfood.Repo

  alias Faker.Internet
  alias Xfood.Accounts.User

  def user_factory do
    %User{
      email: email()
    }
  end

  defp email do
    Internet.user_name() <> "@iver.mx"
  end

  def set_password(user, password) do
    changeset_with_pw_hash =
      user
      |> User.registration_changeset(%{"password" => password})

    %{hashed_password: hashed_pw} = changeset_with_pw_hash.changes

    %{user | hashed_password: hashed_pw}
  end
end
