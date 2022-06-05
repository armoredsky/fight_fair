defmodule FightFair do
  alias FightFair.Db.{Action, Fight, User}

  def migrate do
    FightFair.Release.migrate()
  end

  def start_fight(user_id, partner_id, subject) do
    user = User.get_by_id(user_id)
    partner = User.get_by_id(partner_id)
    actions = %Action{name: :start_fight, created_by: user}

    {:ok, fight} =
      Fight.insert(%{
        users: [user, partner],
        subject: subject,
        actions: [actions]
      })

    fight
  end

  def add_action(user_id, fight_id, action_name) do
    user = User.get_by_id(user_id)
    fight = Fight.get_by_id(fight_id)

    {:ok, action} = Action.insert(%{name: action_name, created_by: user})
    Fight.add_action(fight, action)
  end
end
