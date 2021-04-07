defmodule Rocketmeals.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table :users do
      add :nome, :string
      add :cpf, :string
      add :email, :string
      add :meal_id, references(:meals, type: :binary_id)

      timestamps()
    end

    create unique_index(:users, [:cpf])
    create unique_index(:users, [:email])
  end
end
