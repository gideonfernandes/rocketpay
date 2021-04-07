defmodule Rocketmeals.Meals.Update do
  alias Ecto.UUID
  alias Rocketmeals.{Error, Meal, Repo}

  def call(%{"id" => id} = params) do
    with {:ok, _uuid} <- UUID.cast(id), %Meal{} = meal <- Repo.get(Meal, id) do
      do_update(meal, params)
    else
      :error -> {:error, Error.build_uuid_format_error()}
      nil -> {:error, Error.build_meal_not_found_error()}
    end
  end

  defp do_update(meal, params) do
    meal
    |> Meal.changeset(params)
    |> Repo.update()
  end
end
