defmodule FightFair.Adapter.FightRepo do
  @behaviour FightFair.FightRepoBehaviour

  alias FightFair.Repo
  alias FightFair.Action, as: ActionDomain
  alias FightFair.Fight, as: FightDomain
  alias FightFair.Db.{Action, Fight}

  @impl true
  def get_all(_user_id) do
    fights =
      Fight
      # get all where user_id matches
      |> Repo.all()
      |> Enum.map(&Fight.to_domain(&1))

    {:ok, fights}
  end

  @impl true
  def get(fight_id) do
    case Repo.get(Fight, fight_id) do
      %Fight{} = schema -> {:ok, Fight.to_domain(schema)}
      _ -> {:error, :not_found}
    end
  end

  @impl true
  def insert(%FightDomain{} = fight) do
    with {:ok, fight_schema} <- Fight.insert_changeset(fight) |> do_insert,
         fight_schema <- Repo.preload(fight_schema, :users) do
      Repo.all(FightFair.Db.User)
      {:ok, Fight.to_domain(fight_schema)}
    end
  end

  # @impl true
  # def add_action(%FightDomain{} = fight, %ActionDomain{} = action, user_id) do
  #   # how to update a fight
  # end

  def do_insert(changeset) do
    case Repo.insert(changeset) do
      {:ok, changeset} -> {:ok, changeset}
      {:error, changeset} -> {:error, changeset}
    end
  end
end

# create a fight
# add users to fight
# add actions to fight
# get fight
# return
