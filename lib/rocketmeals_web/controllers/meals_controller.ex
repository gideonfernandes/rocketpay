defmodule RocketmealsWeb.MealsController do
  use RocketmealsWeb, :controller

  alias Rocketmeals.Meal

  alias RocketmealsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Rocketmeals.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{}} <- Rocketmeals.delete_meal(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, _params) do
    with {:ok, meals} <- Rocketmeals.index_meals() do
      conn
      |> put_status(:ok)
      |> render("index.json", meals: meals)
    end
  end

  def update(conn, params) do
    with {:ok, %Meal{} = meal} <- Rocketmeals.update_meal(params) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- Rocketmeals.get_meal(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end
end
