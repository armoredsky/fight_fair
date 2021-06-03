defmodule FightFair.Db.User do
  use FightFair.Db.Util
  use Ecto.Schema

  schema "user" do
    field(:name, :string)
    field(:email, :string)
  end

  def changeset(params \\ %{}, user \\ %__MODULE__{}) do
    user
    |> Ecto.Changeset.cast(params, [:name, :email])
    |> Ecto.Changeset.validate_required([:name, :email])
  end

  def preload(changeset) do
    changeset
  end
end
