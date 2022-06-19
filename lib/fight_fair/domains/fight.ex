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

  def new(subject, %User{} = created_by, %User{} = partner)
      when is_binary(subject) do
    {:ok,
     %__MODULE__{
       subject: subject,
       users: [created_by, partner],
       start_date: DateTime.utc_now()
     }}
  end

  def new(_, _, _), do: {:error, :invalid_arguments}
end
