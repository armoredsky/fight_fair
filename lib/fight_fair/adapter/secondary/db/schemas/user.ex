defmodule FightFair.Db.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias FightFair.Repo
  alias FightFair.User, as: UserDomain
  alias FightFair.Db.Fight

  schema "user" do
    field(:name, :string)
    field(:email, :string)
    many_to_many(:fights, Fight, join_through: "fight_participants", on_replace: :delete)
    # has_many(:actions, Action)
    timestamps()
  end

  def changeset(schema, %UserDomain{} = user_domain) do
    attrs = Map.from_struct(user_domain)

    schema
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  def insert_changeset(%UserDomain{} = user_domain) do
    attrs = Map.from_struct(user_domain)

    %__MODULE__{}
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  def get_or_insert(%UserDomain{email: email} = user_domain) do
    case Repo.get_by(__MODULE__, email: email) do
      nil -> Repo.insert!(insert_changeset(user_domain))
      user -> user
    end
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)

    # do i need more logic here? probably

    struct(%UserDomain{}, attrs)
  end
end
