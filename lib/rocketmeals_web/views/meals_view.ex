defmodule RocketmealsWeb.MealsView do
  use RocketmealsWeb, :view

  alias Rocketmeals.Meal

  def render("create.json", %{meal: %Meal{} = meal}), do: %{message: "Meal created", meal: meal}
  def render("meal.json", %{meal: %Meal{} = meal}), do: %{meal: meal}

  def render("index.json", %{meals: meals}) do
    Enum.map(meals, fn meal -> %{meal: meal} end)
  end
end
