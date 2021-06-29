defmodule FightFairTest do
  use FightFair.RepoCase
  alias FightFair.Repo
  alias FightFair.Db.{Action, Fight, User}

  doctest FightFair

  @user %User{name: "michael", email: "eMMe@gmail.com"}
  @partner %User{name: "lara", email: "l@gmail.com"}
  @action %Action{name: "started_fight"}


  test "start a fight" do
    user = Repo.insert!(@user)
    partner = Repo.insert!(@partner)
    subject = "dude, stop"

    fight = FightFair.start_fight(user.id, partner.id, subject)

    assert fight.id > 0
  end
end
