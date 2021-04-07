defmodule Rocketmeals.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table :meals do
      add :descricao, :string
      add :data, :naive_datetime
      add :calorias, :integer

      timestamps()
    end

    create constraint(:meals, :calorias_must_be_positive, check: "calorias > 0")
  end
end
