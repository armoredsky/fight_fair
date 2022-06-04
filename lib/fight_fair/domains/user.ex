defmodule FightFair.User do
  defstruct(id: nil, name: nil, email: nil, fight_ids: [])

  @type id :: integer()
  @type t :: %__MODULE__{
          id: __MODULE__.id() | nil,
          name: String.t(),
          email: String.t(),
          fight_ids: list(integer())
        }

  def new(name, email) when is_binary(name) and is_binary(email) do
    user = %__MODULE__{name: name, email: email}
    {:ok, user}
  end

  def new(_) do
    {:error, :missing_required_arguments}
  end
end
