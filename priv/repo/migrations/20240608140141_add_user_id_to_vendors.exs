defmodule Xfood.Repo.Migrations.AddUserIdToVendors do
  use Ecto.Migration

  def change do
    alter table(:vendors) do
      add :user_id, references(:users)
    end
  end
end
