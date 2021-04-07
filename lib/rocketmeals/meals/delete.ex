defmodule Rocketmeals.Meals.Delete do
  alias Ecto.UUID
  alias Rocketmeals.{Error, Meal, Repo}

  def call(id) do
    with {:ok, _uuid} <- UUID.cast(id), %Meal{} = meal <- Repo.get(Meal, id) do
      Repo.delete(meal)
    else
      :error -> {:error, Error.build_uuid_format_error()}
      nil -> {:error, Error.build_meal_not_found_error()}
    end
  end
end
