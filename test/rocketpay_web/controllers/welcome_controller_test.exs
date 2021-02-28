defmodule RocketpayWeb.WelcomeControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.Numbers

  describe "index/2" do
    test "when the filename is valid, sum the numbers", %{conn: conn} do
      filename = "numbers"

      response =
        conn
        |> get(Routes.welcome_path(conn, :index, filename))
        |> json_response(:ok)

      {:ok, %{result: result}} =
        filename
        |> Numbers.sum_from_file()

      assert %{"message" => "Welcome to Rocketpay API. Here is your number #{result}"} == response
    end

    test "when the filename is invalid, returns an error", %{conn: conn} do
      filename = "banana"

      response =
        conn
        |> get(Routes.welcome_path(conn, :index, filename))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid file!"} == response
    end
  end
end
