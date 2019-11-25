defmodule Bloggy.Repo do
  use Ecto.Repo,
    otp_app: :bloggy,
    adapter: Ecto.Adapters.Postgres
end
