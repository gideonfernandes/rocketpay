defmodule Rocketmeals.Users.Get do
  alias Ecto.UUID
  alias Rocketmeals.{Error, Repo, User}

  def call(id) do
    with {:ok, _uuid} <- UUID.cast(id), %User{} = user <- get_user_with_meals(id) do
      {:ok, user}
    else
      :error -> {:error, Error.build_uuid_format_error()}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  defp get_user_with_meals(id) do
    Repo.get(User, id)
    |> Repo.preload(:meal)
  end
end
