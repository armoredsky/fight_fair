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

  # describe "get" do
  #   test "a fight" do
  #     {:ok, fight} = FightRepo.insert(%FightDomain{subject: "a"})

  #     assert {:ok, fetched_fight} = FightRepo.get(fight.id)

  #     assert fetched_fight.id == fight.id
  #     assert fetched_fight.subject == fight.subject
  #   end
  # end
end
