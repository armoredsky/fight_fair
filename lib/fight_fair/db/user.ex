defmodule FightFair.Db.User do
  alias FightFair.Repo
  alias FightFair.Db.Util
  use Ecto.Schema

  schema "user" do
    field(:name, :string)
    field(:email, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:name, :email])
    |> Ecto.Changeset.validate_required([:name, :email])
  end

  def insert(params) do
    Repo.insert(__MODULE__.changeset(%__MODULE__{}, params))
    |> Util.handle_data_change()
  end

  def get_all() do
    __MODULE__
    |> Repo.all()
  end

  def get_by_id(user_id) do
    __MODULE__
    |> Repo.get_by!(id: user_id)
  end
end
