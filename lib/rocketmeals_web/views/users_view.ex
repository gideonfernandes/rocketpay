defmodule RocketmealsWeb.UsersView do
  use RocketmealsWeb, :view

  alias Rocketmeals.User

  def render("create.json", %{user: %User{} = user}), do: %{message: "User created", user: user}
  def render("user.json", %{user: %User{} = user}), do: %{user: user}

  def render("index.json", %{users: users}) do
    Enum.map(users, fn user -> %{user: user} end)
  end
end
