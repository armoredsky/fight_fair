defmodule FightFair.Action do
  alias FightFair.User
  defstruct(name: nil, created_by_id: nil, created_at: nil)

  @action_names [:start_fight, :invite_partner, :end_fight, :timeout, :foul, :out_of_bounds]

  @type name :: Atom.t()
  @type t :: %__MODULE__{
          name: __MODULE__.name(),
          created_by_id: User.id(),
          created_at: DateTime.t()
        }

  def new(action_name, _) when action_name not in @action_names,
    do: {:error, :unknown_action_name}

  def new(action_name, created_by_id) do
    {:ok,
     %__MODULE__{
       name: action_name,
       created_by_id: created_by_id,
       created_at: DateTime.utc_now()
     }}
  end

  def new(_) do
    {:error, :invalid_arguments}
  end
end
