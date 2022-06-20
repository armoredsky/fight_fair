defmodule FightFair.Application.UserServiceTest do
  use FightFair.RepoCase
  doctest FightFair.Application.UserService

  alias FightFair.Application.UserService
  alias FightFair.User, as: UserDomain
  alias FightFair.Adapter.UserRepo

  @user %UserDomain{name: "michael", email: "m@gmail.com"}
  @partner %UserDomain{name: "lara", email: "l@gmail.com"}

  describe "get/1" do
    test "returns user by id" do
      {:ok, user} = UserRepo.insert(@user)

      assert {:ok, %UserDomain{id: id, name: name, email: email}} = UserService.get(user.id)
      refute id == nil
      assert @user.name == name
      assert @user.email == email
    end

    test "returns :error with invalid id" do
      assert {:error, :not_found} = UserService.get(1)
    end
  end

  describe "get_all/0" do
    test "with no exisiting users gives empty list" do
      assert [] == UserService.get_all()
    end

    test "with existing users returns list" do
      {:ok, user} = UserRepo.insert(@user)
      assert [^user] = UserService.get_all()

      {:ok, partner} = UserRepo.insert(@partner)
      assert [^user, ^partner] = UserService.get_all()
    end
  end

  describe "create/2" do
    test "accepts email and name" do
      name = "mds"
      email = "email@gmail.com"

      assert {:ok, %UserDomain{id: id, name: ^name, email: ^email}} =
               UserService.create(name, email)

      refute id == nil
    end
  end
end
