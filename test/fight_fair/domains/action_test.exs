defmodule FightFair.ActionTest do
  use ExUnit.Case, async: true
  alias FightFair.Action

  describe "new/2" do
    test "create new Action" do
      name = :start_fight
      user_id = 1

      assert {:ok,
              %{
                created_by_id: ^user_id,
                name: ^name,
                created_at: datetime
              }}
              = Action.new(name, user_id)
    end

    test "invalid new Action" do
      assert {:error, :missing_required_arguments} = Action.new()
      assert {:error, :missing_required_arguments} = Action.new("name")

      assert {:error, :unknown_action_name} = Action.new(:do_a_little_dance, 1)
    end
  end
end
