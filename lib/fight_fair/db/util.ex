defmodule FightFair.Db.Util do
  alias FightFair.Repo

  defmacro __using__(_) do
    quote do
      def get_all() do
        __MODULE__
        |> Repo.all()
        |> preload()
      end

      def get_by_id(id) do
        __MODULE__
        |> Repo.get_by!(id: id)
        |> preload()
      end

      def insert(params) do
        changeset(params)
        |> Repo.insert()
        |> DbUtilities.handle_data_change()
      end
    end
  end
end

defmodule DbUtilities do
  def traverse_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def handle_data_change({:ok, domain}), do: {:ok, domain}
  def handle_data_change({:error, changeset}), do: {:error, traverse_errors(changeset)}
end
