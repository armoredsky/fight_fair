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
              }}
              = User.new(name, email)
    end

    test "invalid new user" do
      assert {:error, :invalid_arguments} = User.new(1, "email")
      assert {:error, :invalid_arguments} = User.new("name", 1)
    end
  end
end
