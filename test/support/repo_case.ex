defmodule FightFair.RepoCase do
  use ExUnit.CaseTemplate
  import Ecto.Query, only: [from: 2]

  using do
    quote do
      alias FightFair.Repo

      import Ecto
      import Ecto.Query
      import FightFair.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FightFair.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(FightFair.Repo, {:shared, self()})
    end

    :ok
  end

  def clean_up_db(_context) do
    query = from fa in "fight_actions", select: fa.action_id
    FightFair.Repo.delete_all(query)

    query = from fp in "fight_participants", select: fp.user_id
    FightFair.Repo.delete_all(query)

    FightFair.Repo.delete_all(FightFair.Db.User)
    FightFair.Repo.delete_all(FightFair.Db.Fight)
    FightFair.Repo.delete_all(FightFair.Db.Action)
    :ok
  end

  setup :clean_up_db
end
