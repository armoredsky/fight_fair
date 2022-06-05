defmodule FightFair.Db.ActionTest do
  use FightFair.RepoCase
  alias FightFair.Db.Action
  doctest FightFair.Db.Action

  test "a Action has a name and email" do
    user = %Action{}
    assert user.name == nil
    assert user.created_by != nil
  end

  describe "changeset" do
    test "name is required" do
      action = %{name: nil, created_by: nil}
      changeset = Action.changeset(action)
      assert changeset.errors == [name: {"can't be blank", [validation: :required]}]
    end
  end

  describe "insert" do
    test "inserting a action returns a action with id" do
      user = %{id: 1, name: "ab", email: "abc"}
      action = %{name: "a", created_by: user}
      {:ok, action} = Action.insert(action)
      assert action.id >= 1
      assert action.created_by.id == 1
    end

    test "inserting an invalid Action returns the errors" do
      user = %{id: 1, name: "ab", email: "abc"}
      action = %{name: nil, created_by: user}
      {:error, errors} = Action.insert(action)
      assert errors == %{name: ["can't be blank"]}
    end
  end

  describe "get" do
    test "an Action" do
      user = %{id: 1, name: "ab", email: "abc"}
      action = %{name: "totes an action", created_by: user}
      {:ok, action} = Action.insert(action)

      fetched_action = Action.get_by_id(action.id)
      assert fetched_action.id == action.id
    end
  end
end
