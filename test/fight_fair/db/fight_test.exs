defmodule FightFair.Db.FightTest do
  use FightFair.RepoCase
  alias FightFair.Db.{Fight, User}
  doctest FightFair.Db.Fight

  @owner %User{name: "michael", email: "eMMe@gmail.com"}
  @partner %User{name: "lara", email: "l@gmail.com"}

  test "a fight has a subject, owner, and partner" do
    fight = %Fight{}
    assert fight.subject == nil
    assert fight.owner_id == nil
    assert fight.partner_id == nil
  end

  describe "changeset" do
    test "subject is required" do
      fight = %{subject: nil, owner_id: 1, partner_id: 2}
      changeset = Fight.changeset(fight)
      assert changeset.errors == [subject: {"can't be blank", [validation: :required]}]
    end

    test "owner_id is required" do
      fight = %{subject: "dude, stop", owner_id: nil, partner_id: 2}
      changeset = Fight.changeset(fight)
      assert changeset.errors == [owner_id: {"can't be blank", [validation: :required]}]
    end

    test "partner_id is required" do
      fight = %{subject: "dude, stop", owner_id: 1, partner_id: nil}
      changeset = Fight.changeset(fight)
      assert changeset.errors == [partner_id: {"can't be blank", [validation: :required]}]
    end
  end

  describe "insert" do
    test "inserting a fight returns a fight with id" do
      owner = Repo.insert!(@owner)
      partner = Repo.insert!(@partner)
      fight = %{subject: "dude, stop", owner_id: owner.id, partner_id: partner.id}

      {:ok, fight} = Fight.insert(fight)

      assert fight.id >= 1
    end

    test "inserting an invalid fight returns the errors" do
      owner = Repo.insert!(@owner)
      partner = Repo.insert!(@partner)
      fight = %{subject: nil, owner_id: owner.id, partner_id: partner.id}

      {:error, errors} = Fight.insert(fight)

      assert errors == %{subject: ["can't be blank"]}
    end
  end
end
