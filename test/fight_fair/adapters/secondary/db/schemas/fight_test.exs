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
    test "connect a new fight to an existing user" do
      assert {:ok, user} = UserRepo.insert(@user)
      assert {:ok, fight} = FightDomain.new(@subject, user)

      assert %Ecto.Changeset{} = changeset = Fight.insert_changeset(fight)
      IO.inspect(changeset, label: "in test, changeset for Fight")

      assert {:ok, fight_domain} = FightFair.Repo.insert_or_update(changeset)

      refute fight_domain.id == nil
    end

    # test "2 connect a new fight to an existing user" do
    #   assert {:ok, user} = UserRepo.insert(@user)
    #   assert {:ok, fight} = FightDomain.new(@subject, user)

    #   assert %Ecto.Changeset{} = changeset = Fight.insert(fight)
    #   assert {:ok, fight_domain} = FightFair.Repo.insert(changeset)
    #   fight_domain = FightFair.Repo.preload(fight_domain, :users)
    #   assert %Ecto.Changeset{} = changeset = Fight.add_users(fight)
    #   assert {:ok, fight_domain} = FightFair.Repo.update(changeset)



    #   refute fight_domain.id == nil
    # end
  end
end
