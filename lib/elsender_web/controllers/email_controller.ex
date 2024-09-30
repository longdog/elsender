defmodule ElsenderWeb.EmailController do
  use ElsenderWeb, :controller

  alias Elsender.Client
  alias Elsender.Client.Email

  action_fallback ElsenderWeb.FallbackController

  def index(conn, _params) do
    emails = Client.list_emails()
    render(conn, :index, emails: emails)
  end

  def create(conn, %{"email" => email_params}) do
    with {:ok, %Email{} = email} <- Client.create_email(email_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/emails/#{email}")
      |> render(:show, email: email)
    end
  end

  def show(conn, %{"id" => id}) do
    email = Client.get_email!(id)
    render(conn, :show, email: email)
  end

  def update(conn, %{"id" => id, "email" => email_params}) do
    email = Client.get_email!(id)

    with {:ok, %Email{} = email} <- Client.update_email(email, email_params) do
      render(conn, :show, email: email)
    end
  end

  def delete(conn, %{"id" => id}) do
    email = Client.get_email!(id)

    with {:ok, %Email{}} <- Client.delete_email(email) do
      send_resp(conn, :no_content, "")
    end
  end
end
