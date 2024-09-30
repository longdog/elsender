defmodule ElsenderWeb.EmailJSON do
  alias Elsender.Client.Email

  @doc """
  Renders a list of emails.
  """
  def index(%{emails: emails}) do
    %{data: for(email <- emails, do: data(email))}
  end

  @doc """
  Renders a single email.
  """
  def show(%{email: email}) do
    %{data: data(email)}
  end

  defp data(%Email{} = email) do
    %{
      id: email.id,
      name: email.name,
      email: email.email,
      phone: email.phone,
      getCatalog: email.getCatalog,
      getPrice: email.getPrice
    }
  end
end
