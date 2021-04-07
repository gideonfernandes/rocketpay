defmodule Rocketmeals.Users.CreateTest do
  use Rocketmeals.DataCase, async: true

  import Rocketmeals.Factory

  alias Rocketmeals.{Error, User}
  alias Rocketmeals.Users.Create

  describe "call/1" do
    test "returns an user when all params are valid" do
      meal = insert(:meal)
      params = build(:user_params, %{"meal_id" => meal.id})

      response = Create.call(params)

      assert {:ok, %User{email: "gideon@gmail.com"}} = response
    end

    test "returns an error when there are invalid params" do
      meal = insert(:meal)
      params = %{"meal_id" => meal.id, "cpf" => "123"}

      response = Create.call(params)

      expected_response = %{
        cpf: ["should be 11 character(s)"],
        email: ["can't be blank"],
        nome: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
