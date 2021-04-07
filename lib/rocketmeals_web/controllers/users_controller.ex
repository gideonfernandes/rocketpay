defmodule RocketmealsWeb.UsersController do
  use RocketmealsWeb, :controller

  alias Rocketmeals.User

  alias RocketmealsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketmeals.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Rocketmeals.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, _params) do
    with {:ok, users} <- Rocketmeals.index_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Rocketmeals.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rocketmeals.get_user(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
