defmodule Elsender.Repo do
  use Ecto.Repo,
    otp_app: :elsender,
    adapter: Ecto.Adapters.SQLite3
end
