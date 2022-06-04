defmodule FightFair.UserTest do
  use ExUnit.Case, async: true
  alias FightFair.User

  describe "new/2" do
    test "create new user" do
      name = "Dylan Frazier"
      email = "dfra@gmail.com"

      assert {:ok,
              %{
                id: nil,
                name: ^name,
                email: ^email,
                fight_ids: []
              }}
              = User.new(name, email)
    end

    test "invalid new user" do
      assert {:error, :missing_required_arguments} = User.new()
      assert {:error, :missing_required_arguments} = User.new("name")
    end
  end
end
