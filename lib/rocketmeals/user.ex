defmodule Rocketmeals.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rocketmeals.Meal

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:nome, :cpf, :email]
  @derive {Jason.Encoder, only: [:id, :meal] ++ @required_params}

  schema "users" do
    field :nome, :string
    field :cpf, :string
    field :email, :string
    belongs_to :meal, Meal

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, meal) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cpf, is: 11)
    |> unique_constraint([:cpf])
    |> unique_constraint([:email])
    |> put_assoc(:meal, meal)
  end
end
