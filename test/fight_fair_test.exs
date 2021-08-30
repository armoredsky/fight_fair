defmodule FightFairTest do
  use FightFair.RepoCase
  alias FightFair.Repo
  alias FightFair.Db.{Action, User}

  doctest FightFair

  @user %User{name: "michael", email: "eMMe@gmail.com"}
  @partner %User{name: "lara", email: "l@gmail.com"}
  @action %Action{name: "started"}

  test "start a fight" do
    user = Repo.insert!(@user)
    partner = Repo.insert!(@partner)
    subject = "dude, stop"

    fight = FightFair.start_fight(user.id, partner.id, subject)

    assert fight.id > 1

    [first_act | _t] = fight.actions
    assert first_act.name == @action.name
  end

  test "add a action to a fight" do
    new_action = "Timeout: 5mins"

    fight =
      start_a_fight()
      |> FightFair.add_action(new_action)

    assert Enum.count(fight.actions) == 2

    [first_act | t] = fight.actions
    assert first_act.name == @action.name
    [second_act] = t
    assert second_act.name == new_action
  end

  defp start_a_fight do
    user = Repo.insert!(@user)
    partner = Repo.insert!(@partner)
    subject = "dude, stop"

    FightFair.start_fight(user.id, partner.id, subject)
  end
end
