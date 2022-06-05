defmodule FightFair.Db.User do
  use FightFair.Db.Util
  use Ecto.Schema
  import Ecto.Changeset

  alias FightFair.User, as: UserDomain
  alias FightFair.Db.Fight, as: FightSchema


  schema "user" do
    field(:name, :string)
    field(:email, :string)
    many_to_many(:fights, FightSchema, join_through: "fight_participants")

    timestamps()
  end

  def insert_changeset(%UserDomain{} = user_domain) do
    attrs = Map.from_struct(user_domain)

    %__MODULE__{}
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  def update_changeset(schema, %UserDomain{} = user_domain) do
    attrs = Map.from_struct(user_domain)

    schema
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here? probably
    struct(%UserDomain{}, attrs)
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

end
