defmodule FightFair.Adapter.FightRepo do
  @behaviour FightFair.FightRepoBehaviour

  alias FightFair.Repo
  alias FightFair.Fight, as: FightDomain
  alias FightFair.Db.{User, Fight}

  @impl true
  def get_all(user_id) do
    User
    |> Repo.get!(user_id)
    |> Repo.preload(:fights)
    |> Map.get(:fights)
  end

  @impl true
  def get(fight_id) do
    case Repo.get(Fight, fight_id) do
      %Fight{} = schema ->
        schema =
          Repo.preload(schema, :users)
          |> Repo.preload(:actions)

        {:ok, Fight.to_domain(schema)}

      _ ->
        {:error, :not_found}
    end
  end

  @impl true
  def insert(%FightDomain{} = fight) do
    with {:ok, fight_schema} <- Fight.insert_changeset(fight) |> do_insert,
         fight_schema <- Repo.preload(fight_schema, :users) |> Repo.preload(:actions) do
      {:ok, Fight.to_domain(fight_schema)}
    end
  end

  def do_insert(changeset) do
    case Repo.insert(changeset) do
      {:ok, changeset} -> {:ok, changeset}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
