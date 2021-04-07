defmodule Rocketmeals.Users.Update do
  alias Ecto.UUID
  alias Rocketmeals.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    with {:ok, _uuid} <- UUID.cast(id), %User{} = user <- Repo.get(User, id) do
      do_update(user, params)
    else
      :error -> {:error, Error.build_uuid_format_error()}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
