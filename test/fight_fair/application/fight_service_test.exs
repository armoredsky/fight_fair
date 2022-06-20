defmodule FightFair.Application.FightServiceTest do
  use FightFair.RepoCase
  doctest FightFair.Application.FightService

  alias FightFair.Application.FightService
  alias FightFair.User, as: UserDomain
  alias FightFair.Fight, as: FightDomain
  alias FightFair.Adapter.UserRepo

  @user %UserDomain{name: "michael", email: "m@gmail.com"}
  @partner %UserDomain{name: "lara", email: "l@gmail.com"}
  @subject "ain't gona take it"

  describe "start_fight" do
    test "user can start a fight" do
      assert {:ok, user} = UserRepo.insert(@user)
      assert {:ok, partner} = UserRepo.insert(@partner)

      assert {:ok,
              %FightDomain{
                id: id,
                subject: @subject,
                end_date: nil,
                users: [a_user, a_partner]
              }} = FightService.start_fight(@subject, user.id, partner.id)

      assert user.id == a_user.id
      assert partner.id == a_partner.id
      refute id == nil
    end
  end

  describe "get_all" do
    test "with existing user and fights returns all fights" do
      {:ok, user} = UserRepo.insert(@user)
      {:ok, partner} = UserRepo.insert(@partner)

      {:ok, %FightDomain{}} = FightService.start_fight(@subject, user.id, partner.id)

      {:ok, %FightDomain{}} = FightService.start_fight(@subject, user.id, partner.id)

      assert fights = FightService.get_all(user.id)
      assert Enum.count(fights) == 2
    end

    test "with existing user and no fights returns empty list" do
      {:ok, user} = UserRepo.insert(@user)

      assert fights = FightService.get_all(user.id)
      assert Enum.count(fights) == 0
    end
  end

  describe "add_action/3" do
    test "accepts an action_name, fight_id, and user_id and returns a fight with new action" do
      assert {:ok, user} = UserRepo.insert(@user)
      assert {:ok, partner} = UserRepo.insert(@partner)

      assert {:ok, %FightDomain{id: id}} = FightService.start_fight(@subject, user.id, partner.id)

      assert {:ok, %FightDomain{actions: actions}} = FightService.add_action(:foul, id, user.id)

      assert Enum.count(actions) == 1
    end
  end
end
