defmodule FightFair.Db.Util do
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
