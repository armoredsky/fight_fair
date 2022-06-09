defmodule FightFair.Db.Fight do
  use Ecto.Schema
  import Ecto.Changeset

  alias FightFair.Repo
  alias FightFair.Fight, as: FightDomain

  schema "fight" do
    field(:subject, :string)
    many_to_many(:users, FightFair.Db.User, join_through: "fight_participants")
    many_to_many(:actions, FightFair.Db.Action, join_through: "fight_actions")

    timestamps()
  end

  def insert_changeset(%FightDomain{} = fight_domain) do
    attrs = Map.from_struct(fight_domain)

    %__MODULE__{}
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
  end

  def update_changeset(schema, %FightDomain{} = fight_domain) do
    attrs = Map.from_struct(fight_domain)

    schema
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
  end

  def add_action_changeset(fight, action) do
    fight
    |> Repo.preload([:users, :actions])
    |> Ecto.Changeset.cast(%{}, [:subject])
    |> Ecto.Changeset.put_assoc(:actions, fight.actions ++ [action])
  end

  def add_action(fight, action) do
    add_action_changeset(fight, action)
    |> Repo.update!()
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here?
    # todo: to_domain on the other schemas as well. Map.from_struct only works at the top level
    struct(%FightDomain{}, attrs)
  end
end
