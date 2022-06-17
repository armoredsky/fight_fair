defmodule FightFair.Db.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias FightFair.User, as: UserDomain
  alias FightFair.Db.{Fight, FightParticipants}

  schema "user" do
    field(:name, :string)
    field(:email, :string)
    many_to_many(:fights, Fight, join_through: FightParticipants, on_replace: :delete)
    # has_many(:actions, Action)
    timestamps()
  end

  def changeset(schema, %UserDomain{} = user_domain) do
    attrs = Map.from_struct(user_domain)

    schema
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> IO.inspect(label: "user domain in changeset/2")
  end

  def insert_changeset(%UserDomain{} = user_domain) do
    attrs = Map.from_struct(user_domain)

    %__MODULE__{}
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)

    # do i need more logic here? probably

    struct(%UserDomain{}, attrs)
  end
end
