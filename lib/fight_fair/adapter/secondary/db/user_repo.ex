defmodule FightFair.Adapter.UserRepo do
  @behaviour FightFair.UserRepoBehaviour

  alias FightFair.Repo
  alias FightFair.User, as: UserDomain
  alias FightFair.Db.User, as: UserSchema

  # @impl true
  def get_all() do
    UserSchema
    |> Repo.all()
    |> Enum.map(&UserSchema.to_domain(&1))
  end

  @impl true
  def get(user_id) do
    case Repo.get(UserSchema, user_id) do
      %UserSchema{} = user_schema -> {:ok, UserSchema.to_domain(user_schema)}
      _ -> {:error, :not_found}
    end
  end

  @impl true
  def insert(%UserDomain{} = user) do
    with {:ok, schema} <- UserSchema.insert_changeset(user) |> Repo.insert() do
      {:ok, UserSchema.to_domain(schema)}
    end
  end

  @impl true
  def update(%UserDomain{id: user_id} = user) do
    with {:ok, schema} <- get(user_id),
         {:ok, schema} <- UserSchema.update_changeset(schema, user) |> Repo.update() do
      {:ok, UserSchema.to_domain(schema)}
    end
  end
end
