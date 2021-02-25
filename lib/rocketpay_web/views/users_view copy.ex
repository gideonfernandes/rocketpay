defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.{Account}

  def render("update.json", %{
        account: %Account{
          id: id,
          balance: balance,
          user_id: user_id
        }
      }) do
    %{
      message: "Deposit executed!",
      account: %{
        id: id,
        balance: balance,
        user_id: user_id
      }
    }
  end
end
