defmodule FightFair.Db.Fight do
  use FightFair.Db.Util
  use Ecto.Schema

  alias FightFair.Repo
  alias FightFair.Fight, as: FightDomain

  schema "fight" do
    field(:subject, :string)
    many_to_many(:users, FightFair.Db.User, join_through: "fight_participants")
    many_to_many(:actions, FightFair.Db.Action, join_through: "fight_actions")

    timestamps()
  end

  def changeset(params \\ %{}, fight \\ %__MODULE__{}) do
    fight
    |> Repo.preload([:users, :actions])
    |> Ecto.Changeset.cast(params, [:subject])
    |> Ecto.Changeset.put_assoc(:users, parse_users(params))
    |> Ecto.Changeset.put_assoc(:actions, parse_actions(params))
    |> Ecto.Changeset.validate_required([:subject])
  end

  def add_action_changeset(fight, action) do
    fight
    |> Repo.preload([:users, :actions])
    |> Ecto.Changeset.cast(%{}, [:subject])
    |> Ecto.Changeset.put_assoc(:actions, fight.actions ++ [action])
  end

  defp parse_users(%{users: users}) do
    users
  end

  defp parse_users(_params) do
    []
  end

  defp parse_actions(%{actions: actions}) do
    actions
  end

  defp parse_actions(_params) do
    []
  end

  def add_action(fight, action) do
    add_action_changeset(fight, action)
    |> Repo.update!()
  end

  def preload(changeset) do
    changeset
    |> Repo.preload(:users)
    |> Repo.preload(:actions)
    |> Repo.preload(actions: :created_by)
  end


  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here? probably
    struct(%FightDomain{}, attrs)
  end
end
