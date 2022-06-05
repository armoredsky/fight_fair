defmodule FightFair.Application.UserService do
  @user_repo Application.compile_env(:fight_fair, :user_repo)

  # not something i reallly want, but you know
  def get_all() do
    users = @user_repo.get_all()
    users
  end

  def get(user_id) do
    {:ok, user} = @user_repo.get(user_id)
    user
  end

  # get partners/ maybe make that part of the user in the first place?
end
