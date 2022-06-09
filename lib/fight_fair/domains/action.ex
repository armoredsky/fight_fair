defmodule FightFair.Action do
  alias FightFair.User
  defstruct(id: nil, name: nil, created_by: nil, created_at: nil)

  @action_names [:start_fight, :end_fight, :timeout, :foul, :out_of_bounds]

  @type name :: Atom.t()
  @type id :: integer()
  @type t :: %__MODULE__{
          id: __MODULE__.id() | nil,
          name: __MODULE__.name(),
          created_by: User.t(),
          created_at: DateTime.t()
        }

  def new(action_name, %User{} = created_by) when action_name in @action_names do
    {:ok,
     %__MODULE__{
       name: action_name,
       created_by: created_by,
       created_at: DateTime.utc_now()
     }}
  end

  def new(action_name, _) when action_name not in @action_names,
    do: {:error, :unknown_action_name}

  def new(_, _), do: {:error, :invalid_arguments}
end
