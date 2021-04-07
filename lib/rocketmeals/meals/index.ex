defmodule Rocketmeals.Meals.Index do
  alias Rocketmeals.{Error, Meal, Repo}

  def call do
    with [%Meal{} | _tail] = meals <- Repo.all(Meal) do
      {:ok, meals}
    else
      [] -> {:error, Error.build_meals_not_found_error()}
    end
  end
end
