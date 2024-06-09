defmodule XfoodWeb.SignInLive do
  @moduledoc """
  Component that displays links and buttons
  for entering or exiting the system.
  """

  use XfoodWeb, :verified_routes
  use Phoenix.Component

  attr :current_user, :map, default: nil

  def login_buttons(assigns) do
    if assigns.current_user do
      ~H"""
      <.log_out name="Profile.name" email={assigns.current_user.email} />
      """
    else
      ~H"""
      <.log_in />
      """
    end
  end

  attr :login_label, :string, default: "Log in"
  attr :sign_up_label, :string, default: "Register"

  @spec log_in(map()) :: Phoenix.LiveView.Rendered.t()
  def log_in(assigns) do
    ~H"""
    <.link
      href={~p"/users/log_in"}
      class=" hover:bg-primary-100 focus:ring-4 focus:ring-gray-300 rounded-lg uppercase text-lg px-4 lg:px-5 py-2 lg:py-2.5 mr-2 focus:outline-none leading-6 text-neutral-900 font-semibold hover:text-secondary-700"
    >
      <%= @login_label %>
    </.link>
    <.link
      href={~p"/users/register"}
      class="focus:ring-4 px-4 lg:px-5 py-2 lg:py-2.5 mr-2 btn-primary font-semibold uppercase hover:underline"
    >
      <%= @sign_up_label %>
    </.link>
    """
  end

  attr :name, :string, required: true
  attr :email, :string, required: true
  attr :log_out_label, :string, default: "Log out"

  @spec log_out(map()) :: Phoenix.LiveView.Rendered.t()
  def log_out(assigns) do
    ~H"""
    <button
      type="button"
      class="flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
      id="user-menu-button"
      aria-expanded="false"
      data-dropdown-toggle="user-dropdown"
      data-dropdown-placement="bottom"
    >
      <span class="sr-only">Open main menu</span>
      <img class="w-8 h-8 rounded-full" src="/images/avatar_1.jpeg" alt="user photo" />
    </button>
    <!-- Dropdown menu -->
    <.list_menu name={@name} email={@email}>
      <:items>
        <.menu_item to={~p"/users/settings"} label="Settings" />
        <.menu_item to={~p"/users/log_out"} label={@log_out_label} method="delete" />
      </:items>
    </.list_menu>
    """
  end

  attr :to, :string, required: true
  attr :label, :string, required: true
  attr :method, :string, default: ""

  @spec menu_item(map()) :: Phoenix.LiveView.Rendered.t()
  def menu_item(assigns) do
    ~H"""
    <li>
      <.link
        href={@to}
        class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white"
        method={@method}
      >
        <%= @label %>
      </.link>
    </li>
    """
  end

  attr :name, :string, required: true
  attr :email, :string, required: true
  slot :items

  @spec list_menu(map()) :: Phoenix.LiveView.Rendered.t()
  def list_menu(assigns) do
    ~H"""
    <div
      class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded-lg shadow dark:bg-gray-700 dark:divide-gray-600"
      id="user-dropdown"
    >
      <div class="px-4 py-3">
        <span class="block text-sm text-gray-900 dark:text-white"><%= @name %></span>
        <span class="block text-sm  text-gray-500 truncate dark:text-gray-400"><%= @email %></span>
      </div>
      <ul class="py-2" aria-labelledby="user-menu-button">
        <%= render_slot(@items) %>
      </ul>
    </div>
    """
  end
end
