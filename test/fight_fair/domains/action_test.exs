defmodule FightFair.ActionTest do
  use ExUnit.Case, async: true
  alias FightFair.{Action}

  @created_by_id 1
  @fight_id 2

  describe "new/2" do
    test "create new Action" do
      name = :start_fight

      assert {:ok,
              %Action{
                name: ^name,
                created_at: datetime
              }} =
               Action.new(name, @created_by_id, @fight_id)

      refute datetime == nil
    end

    test "create new Action from string" do
      name = "start_fight"
      atom_name = :start_fight

      assert {:ok,
              %Action{
                name: ^atom_name,
                created_at: datetime
              }} =
               Action.new(name, @created_by_id, @fight_id)

      refute datetime == nil
    end
  end
end
