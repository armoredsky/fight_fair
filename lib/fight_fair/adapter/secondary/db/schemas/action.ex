defmodule FightFair.Db.Action do
  use Ecto.Schema

  import Ecto.Changeset

  alias FightFair.Action, as: ActionDomain
  alias FightFair.Db.{AtomType, Fight, User}

  schema "action" do
    field(:name, AtomType)
    belongs_to(:created_by, User)
    belongs_to(:fight, Fight)
    timestamps()
  end

  def insert_changeset(%ActionDomain{} = action_domain) do
    attrs = Map.from_struct(action_domain)

    %__MODULE__{}
    |> cast(attrs, [:name])
    |> put_assoc(:created_by, User.get_or_insert(attrs.created_by))
    |> put_assoc(:fight, Fight.get(attrs.fight))
    |> validate_required([:name])
  end

  def changeset(schema, %ActionDomain{} = action_domain) do
    attrs = Map.from_struct(action_domain)

    IO.inspect(action_domain, label: "action domain in changeset/2")

    schema
    |> cast(attrs, [:name])
    |> cast_assoc(:created_by, attrs.created_by)
    |> validate_required([:name])
  end

  def update_changeset(schema, %ActionDomain{} = action_domain) do
    attrs = Map.from_struct(action_domain)

    schema
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def to_domain(%__MODULE__{} = schema) do
    attrs = Map.from_struct(schema)
    attrs = Map.put(attrs, :created_at, attrs.inserted_at)
    # do i need more logic here? probably
    struct(%ActionDomain{}, attrs)
  end
end
