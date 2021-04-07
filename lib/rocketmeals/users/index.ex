defmodule Rocketmeals.Users.Index do
  alias Rocketmeals.{Error, Repo, User}

  def call do
    with [%User{} | _tail] = users <- get_users_with_meals() do
      {:ok, users}
    else
      [] -> {:error, Error.build_users_not_found_error()}
    end
  end

  defp get_users_with_meals() do
    Repo.all(User)
    |> Repo.preload(:meal)
  end
end
