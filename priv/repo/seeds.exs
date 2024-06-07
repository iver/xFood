# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Xfood.Repo.insert!(%Xfood.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if Mix.env() in [:test, :dev] do
  Code.require_file("../../test/support/factories/user_factory.ex", __DIR__)
end

alias Xfood.UserFactory

UserFactory.insert(:user,
  email: "tester@iver.mx",
  hashed_password: "$2b$12$tChm4mLDRMXof1WpDOlixuH/8BeUuWX62QuPtazGyfKuGmukdwDia"
)
