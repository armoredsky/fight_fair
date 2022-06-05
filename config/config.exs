import Config

config :fight_fair, FightFair.Repo,
  database: "fight_fair",
  username: "fight_fair",
  password: "fight_fair",
  hostname: "localhost"

config :fight_fair, ecto_repos: [FightFair.Repo]
config :fight_fair, user_repo: FightFair.Adapter.UserRepo

import_config "#{Mix.env()}.exs"
