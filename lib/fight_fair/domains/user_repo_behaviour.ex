defmodule FightFair.UserRepoBehaviour do
  alias FightFair.User

  @callback get(User.id()) :: {:ok, User.t()} | {:error, any()}
  @callback insert(User.t()) :: {:ok, User.t()} | {:error, any()}
  @callback update(User.t()) :: {:ok, User.t()} | {:error, any()}
end
