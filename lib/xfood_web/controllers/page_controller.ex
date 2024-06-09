defmodule XfoodWeb.PageController do
  use XfoodWeb, :controller
  alias Xfood.Accounts.User

  def home(conn, _params) do
    %{assigns: assigns} = conn

    case assigns[:current_user] do
      nil ->
        render(conn, :home, layout: false)

      %User{} = _user ->
        redirect(conn, to: "/vendors")
    end
  end
end
