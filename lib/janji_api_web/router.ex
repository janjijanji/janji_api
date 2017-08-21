defmodule JanjiApiWeb.Router do
  use JanjiApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JanjiApiWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end
end
