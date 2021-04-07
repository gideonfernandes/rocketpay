defmodule Rocketmeals do
  alias Rocketmeals.Meals.Create, as: CreateMeal
  alias Rocketmeals.Meals.Delete, as: DeleteMeal
  alias Rocketmeals.Meals.Get, as: GetMeal
  alias Rocketmeals.Meals.Index, as: IndexMeal
  alias Rocketmeals.Meals.Update, as: UpdateMeal
  alias Rocketmeals.Users.Create, as: CreateUser
  alias Rocketmeals.Users.Delete, as: DeleteUser
  alias Rocketmeals.Users.Get, as: GetUser
  alias Rocketmeals.Users.Index, as: IndexUser
  alias Rocketmeals.Users.Update, as: UpdateUser

  defdelegate create_meal(params), to: CreateMeal, as: :call
  defdelegate delete_meal(id), to: DeleteMeal, as: :call
  defdelegate get_meal(id), to: GetMeal, as: :call
  defdelegate index_meals(), to: IndexMeal, as: :call
  defdelegate update_meal(params), to: UpdateMeal, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate get_user(id), to: GetUser, as: :call
  defdelegate index_users(), to: IndexUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call
end
