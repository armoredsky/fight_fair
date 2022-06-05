defmodule FightFair.FightRepoBehaviour do
  alias FightFair.{Action, Fight, User}

  @callback get_all(User.id()) :: [Fight.t()] | {:error, any()}
  @callback get(Fight.id()) :: {:ok, Fight.t()} | {:error, any()}
  @callback insert(Fight.t()) :: {:ok, Fight.t()} | {:error, any()}
  @callback add_action(Fight.t(), Action.t(), User.id()) :: {:ok, Fight.t()} | {:error, any()}
end
