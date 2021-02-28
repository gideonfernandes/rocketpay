defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      params = %{
        name: "Gideon",
        password: "123456",
        nickname: "gidex",
        email: "gideon@gmail.com",
        age: 22
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make a deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "50.00", "id" => _id, "user_id" => _user_id},
               "message" => "Balance changed successfully!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid value!"}

      assert response == expected_response
    end
  end

  describe "withdraw/2" do
    setup %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      params = %{
        name: "Gideon",
        password: "123456",
        nickname: "gidex",
        email: "gideon@gmail.com",
        age: 22
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make a withdraw", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))

      response =
        conn
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "0.00", "id" => _id, "user_id" => _user_id},
               "message" => "Balance changed successfully!"
             } = response
    end

    test "when withdraw value is greater than current balance", %{
      conn: conn,
      account_id: account_id
    } do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => %{"balance" => ["is invalid"]}}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid value!"}

      assert response == expected_response
    end
  end

  describe "transaction/3" do
    setup %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      first_account_params = %{
        name: "Gideon",
        password: "123456",
        nickname: "gidex",
        email: "gideon@gmail.com",
        age: 22
      }

      second_account_params = %{
        name: "Herika",
        password: "123456",
        nickname: "etinha",
        email: "herika@gmail.com",
        age: 21
      }

      deposit_params = %{"value" => "100.05"}

      {:ok, %User{account: %Account{id: from_id}}} = Rocketpay.create_user(first_account_params)
      {:ok, %User{account: %Account{id: to_id}}} = Rocketpay.create_user(second_account_params)

      conn
      |> post(Routes.accounts_path(conn, :deposit, from_id, deposit_params))

      {:ok, conn: conn, from_id: from_id, to_id: to_id}
    end

    test "when all params are valid, make a transaction", %{
      conn: conn,
      from_id: from_id,
      to_id: to_id
    } do
      params = %{from: from_id, to: to_id, value: "50"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :transaction, params))
        |> json_response(:ok)

      assert %{
               "message" => "Transaction done successfully!",
               "transaction" => %{
                 "from_account" => %{"balance" => "50.05", "id" => _from_id},
                 "to_account" => %{"balance" => "50.00", "id" => _to_id}
               }
             } = response
    end

    test "when transaction value is greater than current from account balance", %{
      conn: conn,
      from_id: from_id,
      to_id: to_id
    } do
      params = %{from: from_id, to: to_id, value: "100.10"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :transaction, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"balance" => ["is invalid"]}} == response
    end

    test "when there are invalid params, returns an error", %{
      conn: conn,
      from_id: from_id,
      to_id: to_id
    } do
      params = %{from: from_id, to: to_id, value: "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :transaction, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid value!"} == response
    end
  end
end
