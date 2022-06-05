defmodule FightFair.Adapter.FightRepoTest do
  use FightFair.RepoCase
  alias FightFair.Adapter.FightRepo
  alias FightFair.Fight, as: FightDomain
  doctest FightFair.Adapter.FightRepo

  describe "insert" do
    test "inserting a Fight returns a Fight with id" do
      subject = "a_subject"
      fight = %FightDomain{subject: subject}

      assert {:ok,
              %FightDomain{
                id: id,
                subject: ^subject
              }} = FightRepo.insert(fight)
    end

    test "inserting fight without a subject fails test" do
      fight = %FightDomain{subject: ""}
      assert {:error, %Ecto.Changeset{}} = FightRepo.insert(fight)
    end
  end

  describe "get" do
    test "a fight" do
      {:ok, fight} = FightRepo.insert(%FightDomain{subject: "a"})

      assert {:ok, fetched_fight} = FightRepo.get(fight.id)

      assert fetched_fight.id == fight.id
      assert fetched_fight.subject == fight.subject
    end
  end

  describe "get_all" do
    test "fights for a given user_id" do
      assert 1 == 2
    end
  end

  describe "add_action" do
    test "to a fight with a proper action name and user_id" do
      assert 1 == 2
    end

    test "with improper action name fails test" do
      assert 1 == 2
    end

    test "with uninvited user fails test" do
      assert 1 == 2
    end
  end
end
