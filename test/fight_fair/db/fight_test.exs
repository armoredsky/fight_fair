defmodule FightFair.Db.FightTest do
  use FightFair.RepoCase
  alias FightFair.Db.{Action, Fight, User}
  doctest FightFair.Db.Fight

  @owner %User{name: "michael", email: "eMMe@gmail.com"}
  @partner %User{name: "lara", email: "l@gmail.com"}
  @action %Action{name: "started_fight"}

  test "a fight has a subject, owner, and partner" do
    fight = %Fight{}
    assert fight.subject == nil
    assert fight.users != nil
    assert fight.actions != nil
  end

  describe "changeset" do
    test "subject is required" do
      fight = %{subject: nil, users: [@owner], actions: []}
      changeset = Fight.changeset(fight)
      assert changeset.errors == [subject: {"can't be blank", [validation: :required]}]
    end
  end

  describe "insert" do
    test "inserting a fight returns a fight with id" do
      fight = %{subject: "dude, stop", users: [@owner, @partner], actions: [@action]}

      {:ok, fight} = Fight.insert(fight)

      assert fight.id >= 1
    end

    test "inserts with no actions" do
      fight = %{subject: "dude, stop", users: [@owner, @partner], actions: []}

      {:ok, fight} = Fight.insert(fight)

      assert fight.id >= 1
    end

    test "inserts with no users" do
      fight = %{subject: "dude, stop", users: [], actions: [@action]}

      {:ok, fight} = Fight.insert(fight)

      assert fight.id >= 1
    end

    test "inserts with no users or actions" do
      fight = %{subject: "dude, stop", users: [], actions: []}

      {:ok, fight} = Fight.insert(fight)

      assert fight.id >= 1
    end

    test "inserts with already defined users" do
      already_defined_user = Repo.insert!(@owner)
      fight = %{subject: "dude, stop", users: [already_defined_user], actions: []}

      {:ok, fight} = Fight.insert(fight)

      assert fight.id >= 1
    end


    # test "inserting an invalid fight returns the errors" do
    #   owner = Repo.insert!(@owner)
    #   partner = Repo.insert!(@partner)
    #   fight = %{subject: nil, owner_id: owner.id, partner_id: partner.id}

    #   {:error, errors} = Fight.insert(fight)

    #   assert errors == %{subject: ["can't be blank"]}
    # end
  end

  describe "add an action" do
    test "can add an action to a fight" do
      fight = %{subject: "dude, stop", users: [@owner, @partner]}
      {:ok, fight} = Fight.insert(fight)

      act = Fight.add_action(fight, "starting the fight")
      assert act = %Action{name: "starting the fight"}
    end
  end
end
