defmodule FightFair.Adapter.FightRepo do
  @behaviour FightFair.FightBehaviour

  import Ecto.Query

  alias FightFair.Repo
  alias FightFair.Fight, as: FightDomain
  alias FightFair.Db.Fight, as: FightSchema

  # @impl true
  def get_all() do
    FightSchema
    |> Repo.all()
    |> Enum.map(&FightSchema.to_domain(&1))
  end

  def get(fight_id) do
    case Repo.get(FightSchema, fight_id) do
      %FightSchema{} = fight_schema -> {:ok, fight_schema}
      _ -> {:error, :not_found}
    end
  end

  def insert(%FightDomain{} = fight) do
    with {:ok, schema} <- FightSchema.insert_changeset(fight) |> Repo.insert() do
      {:ok, FightSchema.to_domain(schema)}
    end
  end

  def update(%FightDomain{id: fight_id} = fight) do
    with {:ok, schema} <- get(fight_id),
         {:ok, schema} <- FightSchema.update_changeset(schema, fight) |> Repo.update() do
      {:ok, FightSchema.to_domain(schema)}
    end
  end
end
