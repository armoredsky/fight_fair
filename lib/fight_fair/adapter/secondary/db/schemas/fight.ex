defmodule FightFair.Db.Fight do
  use Ecto.Schema
  import Ecto.Changeset

  alias FightFair.Fight, as: FightDomain
  alias FightFair.Repo
  alias FightFair.Db.{Action, User}

  schema "fight" do
    field(:subject, :string)
    many_to_many(:users, User, join_through: "fight_participants", on_replace: :delete)
    has_many(:actions, Action)
    timestamps()
  end

  def insert_changeset(%FightDomain{} = fight_domain) do
    attrs = Map.from_struct(fight_domain)

    %__MODULE__{}
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
    |> put_assoc(:users, parse_users(attrs.users))
  end

  def parse_users(users) do
    Enum.map(users, fn u -> User.get_or_insert(u) end)
  end

  def get(%{id: id}) when is_integer(id) do
    Repo.get!(__MODULE__, id)
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here?
    # todo: to_domain on the other schemas as well. Map.from_struct only works at the top level
    struct(%FightDomain{}, attrs)
  end
end
