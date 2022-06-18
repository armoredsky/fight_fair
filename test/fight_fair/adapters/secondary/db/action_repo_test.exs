defmodule FightFair.Adapter.ActionRepoTest do
  use FightFair.RepoCase
  alias FightFair.Adapter.{ActionRepo, FightRepo, UserRepo}
  alias FightFair.Action, as: ActionDomain
  alias FightFair.Fight, as: FightDomain
  alias FightFair.User, as: UserDomain
  doctest FightFair.Adapter.ActionRepo

  @user %UserDomain{name: "michael", email: "m@gmail.com"}
  @partner %UserDomain{name: "lara", email: "l@gmail.com"}
  @subject "ain't gona take it"

  describe "insert" do
    test "an action returns an action with id" do
      assert {:ok, user} = UserRepo.insert(@user)
      assert {:ok, partner} = UserRepo.insert(@partner)
      assert {:ok, fight} = FightDomain.new(@subject, user, partner)
      assert {:ok, fight} = FightRepo.insert(fight)

      name = :start_fight
      {:ok, action} = ActionDomain.new(name, user.id, fight.id)

      assert {:ok,
              %ActionDomain{
                id: id,
                name: ^name
              }} = ActionRepo.insert(action)

      refute id == nil
    end
  end
end
