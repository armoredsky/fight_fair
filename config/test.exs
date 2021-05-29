import Config

config :fight_fair, FightFair.Repo,
  database: "fight_fair",
  username: "fight_fair",
  password: "fight_fair",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info
