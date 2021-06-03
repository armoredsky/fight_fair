defmodule FightFair.RepoCase do
  use ExUnit.CaseTemplate

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
    FightFair.Repo.delete_all(FightFair.Db.User)
    :ok
  end

  setup :clean_up_db
end
