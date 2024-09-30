defmodule ElsenderWeb.Clients.EmailHTML do
  use ElsenderWeb, :html

  embed_templates "email_html/*"

  @doc """
  Renders a email form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def email_form(assigns)
end
