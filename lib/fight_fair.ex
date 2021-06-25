defmodule FightFair do
  alias FightFair.Db.{Fight, User}

  def migrate do
    FightFair.Release.migrate()
  end

  def start_fight(user_id, partner_id, subject) do
    user = User.get_by_id(user_id)
    partner = User.get_by_id(partner_id)

    {:ok, fight} =
      Fight.insert(%{
        users: [user, partner],
        subject: subject
      })

    fight
  end
end
