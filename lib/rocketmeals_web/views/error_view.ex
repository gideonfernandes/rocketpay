defmodule RocketmealsWeb.ErrorView do
  use RocketmealsWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def render("error.json", %{result: %Changeset{} = changeset}), do: error_messages(changeset)
  def render("error.json", %{result: result}), do: %{message: result}
  defp error_messages(changeset), do: %{message: display_errors(changeset)}
  defp display_errors(changeset), do: traverse_errors(changeset, &traverse_error/1)
  defp traverse_error({msg, key}), do: reduce_messages(msg, key)
  defp reduce_messages(msg, key), do: Enum.reduce(key, msg, &replace_message(&1, &2))
  defp replace_message({key, value}, acc), do: String.replace(acc, "%{#{key}}", to_string(value))

  def template_not_found(template, _assigns), do: %{errors: %{detail: get_error_detail(template)}}
  defp get_error_detail(template), do: Phoenix.Controller.status_message_from_template(template)
end
