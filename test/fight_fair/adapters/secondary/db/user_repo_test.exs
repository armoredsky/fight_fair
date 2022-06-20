defmodule FightFair.Adapter.UserRepoTest do
  use FightFair.RepoCase
  alias FightFair.Adapter.UserRepo
  alias FightFair.User, as: UserDomain
  doctest FightFair.Adapter.UserRepo

  describe "insert" do
    test "inserting a User returns a User with id" do
      name = "a_name"
      email = "a_name@gmail.com"
      user = %UserDomain{name: name, email: email}

      assert {:ok,
              %UserDomain{
                id: id,
                name: ^name,
                email: ^email
              }} = UserRepo.insert(user)

      refute id == nil
    end

    test "inserting User without a name fails test" do
      user = %UserDomain{name: "", email: "email"}
      assert {:error, %Ecto.Changeset{}} = UserRepo.insert(user)
    end

    test "inserting User without an email fails test" do
      user = %UserDomain{name: "name", email: ""}
      assert {:error, %Ecto.Changeset{}} = UserRepo.insert(user)
    end
  end

  describe "get" do
    test "a user" do
      {:ok, user} = UserRepo.insert(%UserDomain{name: "a", email: "email@gmail.com"})

      assert {:ok, %UserDomain{id: id, name: name, email: email}} = UserRepo.get(user.id)

      assert id == user.id
      assert name == user.name
      assert email == user.email
    end

    # some failure test would be nice
  end
end
