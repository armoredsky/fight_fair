defmodule FightFair.Db.User do
  use FightFair.Db.Util
  use Ecto.Schema

  alias FightFair.User, as: UserDomain

  schema "user" do
    field(:name, :string)
    field(:email, :string)
    many_to_many(:fights, FightFair.Db.Fight, join_through: "fight_participants")
    timestamps()
  end

  def changeset(params \\ %{}, user \\ %__MODULE__{}) do
    user
    |> Ecto.Changeset.cast(params, [:name, :email])
    |> Ecto.Changeset.validate_required([:name, :email])
  end

  def preload(changeset) do
    changeset
    |> FightFair.Repo.preload(:fights)
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here? probably
    struct(%UserDomain{}, attrs)
  end
end
