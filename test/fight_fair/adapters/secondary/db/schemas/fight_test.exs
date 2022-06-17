defmodule FightFair.Adapter.Db.FightTest do
  use FightFair.RepoCase
  alias FightFair.Db.Fight
  alias FightFair.Fight, as: FightDomain
  alias FightFair.User, as: UserDomain
  alias FightFair.Adapter.UserRepo
  doctest FightFair.Db.Fight

  @user %UserDomain{name: "michael", email: "m@gmail.com"}
  @subject "ain't gona take it"

  describe "insert_changeset" do
    test "connect a new fight to 2 existing user" do
      assert {:ok, user} = UserRepo.insert(@user)
      assert {:ok, partner} = UserRepo.insert(%UserDomain{name: "lara", email: "l@gmail.com"})
      assert {:ok, fight} = FightDomain.new(@subject, user, partner)

      assert %Ecto.Changeset{} = changeset = Fight.insert_changeset(fight)

      assert {:ok, fight_schema} = FightFair.Repo.insert_or_update(changeset)

      refute fight_schema.id == nil
      assert Enum.count(fight_schema.users) == 2
    end

    test "connect a new fight to 2 new user" do
      partner = %UserDomain{name: "lara", email: "l@gmail.com"}
      assert {:ok, fight} = FightDomain.new(@subject, @user, partner)

      assert %Ecto.Changeset{} = changeset = Fight.insert_changeset(fight)

      assert {:ok, fight_schema} = FightFair.Repo.insert_or_update(changeset)

      refute fight_schema.id == nil
      assert Enum.count(fight_schema.users) == 2
    end

    test "connect a new fight to 1 new user and 1 existing" do
      assert {:ok, user} = UserRepo.insert(@user)
      partner = %UserDomain{name: "lara", email: "l@gmail.com"}
      assert {:ok, fight} = FightDomain.new(@subject, user, partner)

      assert %Ecto.Changeset{} = changeset = Fight.insert_changeset(fight)

      assert {:ok, fight_schema} = FightFair.Repo.insert_or_update(changeset)

      refute fight_schema.id == nil
      assert Enum.count(fight_schema.users) == 2
    end
  end
end
