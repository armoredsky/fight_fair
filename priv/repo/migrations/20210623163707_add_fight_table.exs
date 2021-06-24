defmodule FightFair.Repo.Migrations.AddFightTable do
  use Ecto.Migration

  def change do
    create table(:fight) do
      add :subject, :string
      timestamps()
    end

    create table(:action) do
      add :name, :string
      timestamps()
    end

    create table(:fight_participants, primary_key: false) do
      add :fight_id, references(:fight)
      add :user_id, references(:user)
    end

    create table(:fight_actions, primary_key: false) do
      add :fight_id, references(:fight)
      add :action_id, references(:action)
    end
  end
end
