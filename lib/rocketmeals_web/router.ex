defmodule RocketmealsWeb.Router do
  use RocketmealsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RocketmealsWeb do
    pipe_through :api

    resources "/meals", MealsController, except: [:new, :edit]
    resources "/users", UsersController, except: [:new, :edit]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketmealsWeb.Telemetry
    end
  end
end
