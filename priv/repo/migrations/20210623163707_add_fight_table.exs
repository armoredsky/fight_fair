defmodule FightFair.Repo.Migrations.AddFightTable do
  use Ecto.Migration

  def change do
    create table(:fight) do
      add :subject, :string
      timestamps()
    end

    create table(:action) do
      add :name, :string
      add :created_by, references(:user)
      add :fight_id, references(:fight)
      timestamps()
    end

    create table(:fight_participants) do
      add :fight_id, references(:fight)
      add :user_id, references(:user)
    end

    create unique_index(:fight_participants, [:fight_id, :user_id])
  end
end
