defmodule Rocketmeals.MealTest do
  use Rocketmeals.DataCase, async: true

  import Rocketmeals.Factory

  alias Ecto.Changeset
  alias Rocketmeals.Meal

  describe "changeset/2" do
    test "returns a valid changeset when all params are valid" do
      params = build(:meal_params)

      response = Meal.changeset(params)

      assert %Changeset{changes: %{descricao: "Banana Abananada"}, valid?: true} = response
    end

    test "returns an invalid changeset when there are some error" do
      params = build(:meal_params, %{"data" => "123"})

      response = Meal.changeset(params)

      expected_response = %{data: ["is invalid"]}

      assert errors_on(response) == expected_response
    end
  end
end
