defmodule Rocketmeals.Repo do
  use Ecto.Repo,
    otp_app: :rocketmeals,
    adapter: Ecto.Adapters.Postgres
end
