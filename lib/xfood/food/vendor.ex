defmodule Xfood.Food.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vendors" do
    field :block, :string
    field :status, :string
    field :permit, :string
    field :location, :string
    field :approved, :string
    field :y, :float
    field :x, :float
    field :location_id, :integer
    field :applicant, :string
    field :facility_type, :string
    field :cnn, :integer
    field :location_description, :string
    field :andress, :string
    field :blocklot, :string
    field :lot, :string
    field :food_items, :string
    field :latitud, :float
    field :longitude, :float
    field :schedule, :string
    field :days_hours, :string
    field :noi_sent, :string
    field :received, :naive_datetime
    field :prior_permit, :boolean, default: false
    field :expiration_date, :naive_datetime
    field :fire_prevention_districts, :integer
    field :police_districts, :integer
    field :supervisor_districts, :integer
    field :zip_codes, :string
    field :old_neighborhoods, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vendor, attrs) do
    vendor
    |> cast(attrs, [:location_id, :applicant, :facility_type, :cnn, :location_description, :andress, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitud, :longitude, :schedule, :days_hours, :noi_sent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districts, :police_districts, :supervisor_districts, :zip_codes, :old_neighborhoods])
    |> validate_required([:location_id, :applicant, :facility_type, :cnn, :location_description, :andress, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitud, :longitude, :schedule, :days_hours, :noi_sent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districts, :police_districts, :supervisor_districts, :zip_codes, :old_neighborhoods])
  end
end
