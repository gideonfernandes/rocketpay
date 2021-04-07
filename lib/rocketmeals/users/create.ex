defmodule Rocketmeals.Users.Create do
  alias Rocketmeals.{Error, Meal, Repo, User}

  def call(%{"meal_id" => meal_id} = params) do
    with {:ok, %Meal{} = meal} <- Rocketmeals.get_meal(meal_id),
         {:ok, %User{} = result} <- create_user(params, meal) do
      {:ok, result}
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp create_user(params, meal) do
    params
    |> User.changeset(meal)
    |> Repo.insert()
  end
end
