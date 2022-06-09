defmodule FightFair.Fight do
  alias FightFair.{Action, User}

  defstruct(
    id: nil,
    subject: nil,
    start_date: nil,
    end_date: nil,
    users: [],
    actions: []
  )
  @type id :: integer()
  @type subject :: String.t()
  @type t :: %__MODULE__{
          id: __MODULE__.id() | nil,
          subject: __MODULE__.subject(),
          start_date: DateTime.t(),
          end_date: DateTime.t(),
          users: list(User.t()),
          actions: list(Action.t())
        }

  def new(subject, %User{} = created_by)
      when is_binary(subject) do

    fight = %__MODULE__{
      subject: subject,
      users: [created_by],
      start_date: DateTime.utc_now()
    }

    add_action(fight, :start_fight, created_by)
  end
  def new(_,_), do: {:error, :invalid_arguments}

  def add_action(fight, action_name, created_by) do

    if Enum.member?(fight.users, created_by) do
      case Action.new(action_name, created_by) do
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
