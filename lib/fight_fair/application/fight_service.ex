defmodule FightFair.Application.FightService do
  @fight_repo Application.compile_env(:fight_fair, :fight_repo)
  alias FightFair.{Action, Fight}

  def get_all(user_id) do
    fights = @fight_repo.get_all(user_id)
    fights
  end

  def get(fight_id) do
    {:ok, fight} = @fight_repo.get(fight_id)
    fight
  end

  def start_fight(subject, user_id) do
    with {:ok, fight} <- Fight.new(subject, user_id),
         {:ok, fight} <- @fight_repo.insert(fight) do
      fight
    end
  end

  def add_action(fight_id, action_name, user_id) do
    with {:ok, fight} <- @fight_repo.get(fight_id),
         {:ok, action} <- Action.new(action_name, user_id),
         {:ok, fight} <- @fight_repo.add_action(fight, action, user_id) do
      fight
    end
  end
end
