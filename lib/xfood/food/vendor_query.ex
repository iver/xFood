defmodule Xfood.Food.VendorQuery do
  @moduledoc """
  Contains the statements that build the queries to facilitate their reuse
  """
  import Ecto.Query, warn: false

  def by_user(query, user) do
    where(query, [i], i.user_id == ^user.id)
  end
end
