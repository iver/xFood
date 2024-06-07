defmodule XfoodWeb.Components.MenuLive do
  @moduledoc """
  Encapsulates the system menu component
  """
  use Phoenix.LiveComponent
  use XfoodWeb, :html
  # import XfoodWeb.CoreComponents, only: [icon: 1]

  def menu(assigns) do
    ~H"""
    <!-- Navbar goes here -->
    <nav class="fixed top-0 z-20 w-full backdrop-blur transition-colors border-b border-primary-800 border-opacity-40">
      <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <!-- Website Logo -->
        <a href="/" class="flex items-center space-x-3 rtl:space-x-reverse">
          <img src={~p"/images/logo.png"} alt="Logo" class="h-8 w-8 mr-2 rounded-md" />
          <span class="text-lg">xFood</span>
        </a>

        <div>
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </nav>
    """
  end

  attr :link, :string, required: true
  attr :text, :string, required: true
  attr :alt, :string
  attr :active, :boolean

  def menu_item(assigns) do
    assigns =
      assign(
        assigns,
        :styled,
        "py-1 px-2 uppercase rounded transition duration-300 font-semibold drop-shadow-lg t-shadow hover:text-secondary-600 hover:bg-secondary-200 hover:bg-opacity-40 hover:border-b-2 hover:border-secondary-500"
      )

    ~H"""
    <a href={@link} alt={@alt} class={[@styled, @active && "border"]}>
      <%= @text %>
    </a>
    """
  end
end
