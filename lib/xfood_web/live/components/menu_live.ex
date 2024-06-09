defmodule XfoodWeb.Components.MenuLive do
  @moduledoc """
  Encapsulates the system menu component
  """
  use Phoenix.LiveComponent
  use XfoodWeb, :html
  # import XfoodWeb.CoreComponents, only: [icon: 1]

  alias XfoodWeb.Components.Logo

  attr :to, :string, required: true
  attr :label, :string, required: true
  attr :active?, :boolean, default: false

  @spec item(map()) :: Phoenix.LiveView.Rendered.t()
  def item(assigns) do
    ~H"""
    <li>
      <.link
        href={@to}
        class="block py-2 px-4 text-gray-900 mr-2 focus:ring-4 lg:px-5 lg:py-2.5 focus:ring-gray-300 focus:outline-none rounded hover:bg-violet-100 md:hover:text-violet-700 md:p-0 dark:text-white md:dark:hover:text-violet-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700"
        aria-current={@active?}
      >
        <%= @label %>
      </.link>
    </li>
    """
  end

  slot :links

  @spec nav_items(map()) :: Phoenix.LiveView.Rendered.t()
  def nav_items(assigns) do
    ~H"""
    <ul class="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
      <%= render_slot(@links) %>
    </ul>
    """
  end

  slot :items
  slot :login_buttons

  @spec navbar(map()) :: Phoenix.LiveView.Rendered.t()
  def navbar(assigns) do
    ~H"""
    <nav class="bg-white fixed w-full z-40 border-gray-200 shadow-md px-2 sm:px-4 py-2.5 rounded dark:bg-gray-900">
      <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto px-4 py-2">
        <Logo.logo />
        <div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
          <%= render_slot(@login_buttons) %>
          <%!-- <.hamburger_button /> --%>
        </div>
        <div
          class="items-center justify-between hidden w-full lg:flex lg:w-auto lg:order-1"
          id="navbar-user"
        >
          <%= render_slot(@items) %>
        </div>
      </div>
    </nav>
    """
  end

  def hamburger_button(assigns) do
    ~H"""
    <button
      data-collapse-toggle="navbar-user"
      type="button"
      |||
      class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
      aria-controls="navbar-user"
      aria-expanded="false"
    >
      <span class="sr-only">Open main menu</span>
      <svg
        class="w-5 h-5"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 17 14"
      >
        <path
          stroke="currentColor"
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M1 1h15M1 7h15M1 13h15"
        />
      </svg>
    </button>
    """
  end
end
