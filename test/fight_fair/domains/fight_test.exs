defmodule FightFair.FightTest do
  use ExUnit.Case, async: true
  alias FightFair.{Fight, User}

  setup_all do
    {:ok, user} = User.new("name", "email")
    [user: user]
  end

  describe "new/2" do
    test "create new Fight", state do
      subject = "Laundry never done on time"

      assert {:ok,
              %{
                subject: ^subject,
                users: users
                # start_date: datetime, # assert this
                # actions: actions #assert this
              }} =
               Fight.new(subject, state.user)

      assert users == [state.user]
    end

    test "invalid new Fight" do
      assert {:error, :invalid_arguments} = Fight.new(111, 1)
      assert {:error, :invalid_arguments} = Fight.new("subject", "user_id")
    end
  end

  # describe "add_action/3" do
  #   test "successfully add an action" do
  #     subject = "Laundry never done on time"
  #     user_id = 10
  #     {:ok, fight} = Fight.new(subject, user_id)

  #     assert {:ok,
  #             %{
  #               subject: ^subject,
  #               actions: actions
  #             }} = Fight.add_action(fight, :timeout, user_id)

  #     assert Enum.count(actions) == 2
  #   end

  #   test "fail to add an action" do
  #     subject = "Laundry never done on time"
  #     user_id = 10
  #     {:ok, fight} = Fight.new(subject, user_id)

  #     assert {:error, :unknown_action_name} == Fight.add_action(fight, :dude, user_id)
  #     assert {:error, :uninvited_user_action} == Fight.add_action(fight, :out_of_bounds, 10000)
  #   end
  # end
end
