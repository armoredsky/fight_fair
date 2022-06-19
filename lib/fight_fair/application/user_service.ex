defmodule FightFair.Application.UserService do
  alias FightFair.User, as: UserDomain

  @user_repo Application.compile_env(:fight_fair, :user_repo)

  # not something i reallly want, but you know
  def get_all() do
    users = @user_repo.get_all()
    users
  end

  def get(user_id) do
    @user_repo.get(user_id)
  end

  def create(name, email) do
    with {:ok, user} <- UserDomain.new(name, email),
         {:ok, user} <- @user_repo.insert(user) do
      {:ok, user}
    end
  end
end
