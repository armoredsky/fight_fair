defmodule FightFair.FightRepoBehaviour do
  alias FightFair.{Fight, User}

  @callback get_all(User.id()) :: [Fight.t()] | {:error, any()}
  @callback get(Fight.id()) :: {:ok, Fight.t()} | {:error, any()}
  @callback insert(Fight.t()) :: {:ok, Fight.t()} | {:error, any()}
end
