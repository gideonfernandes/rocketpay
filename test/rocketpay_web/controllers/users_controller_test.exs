defmodule RocketpayWeb.UsersControllerTest do
  use RocketpayWeb.ConnCase, async: true

  describe "create/2" do
    setup %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn}
    end

    test "when all params are valid, create an user", %{conn: conn} do
      params = %{
        name: "Gideon",
        password: "123456",
        nickname: "gidex",
        email: "gideon@gmail.com",
        age: 22
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created",
               "user" => %{
                 "account" => %{
                   "balance" => "0.00",
                   "id" => _id
                 },
                 "id" => _account_id,
                 "name" => "Gideon",
                 "nickname" => "gidex"
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: "",
        password: "12345",
        nickname: "",
        email: "gideon_gmail.com",
        age: 17
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "age" => ["must be greater than or equal to 18"],
                 "email" => ["has invalid format"],
                 "name" => ["can't be blank"],
                 "nickname" => ["can't be blank"],
                 "password" => ["should be at least 6 character(s)"]
               }
             } == response
    end
  end
end
