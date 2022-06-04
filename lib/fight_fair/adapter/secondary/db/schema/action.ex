defmodule FightFair.Db.Action do
  use FightFair.Db.Util
  use Ecto.Schema
  alias FightFair.Repo
  alias FightFair.Db.User
  alias FightFair.Action, as: ActionDomain

  schema "action" do
    field :name, :string
    belongs_to :created_by, User

    timestamps()
  end

  def changeset(params \\ %{}, action \\ %__MODULE__{}) do
    action
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.put_assoc(:created_by, params.created_by)
    |> Ecto.Changeset.validate_required([:name])
  end

  def preload(changeset) do
    changeset
    |> Repo.preload(:created_by)
  end


  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    # do i need more logic here? probably
    struct(%ActionDomain{}, attrs)
  end
end
