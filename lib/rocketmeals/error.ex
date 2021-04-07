defmodule Rocketmeals.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result), do: %__MODULE__{status: status, result: result}
  def build_uuid_format_error, do: build(:bad_request, "Invalid UUID format!")
  def build_meal_not_found_error, do: build(:not_found, "Meal not found!")
  def build_meals_not_found_error, do: build(:not_found, "Meals not found!")
  def build_user_not_found_error, do: build(:not_found, "User not found!")
  def build_users_not_found_error, do: build(:not_found, "Users not found!")
end
