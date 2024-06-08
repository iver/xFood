defmodule Xfood.Repo.Migrations.CreateVendors do
  use Ecto.Migration

  @comment "stores mobile food truck information"

  def change do
    create table(:vendors, comment: @comment) do
      add :location_id, :integer
      add :applicant, :string
      add :facility_type, :string
      add :cnn, :integer
      add :location_description, :string
      add :address, :string
      add :blocklot, :string
      add :block, :string
      add :lot, :string
      add :permit, :string
      add :status, :string
      add :food_items, :text
      add :x, :float
      add :y, :float
      add :latitud, :float
      add :longitude, :float
      add :schedule, :string
      add :days_hours, :string
      add :noi_sent, :string
      add :approved, :naive_datetime
      add :received, :naive_datetime
      add :prior_permit, :boolean, default: false, null: false
      add :expiration_date, :naive_datetime
      add :location, :string
      add :fire_prevention_districts, :integer
      add :police_districts, :integer
      add :supervisor_districts, :integer
      add :zip_codes, :string
      add :old_neighborhoods, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
