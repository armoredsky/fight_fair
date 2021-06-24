defmodule FightFair.Db.Action do
  use FightFair.Db.Util
  use Ecto.Schema

  schema "action" do
    field :name, :string
    timestamps()
  end

  def changeset(params \\ %{}, action \\ %__MODULE__{}) do
    action
    |> Ecto.Changeset.cast(params, [:name])
  end

  def preload(changeset) do
    changeset
  end
end
