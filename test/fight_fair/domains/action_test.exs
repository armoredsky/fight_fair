defmodule FightFair.ActionTest do
  use ExUnit.Case, async: true
  alias FightFair.{Action, User}

  describe "new/2" do
    test "create new Action" do
      name = :start_fight
      {:ok, user} = User.new("name", "email")

      assert {:ok,
              %Action{
                created_by: ^user,
                name: ^name,
                created_at: datetime
              }}
              = Action.new(name, user)

      refute datetime == nil
    end

    test "invalid new Action" do
      assert {:error, :unknown_action_name} = Action.new(:do_a_little_dance, 1)
      assert {:error, :invalid_arguments} = Action.new(:timeout, 1)
    end
  end
end
