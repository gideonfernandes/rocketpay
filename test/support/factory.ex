defmodule Rocketmeals.Factory do
  use ExMachina.Ecto, repo: Rocketmeals.Repo

  alias Rocketmeals.{Meal, User}

  def user_factory do
    %User{
      id: "692de2dd-ab3f-4681-979e-c3394447bb12",
      nome: "Gideon Fernandes",
      email: "gideon@gmail.com",
      cpf: "12345678910",
      meal: build(:meal)
    }
  end

  def user_params_factory do
    %{
      "id" => "692de2dd-ab3f-4681-979e-c3394447bb12",
      "nome" => "Gideon Fernandes",
      "email" => "gideon@gmail.com",
      "cpf" => "12345678910"
    }
  end

  def meal_factory do
    %Meal{
      descricao: "Banana Abananada",
      data: "2021-04-03T23:50:07",
      calorias: 23
    }
  end

  def meal_params_factory do
    %{
      "descricao" => "Banana Abananada",
      "data" => "2021-04-03T23:50:07",
      "calorias" => 23
    }
  end
end
