defmodule FightFair.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :email, :string
      timestamps()
    end

    create unique_index(:user, [:email])
  end
end
