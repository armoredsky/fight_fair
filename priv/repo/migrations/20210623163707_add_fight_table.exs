defmodule FightFair.Repo.Migrations.AddFightTable do
  use Ecto.Migration

  def change do
    create table(:fight) do
      add :subject, :string
      add :owner_id, references(:user)
      add :partner_id, references(:user)
    end
  end
end
