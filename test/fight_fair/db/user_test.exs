defmodule FightFair.Db.UserTest do
  use FightFair.RepoCase
  alias FightFair.Db.User
  doctest FightFair.Db.User

  test "a User has a name" do
    user = %User{}
    assert user.name == nil
  end

  describe "changeset" do
    test "name is required" do
      user = %User{name: nil, email: "email"}
      changeset = User.changeset(user)
      assert changeset.errors == [name: {"can't be blank", [validation: :required]}]
    end

    test "email is required" do
      user = %User{name: "name", email: nil}
      changeset = User.changeset(user)
      assert changeset.errors == [email: {"can't be blank", [validation: :required]}]
    end
  end

  describe "insert" do
    test "inserting a User returns a User with id" do
      user = %{name: "a", email: "email@gmail.com"}
      {:ok, user} = User.insert(user)
      assert user.id >= 1
    end

    test "inserting an invalid User returns the errors" do
      user = %{name: "", email: "email"}
      {:error, errors} = User.insert(user)
      assert errors == %{name: ["can't be blank"]}
    end
  end

  describe "get" do
    test "a user" do
      {:ok, user} = User.insert(%{name: "a", email: "email@gmail.com"})

      fetched_user = User.get_by_id(user.id)
      assert fetched_user.id == user.id
    end
  end
end
