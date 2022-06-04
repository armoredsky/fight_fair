defmodule FightFair.Fight do
  alias FightFair.{Action, User}

  defstruct(
    id: nil,
    subject: nil,
    start_date: nil,
    end_date: nil,
    user_ids: [],
    actions: []
  )

  @type t :: %__MODULE__{
          id: integer() | nil,
          subject: String.t(),
          start_date: Date.t(),
          end_date: Date.t(),
          user_ids: list(User.id()),
          actions: list(Action.t())
        }

  def add_action(fight, action_name, created_by_id) do
    if Enum.member?(fight.user_ids, created_by_id) do
      case Action.new(action_name, created_by_id) do
        {:ok, action} ->
          fight = %__MODULE__{fight | actions: [action | fight.actions]}
          {:ok, fight}

        {:error, error} ->
          {:error, error}
      end
    else
      {:error, :uninvited_user_action}
    end
  end
end
