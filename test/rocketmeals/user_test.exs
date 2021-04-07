defmodule Rocketmeals.UserTest do
  use Rocketmeals.DataCase, async: true

  import Rocketmeals.Factory

  alias Ecto.Changeset
  alias Rocketmeals.User

  describe "changeset/3" do
    test "returns a valid changeset when all params are valid" do
      params = build(:user_params)
      meal = build(:meal)

      response = User.changeset(params, meal)

      assert %Changeset{changes: %{nome: "Gideon Fernandes"}, valid?: true} = response
    end

    test "returns an invalid changeset when there are some error" do
      params = build(:user_params, %{"cpf" => "123"})
      meal = build(:meal)

      response = User.changeset(params, meal)

      expected_response = %{
        cpf: ["should be 11 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
