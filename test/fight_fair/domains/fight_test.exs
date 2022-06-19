defmodule FightFair.FightTest do
  use ExUnit.Case, async: true
  alias FightFair.{Fight, User}

  setup_all do
    {:ok, user} = User.new("name", "email")
    {:ok, partner} = User.new("partner", "email")
    [user: user, partner: partner]
  end

  describe "new/2" do
    test "create new Fight", state do
      subject = "Laundry never done on time"

      assert {:ok,
              %{
                subject: ^subject,
                users: users,
                start_date: start_date,
                end_date: end_date,
                actions: []
              }} = Fight.new(subject, state.user, state.partner)

      assert users == [state.user, state.partner]
      refute start_date == nil
      assert end_date == nil
    end

    test "invalid new Fight" do
      assert {:error, :invalid_arguments} = Fight.new(111, 1, 1)
      assert {:error, :invalid_arguments} = Fight.new("subject", "user_id", "partner_id")
    end
  end
end
