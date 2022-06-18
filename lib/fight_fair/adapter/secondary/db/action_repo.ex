defmodule FightFair.Adapter.ActionRepo do
  @behaviour FightFair.ActionRepoBehaviour

  alias FightFair.Repo
  alias FightFair.Action, as: ActionDomain
  alias FightFair.Db.Action, as: ActionSchema

  @impl true
  def insert(%ActionDomain{} = action) do
    with {:ok, schema} <- ActionSchema.insert_changeset(action) |> Repo.insert() do
      {:ok, ActionSchema.to_domain(schema)}
    end
  end
end
