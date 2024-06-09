defmodule XfoodWeb.Components.Logo do
  @moduledoc """
  Componente con funciones para mostrar el logo como componente.
  """
  use Phoenix.Component

  attr :name, :string, default: "xFood"

  def logo(assigns) do
    ~H"""
    <a href="/" class="flex items-center space-x-3 rtl:space-x-reverse">
      <img src="/images/logo.png" class="mr-3 h-12 rounded-md" alt="xFood Logo" />
      <span class="self-center sr-only lg:not-sr-only text-2xl font-semibold whitespace-nowrap dark:text-white">
        <%= @name %>
      </span>
    </a>
    """
  end
end
