defmodule FightFair.Application.FightServiceTest do
  use FightFair.RepoCase
  doctest FightFair.Application.FightService

  alias FightFair.Application.FightService
  alias FightFair.User, as: UserDomain
  alias FightFair.Fight, as: FightDomain
  alias FightFair.Adapter.UserRepo

  @user %UserDomain{name: "michael", email: "m@gmail.com"}
  @subject "ain't gona take it"

  describe "start_fight" do
    test "start_fight" do
      assert {:ok, user} = UserRepo.insert(@user)

      assert {:ok,
              %FightDomain{
                id: id,
                subject: @subject,
                end_date: nil
              }} = FightService.start_fight(@subject, user.id)
    end
  end

  describe "get_all" do
    test "get_all" do
      {:ok, user} = UserRepo.insert(@user)
      {:ok, %FightDomain{id: first_fight_id}} = FightService.start_fight(@subject, user.id)
      {:ok, %FightDomain{id: second_fight_id}} = FightService.start_fight(@subject, user.id)

      assert {:ok, fights} = FightService.get_all(user.id)
      assert Enum.count(fights) == 2
    end
  end

  describe "get" do
    test "get" do
      {:ok, user} = UserRepo.insert(@user)
      {:ok, %FightDomain{id: fight_id}} = FightService.start_fight(@subject, user.id)
      assert {:ok, %FightDomain{}} = FightService.get(fight_id)
    end
  end

  describe "add_action" do
    test "add_action" do
      assert 1 == 2
    end
  end
end
