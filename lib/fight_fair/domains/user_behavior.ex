defmodule FightFair.UserBehavior do
  alias FightFair.User

  @doc """
  Create a new user
  """
  @callback new(String.t(), String.t()) :: {:ok, User.t()} | {:error, any()}
end
