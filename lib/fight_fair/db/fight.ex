defmodule FightFair.Db.Fight do
  use FightFair.Db.Util
  use Ecto.Schema

  alias FightFair.Repo

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

  defp parse_users(%{ users: users }) do
    users
  end
  defp parse_users(_params) do
    []
  end

  defp parse_actions(%{ actions: actions }) do
    actions
  end
  defp parse_actions(_params) do
    []
  end

  def add_action(fight, action_name) do
    Ecto.build_assoc(fight, :actions, %FightFair.Db.Action{name: action_name})
    |> Repo.insert!()
  end

  def preload(changeset) do
    changeset
    |> Repo.preload(:users)
    |> Repo.preload(:actions)
  end
end
