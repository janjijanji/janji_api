defmodule JanjiApiWeb.Router do
  use JanjiApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug JanjiApiWeb.Auth, repo: JanjiApi.Repo
  end

  scope "/api", JanjiApiWeb do
    pipe_through [:api, :api_auth]

    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/promise_makers", PromiseMakerController, except: [:new, :edit]
    resources "/promise_maker_positions", PromiseMakerPositionController, except: [:new, :edit]
    resources "/promise_maker_terms", PromiseMakerTermController, except: [:new, :edit]

    resources "/promises", PromiseController, except: [:new, :edit]
    resources "/promise_posts", PromisePostController, except: [:new, :edit]
    resources "/promise_post_votes", PromisePostVoteController, except: [:new, :edit]

    resources "/users", UserController, except: [:new, :edit]
  end
end
