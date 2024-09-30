defmodule Elsender.Client.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field :name, :string
    field :email, :string
    field :phone, :string
    field :getCatalog, :boolean, default: false
    field :getPrice, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:name, :email, :phone, :getCatalog, :getPrice])
    |> validate_required([:name, :email, :phone, :getCatalog, :getPrice])
  end
end
