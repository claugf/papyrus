defmodule Papyrus.Repo do
  use Ecto.Repo,
    otp_app: :papyrus,
    adapter: Ecto.Adapters.Postgres
end
