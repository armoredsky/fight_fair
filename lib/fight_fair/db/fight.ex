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
    user_ids = Enum.map(params.users, fn p -> %{id: p.id} end)
    action_ids = Enum.map(params.actions, fn a -> %{id: a.id} end)

    fight
    |> Ecto.Changeset.cast(params, [:subject])
    |> Ecto.Changeset.put_assoc(:users, user_ids)
    |> Ecto.Changeset.put_assoc(:actions, action_ids)
    |> Ecto.Changeset.validate_required([:subject])
  end

  def preload(changeset) do
    changeset
    |> Repo.preload(:users)
    |> Repo.preload(:actions)
  end
end
