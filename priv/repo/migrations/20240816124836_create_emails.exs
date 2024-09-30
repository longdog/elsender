defmodule Elsender.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :getCatalog, :boolean, default: false, null: false
      add :getPrice, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
