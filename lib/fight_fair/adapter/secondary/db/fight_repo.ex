defmodule FightFair.Adapter.FightRepo do
  @behaviour FightFair.FightRepoBehaviour

  alias FightFair.Repo
  alias FightFair.Action, as: ActionDomain
  alias FightFair.Fight, as: FightDomain
  alias FightFair.Db.Fight, as: FightSchema

  @impl true
  def get_all(_user_id) do
    FightSchema
    # get all where user_id matches
    |> Repo.all()
    |> Enum.map(&FightSchema.to_domain(&1))
  end

  @impl true
  def get(fight_id) do
    case Repo.get(FightSchema, fight_id) do
      %FightSchema{} = schema -> {:ok, FightSchema.to_domain(schema)}
      _ -> {:error, :not_found}
    end
  end

  @impl true
  def insert(%FightDomain{} = fight) do
    with {:ok, schema} <- FightSchema.insert_changeset(fight) |> Repo.insert() do
      {:ok, FightSchema.to_domain(schema)}
    end
  end

  @impl true
  def add_action(%FightDomain{} = fight, %ActionDomain{} = action, user_id) do
    # how to update a fight
  end
end
