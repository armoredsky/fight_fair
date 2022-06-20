defmodule FightFair.Application.FightService do
  @action_repo Application.compile_env(:fight_fair, :action_repo)
  @fight_repo Application.compile_env(:fight_fair, :fight_repo)
  @user_repo Application.compile_env(:fight_fair, :user_repo)
  alias FightFair.{Action, Fight}

  def get_all(user_id) do
    @fight_repo.get_all(user_id)
  end

  def get(fight_id) do
    @fight_repo.get(fight_id)
  end

  def start_fight(subject, user_id, partner_id) do
    with {:ok, user} <- @user_repo.get(user_id),
         {:ok, partner} <- @user_repo.get(partner_id),
         {:ok, fight} <- Fight.new(subject, user, partner),
         {:ok, fight} <- @fight_repo.insert(fight) do
      {:ok, fight}
    end
  end

  def add_action(action_name, fight_id, user_id) do
    with {:ok, action} <- Action.new(action_name, user_id, fight_id),
         {:ok, _action} <- @action_repo.insert(action),
         {:ok, fight} <- @fight_repo.get(fight_id) do
      {:ok, fight}
    end
  end
end
