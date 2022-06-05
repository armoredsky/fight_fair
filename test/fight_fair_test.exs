defmodule FightFairTest do
  use FightFair.RepoCase
  alias FightFair.Repo
  alias FightFair.Db.{Action, User}

  doctest FightFair

  @user %User{name: "michael", email: "eMMe@gmail.com"}
  @partner %User{name: "lara", email: "l@gmail.com"}
  @action %Action{name: :start_fight}

  test "start a fight" do
    user = Repo.insert!(@user)
    partner = Repo.insert!(@partner)
    subject = "dude, stop"

    fight = FightFair.start_fight(user.id, partner.id, subject)

    assert fight.id > 1

    [first_act | _t] = fight.actions
    assert first_act.name == @action.name
    assert first_act.created_by.name == @user.name
  end

  test "add a action to a fight" do
    new_action = :timeout

    fight = start_a_fight()
    [user, _] = fight.users

    fight = FightFair.add_action(user.id, fight.id, new_action)

    assert Enum.count(fight.actions) == 2

    [first_act | t] = fight.actions
    assert first_act.name == @action.name
    assert first_act.created_by.name == @user.name

    [second_act] = t
    assert second_act.name == new_action
    assert second_act.created_by.name == @user.name
  end

  defp start_a_fight do
    user = Repo.insert!(@user)
    partner = Repo.insert!(@partner)
    subject = "dude, stop"

    FightFair.start_fight(user.id, partner.id, subject)
  end
end
