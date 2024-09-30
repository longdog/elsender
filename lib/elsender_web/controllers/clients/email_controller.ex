defmodule ElsenderWeb.Clients.EmailController do
  use ElsenderWeb, :controller

  alias Elsender.Client
  alias Elsender.Client.Email

  def index(conn, _params) do
    emails = Client.list_emails()
    render(conn, :index, emails: emails)
  end

  def new(conn, _params) do
    changeset = Client.change_email(%Email{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"email" => email_params}) do
    case Client.create_email(email_params) do
      {:ok, email} ->
        conn
        |> put_flash(:info, "Email created successfully.")
        |> redirect(to: ~p"/clients/emails/#{email}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    email = Client.get_email!(id)
    render(conn, :show, email: email)
  end

  def edit(conn, %{"id" => id}) do
    email = Client.get_email!(id)
    changeset = Client.change_email(email)
    render(conn, :edit, email: email, changeset: changeset)
  end

  def update(conn, %{"id" => id, "email" => email_params}) do
    email = Client.get_email!(id)

    case Client.update_email(email, email_params) do
      {:ok, email} ->
        conn
        |> put_flash(:info, "Email updated successfully.")
        |> redirect(to: ~p"/clients/emails/#{email}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, email: email, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    email = Client.get_email!(id)
    {:ok, _email} = Client.delete_email(email)

    conn
    |> put_flash(:info, "Email deleted successfully.")
    |> redirect(to: ~p"/clients/emails")
  end
end
