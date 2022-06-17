defmodule FightFair.Db.Fight do
  use Ecto.Schema
  import Ecto.Changeset

  alias FightFair.Fight, as: FightDomain
  alias FightFair.Db.{User, FightParticipants}

  schema "fight" do
    field(:subject, :string)
    many_to_many(:users, User, join_through: FightParticipants, on_delete: :nothing, on_replace: :delete)
    # has_many(:actions, Action)
    timestamps()
  end

  def insert_changeset(%FightDomain{} = fight_domain) do
    attrs = Map.from_struct(fight_domain)
    user_ids = Enum.map(attrs.users, fn u -> u.id end)
    IO.inspect(user_ids)

    %__MODULE__{}
    |> cast(attrs, [:subject])
    |> cast_assoc(:users)
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here?
    # todo: to_domain on the other schemas as well. Map.from_struct only works at the top level
    struct(%FightDomain{}, attrs)
  end
end
