defmodule Elsender.ClientFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elsender.Client` context.
  """

  @doc """
  Generate a email.
  """
  def email_fixture(attrs \\ %{}) do
    {:ok, email} =
      attrs
      |> Enum.into(%{
        email: "some email",
        getCatalog: true,
        getPrice: true,
        name: "some name",
        phone: "some phone"
      })
      |> Elsender.Client.create_email()

    email
  end
end
