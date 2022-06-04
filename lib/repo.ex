defmodule FightFair.Repo do
  use Ecto.Repo,
    otp_app: :fight_fair,
    adapter: Ecto.Adapters.Postgres
end
