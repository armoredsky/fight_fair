defmodule FightFair.Adapter.ActionRepoTest do
  use FightFair.RepoCase
  alias FightFair.Adapter.ActionRepo
  alias FightFair.Action, as: ActionDomain
  doctest FightFair.Adapter.ActionRepo

  # describe "insert" do
  #   test "an action returns an action with id" do
  #     name = :start_fight
  #     action = %ActionDomain{name: name}

  #     assert {:ok, %ActionDomain{
  #       id: id,
  #       name: ^name,
  #     }} = ActionRepo.insert(action)

  #     refute id == nil
  #   end

  #   test "an action without a name fails test" do
  #     action = %ActionDomain{name: ""}
  #     assert {:error, %Ecto.Changeset{}} = ActionRepo.insert(action)
  #   end
  # end

  # describe "get" do
  #   test "an action" do
  #     {:ok, action} = ActionRepo.insert(%ActionDomain{name: :timeout})

  #     assert {:ok, fetched_action } = ActionRepo.get(action.id)

  #     assert fetched_action.id == action.id
  #     assert fetched_action.name == action.name
  #   end

  #   # some failure test would be nice
  # end
end
