defmodule FightFair.Db.Fight do
  use FightFair.Db.Util
  use Ecto.Schema

  alias FightFair.Repo

  schema "fight" do
    field(:subject, :string)
    belongs_to(:owner, FightFair.Db.User)
    belongs_to(:partner, FightFair.Db.User)
  end

  def changeset(params \\ %{}, fight \\ %__MODULE__{}) do
    fight
    |> Ecto.Changeset.cast(params, [:subject, :owner_id, :partner_id])
    |> Ecto.Changeset.validate_required([:subject, :owner_id, :partner_id])
  end

  def preload(changeset) do
    changeset
    |> Repo.preload(:owner)
    |> Repo.preload(:partner)
  end
end
