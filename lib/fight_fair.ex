defmodule FightFair do
  alias FightFair.Db.{Action, Fight, User}

  def migrate do
    FightFair.Release.migrate()
  end

  def start_fight(user_id, partner_id, subject) do
    user = User.get_by_id(user_id)
    partner = User.get_by_id(partner_id)
    actions = %Action{name: "started"}

    {:ok, fight} =
      Fight.insert(%{
        users: [user, partner],
        subject: subject,
        actions: [actions]
      })

    fight
  end

  def add_action(fight, action_name) do
    {:ok, action} = Action.insert(%{name: action_name})
    Fight.add_action(fight, action)
  end
end
