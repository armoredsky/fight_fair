import Config

config :fight_fair, FightFair.Repo,
  database: "fight_fair",
  username: "fight_fair",
  password: "fight_fair",
  hostname: "localhost"

config :fight_fair, ecto_repos: [FightFair.Repo]

import_config "#{Mix.env()}.exs"
