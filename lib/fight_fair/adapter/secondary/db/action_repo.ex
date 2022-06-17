defmodule FightFair.Adapter.ActionRepo do
  @behaviour FightFair.ActionRepoBehaviour

  alias FightFair.Repo
  alias FightFair.Action, as: ActionDomain
  alias FightFair.Db.Action, as: ActionSchema

  # @impl true
  def get_all() do
    ActionSchema
    |> Repo.all()
    |> Enum.map(&ActionSchema.to_domain(&1))
  end

  def get(action_id) do
    case Repo.get(ActionSchema, action_id) do
      %ActionSchema{} = action_schema -> {:ok, ActionSchema.to_domain(action_schema)}
      _ -> {:error, :not_found}
    end
  end

  @impl true
  def insert(%ActionDomain{} = action) do
    with {:ok, schema} <- ActionSchema.insert_changeset(action) |> Repo.insert() do
      {:ok, ActionSchema.to_domain(schema)}
    end
  end

  def update(%ActionDomain{id: action_id} = action) do
    with {:ok, schema} <- get(action_id),
         {:ok, schema} <- ActionSchema.update_changeset(schema, action) |> Repo.update() do
      {:ok, ActionSchema.to_domain(schema)}
    end
  end
end
