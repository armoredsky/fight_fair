defmodule FightFair.Db.FightParticipants do
  use Ecto.Schema
  import Ecto.Changeset
  alias FightFair.Db.{Fight, User}

  schema "fight_participants" do
    belongs_to(:user, User)
    belongs_to(:fight, Fight)
  end

  def changeset(schema, attrs) do
    IO.inspect(attrs, label: "fight participants changeset")

    schema
    |> cast(attrs, [:user_id, :fight_id])
    |> validate_required([:user_id, :fight_id])
    |> unique_constraint([:user_id, :fight_id])
  end
end
