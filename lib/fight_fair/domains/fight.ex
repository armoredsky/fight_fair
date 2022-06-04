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

  def new(subject, created_by_id)
      when is_binary(subject) and is_integer(created_by_id) do

    fight = %__MODULE__{
      subject: subject,
      user_ids: [created_by_id],
      start_date: DateTime.utc_now()
    }

    add_action(fight, :start_fight, created_by_id)
  end
  def new(_,_), do: {:error, :invalid_arguments}
  def new(_), do: {:error, :missing_required_arguments}
  def new(), do: {:error, :missing_required_arguments}


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
