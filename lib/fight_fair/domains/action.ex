defmodule FightFair.Action do
  alias FightFair.{Fight, User}

  defstruct(
    id: nil,
    name: nil,
    fight: nil,
    created_by: nil,
    created_at: nil
  )

  @action_names [:start_fight, :end_fight, :timeout, :foul, :out_of_bounds]

  @type name :: Atom.t()
  @type id :: integer()
  @type t :: %__MODULE__{
          id: __MODULE__.id() | nil,
          name: __MODULE__.name(),
          fight: Fight.t(),
          created_by: User.t(),
          created_at: DateTime.t()
        }

  def new(action_name, u_id, f_id) when is_binary(action_name),
    do: new(String.to_atom(action_name), u_id, f_id)

  def new(action_name, created_by_id, fight) when is_integer(created_by_id),
    do: new(action_name, %User{id: created_by_id}, fight)

  def new(action_name, created_by, fight_id) when is_integer(fight_id),
    do: new(action_name, created_by, %Fight{id: fight_id})

  def new(action_name, _, _) when action_name not in @action_names,
    do: {:error, :invalid_action_name}

  def new(action_name, created_by, fight) do
    {:ok,
     %__MODULE__{
       name: action_name,
       created_by: created_by,
       fight: fight,
       created_at: DateTime.utc_now()
     }}
  end
end
