defmodule XfoodWeb.Components.TableLive do
  @moduledoc """
  Component that lists information in table form.
  """
  use Phoenix.Component

  @doc ~S"""
  Create a table with the generic system styles.

  ## Examples

      <.table id="users" rows={@users}>
        <:col :let={user} label="id"><%= user.id %></:col>
        <:col :let={user} label="username"><%= user.username %></:col>
        <:empty_state>No data yet!</:empty_state>
      </.table>
  """
  attr :id, :string
  attr :class, :string, default: "", doc: "CSS class"
  attr :rows, :list, default: [], doc: "list of rows to paint"
  attr :row_id, :any, default: nil, doc: "function to generate the row id"
  attr :row_click, :any, default: nil, doc: "function that handles the phx-click on each row"

  attr :row_item, :any,
    default: &Function.identity/1,
    doc: "function to assign to each row before calling the slot `:col`"

  slot :col do
    attr :label, :string
    attr :class, :string
    attr :row_class, :string
    attr :type, :string
  end

  slot :empty_state,
    doc: "a message to display when the table is empty, to be used in conjunction with :col" do
    attr :row_class, :string
  end

  attr :rest, :global, include: ~w(colspan rowspan)

  def table(assigns) do
    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end

    assigns = assign_new(assigns, :id, fn -> "table_#{Ecto.UUID.generate()}" end)

    ~H"""
    <table class={["xfood-table", @class]} {@rest}>
      <%= if length(@col) > 0 do %>
        <thead>
          <.tr>
            <.th :for={col <- @col} class={col[:class]}><%= col[:label] %></.th>
          </.tr>
        </thead>
        <tbody id={@id} phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"}>
          <%= if length(@empty_state) > 0 do %>
            <.tr class="hidden only:table-row">
              <.td
                :for={empty_state <- @empty_state}
                colspan={length(@col)}
                class={empty_state[:row_class]}
              >
                <%= render_slot(empty_state) %>
              </.td>
            </.tr>
          <% end %>
          <.tr
            :for={row <- @rows}
            id={@row_id && @row_id.(row)}
            class={"group #{if @row_click, do: "xfood-table__tr--row-click", else: ""}"}
          >
            <.td
              :for={{col, i} <- Enum.with_index(@col)}
              phx-click={@row_click && @row_click.(row)}
              class={"#{if @row_click, do: "xfood-table__td--row-click", else: ""} #{if i == 0, do: "xfood-table__td--first-col", else: ""} #{if col[:row_class], do: col[:row_class], else: ""} #{if col[:type], do: "col_#{col[:type]}", else: ""}"}
            >
              <%= render_slot(col, @row_item.(row)) %>
            </.td>
          </.tr>
        </tbody>
      <% else %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </table>
    """
  end

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global, include: ~w(colspan rowspan))
  slot(:inner_block, required: false)

  def th(assigns) do
    ~H"""
    <th class={["xfood-table__th", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </th>
    """
  end

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  slot(:inner_block, required: false)

  def tr(assigns) do
    ~H"""
    <tr class={["xfood-table__tr", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </tr>
    """
  end

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global, include: ~w(colspan headers rowspan))
  slot(:inner_block, required: false)

  def td(assigns) do
    ~H"""
    <td class={["xfood-table__td", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </td>
    """
  end

  attr(:class, :any, default: "", doc: "CSS class")
  attr(:label, :string, default: nil, doc: "Add a tag to the user, e.g. name")
  attr(:sub_label, :string, default: nil, doc: "Add a sub-tag to the user, e.g. qualification")
  attr(:rest, :global)

  def user_inner_td(assigns) do
    ~H"""
    <div class={@class} {@rest}>
      <div class="xfood-table__user-inner-td">
        <div class="xfood-table__user-inner-td__inner">
          <div class="xfood-table__user-inner-td__label">
            <%= @label %>
          </div>
          <div class="xfood-table__user-inner-td__sub-label">
            <%= @sub_label %>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
