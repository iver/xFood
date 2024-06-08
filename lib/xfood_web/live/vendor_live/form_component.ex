defmodule XfoodWeb.VendorLive.FormComponent do
  use XfoodWeb, :live_component

  alias Xfood.Food

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage vendor records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="vendor-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:location_id]} type="number" label="Location" />
        <.input field={@form[:applicant]} type="text" label="Applicant" />
        <.input field={@form[:facility_type]} type="text" label="Facility type" />
        <.input field={@form[:cnn]} type="number" label="Cnn" />
        <.input field={@form[:location_description]} type="text" label="Location description" />
        <.input field={@form[:andress]} type="text" label="Andress" />
        <.input field={@form[:blocklot]} type="text" label="Blocklot" />
        <.input field={@form[:block]} type="text" label="Block" />
        <.input field={@form[:lot]} type="text" label="Lot" />
        <.input field={@form[:permit]} type="text" label="Permit" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:food_items]} type="text" label="Food items" />
        <.input field={@form[:x]} type="number" label="X" step="any" />
        <.input field={@form[:y]} type="number" label="Y" step="any" />
        <.input field={@form[:latitud]} type="number" label="Latitud" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <.input field={@form[:schedule]} type="text" label="Schedule" />
        <.input field={@form[:days_hours]} type="text" label="Days hours" />
        <.input field={@form[:noi_sent]} type="text" label="Noi sent" />
        <.input field={@form[:approved]} type="text" label="Approved" />
        <.input field={@form[:received]} type="datetime-local" label="Received" />
        <.input field={@form[:prior_permit]} type="checkbox" label="Prior permit" />
        <.input field={@form[:expiration_date]} type="datetime-local" label="Expiration date" />
        <.input field={@form[:location]} type="text" label="Location" />
        <.input field={@form[:fire_prevention_districts]} type="number" label="Fire prevention districts" />
        <.input field={@form[:police_districts]} type="number" label="Police districts" />
        <.input field={@form[:supervisor_districts]} type="number" label="Supervisor districts" />
        <.input field={@form[:zip_codes]} type="text" label="Zip codes" />
        <.input field={@form[:old_neighborhoods]} type="number" label="Old neighborhoods" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Vendor</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{vendor: vendor} = assigns, socket) do
    changeset = Food.change_vendor(vendor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"vendor" => vendor_params}, socket) do
    changeset =
      socket.assigns.vendor
      |> Food.change_vendor(vendor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"vendor" => vendor_params}, socket) do
    save_vendor(socket, socket.assigns.action, vendor_params)
  end

  defp save_vendor(socket, :edit, vendor_params) do
    case Food.update_vendor(socket.assigns.vendor, vendor_params) do
      {:ok, vendor} ->
        notify_parent({:saved, vendor})

        {:noreply,
         socket
         |> put_flash(:info, "Vendor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_vendor(socket, :new, vendor_params) do
    case Food.create_vendor(vendor_params) do
      {:ok, vendor} ->
        notify_parent({:saved, vendor})

        {:noreply,
         socket
         |> put_flash(:info, "Vendor created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
