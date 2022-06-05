defmodule FightFair.Db.Action do
  use FightFair.Db.Util
  use Ecto.Schema

  import Ecto.Changeset

  alias FightFair.Repo
  alias FightFair.Db.User
  alias FightFair.Action, as: ActionDomain

  schema "action" do
    field :name, FightFair.Adapter.Db.AtomType
    belongs_to :created_by, User

    timestamps()
  end

  def insert_changeset(%ActionDomain{} = action_domain) do
    attrs = Map.from_struct(action_domain)

    %__MODULE__{}
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def update_changeset(schema, %ActionDomain{} = action_domain) do
    attrs = Map.from_struct(action_domain)

    schema
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def changeset(params \\ %{}, action \\ %__MODULE__{}) do
    action
    |> cast(params, [:name])
    |> put_assoc(:created_by, params.created_by)
    |> validate_required([:name])
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
